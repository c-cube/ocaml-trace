type 'a t = {
  mutex: Mutex.t;
  cond: Condition.t;
  q: 'a Mpsc_bag.t;
  mutable closed: bool;
  consumer_waiting: bool Atomic.t;
}

exception Closed

let create () : _ t =
  {
    mutex = Mutex.create ();
    cond = Condition.create ();
    q = Mpsc_bag.create ();
    closed = false;
    consumer_waiting = Atomic.make false;
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
  Mpsc_bag.add self.q x;
  if self.closed then raise Closed;
  if Atomic.get self.consumer_waiting then (
    (* wakeup consumer *)
    Mutex.lock self.mutex;
    Condition.broadcast self.cond;
    Mutex.unlock self.mutex
  )

let rec pop_all (self : 'a t) : 'a list =
  match Mpsc_bag.pop_all self.q with
  | l -> List.rev l
  | exception Mpsc_bag.Empty ->
    if self.closed then raise Closed;
    Mutex.lock self.mutex;
    Atomic.set self.consumer_waiting true;
    Condition.wait self.cond self.mutex;
    Atomic.set self.consumer_waiting false;
    Mutex.unlock self.mutex;
    pop_all self
