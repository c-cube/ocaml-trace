module A = Trace_core.Internal_.Atomic_

type 'a t = {
  mutex: Mutex.t;
  cond: Condition.t;
  q: 'a Mpsc_bag.t;
  mutable closed: bool;
  consumer_waiting: bool A.t;
}

exception Closed

let create () : _ t =
  {
    mutex = Mutex.create ();
    cond = Condition.create ();
    q = Mpsc_bag.create ();
    closed = false;
    consumer_waiting = A.make false;
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
  if A.get self.consumer_waiting then (
    (* wakeup consumer *)
    Mutex.lock self.mutex;
    Condition.broadcast self.cond;
    Mutex.unlock self.mutex
  )

let rec pop_all (self : 'a t) : 'a list =
  match Mpsc_bag.pop_all self.q with
  | Some l -> l
  | None ->
    if self.closed then raise Closed;
    Mutex.lock self.mutex;
    A.set self.consumer_waiting true;
    (* check again, a producer might have pushed an element since we
       last checked. However if we still find
       nothing, because this comes after [consumer_waiting:=true],
       any producer arriving after that will know to wake us up. *)
    (match Mpsc_bag.pop_all self.q with
    | Some l ->
      A.set self.consumer_waiting false;
      Mutex.unlock self.mutex;
      l
    | None ->
      if self.closed then (
        Mutex.unlock self.mutex;
        raise Closed
      );
      Condition.wait self.cond self.mutex;
      A.set self.consumer_waiting false;
      Mutex.unlock self.mutex;
      pop_all self)
