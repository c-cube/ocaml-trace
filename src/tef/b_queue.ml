type 'a t = {
  mutex: Mutex.t;
  cond: Condition.t;
  q: 'a Mpsc_queue.t;
  mutable closed: bool;
  mutable consumer_waiting: bool;
}

exception Closed

let create () : _ t =
  {
    mutex = Mutex.create ();
    cond = Condition.create ();
    q = Mpsc_queue.create ();
    closed = false;
    consumer_waiting = false;
  }

let close (self : _ t) =
  Mutex.lock self.mutex;
  if not self.closed then (
    self.closed <- true;
    Condition.broadcast self.cond (* awake waiters so they fail  *)
  );
  Mutex.unlock self.mutex

let push (self : _ t) x : unit =
  if self.closed then raise Closed;
  Mpsc_queue.enqueue self.q x;
  if self.closed then raise Closed;
  if self.consumer_waiting then (
    (* wakeup consumer *)
    Mutex.lock self.mutex;
    Condition.broadcast self.cond;
    Mutex.unlock self.mutex
  )

let rec pop (self : 'a t) : 'a =
  match Mpsc_queue.dequeue self.q with
  | x -> x
  | exception Mpsc_queue.Empty ->
    if self.closed then raise Closed;
    Mutex.lock self.mutex;
    self.consumer_waiting <- true;
    Condition.wait self.cond self.mutex;
    self.consumer_waiting <- false;
    Mutex.unlock self.mutex;
    pop self

let rec pop_all (self : 'a t) : 'a list =
  match Mpsc_queue.dequeue_all self.q with
  | l -> l
  | exception Mpsc_queue.Empty ->
    if self.closed then raise Closed;
    Mutex.lock self.mutex;
    self.consumer_waiting <- true;
    Condition.wait self.cond self.mutex;
    self.consumer_waiting <- false;
    Mutex.unlock self.mutex;
    pop_all self
