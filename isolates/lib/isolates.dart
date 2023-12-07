import 'dart:async';

void futureExecutionOrder() {
  print('Start');

  Future(() {
    print('Future top started');
    Future(() => print('1'));
    Future.microtask(() => print('2'));
    Future(() => print('3'));
    print('Future top ended');
  });

  print('End');
}

void generators() {
  // Synchronous
  final generator = produce(10);
  print('${generator.first}');

  // Asynchronous
}

// Iterable a collection that generates elements as need (lazy), it does not have a fixed length
// Sync* -> this is a synchronous generator
Iterable<int> produce(int n) sync* {
  // i will only be created when the program needs it
  for (int i = 0; i <= n; i++) {
    yield i; // Same as return for generator
  }

  yield* produceSquare(n); // yield* to call nested genrators
}

Iterable<int> produceSquare(int n) sync* {
  for (int i = 0; i <= n; i++) {
    yield i * i;
  }
}

Stream<int> produceDoubled(int n) async* {
  for (int i = 0; i <= n; i++) {
    // Can await futures
    final result = await Future.delayed(Duration(seconds: 1), () => 2);
    yield i * result;
  }
}

// Future execution order

void futures() {
  final a = Future(() => 1).then(print);
  final b = Future(() => Future(() => 2)).then(print);

  Future.delayed(Duration(seconds: 3), () => 3).then(print);

  Future.value(4).then(print); // Immediate
  Future.value(Future(() => 5)).then(print); // Same as 53

  Future.sync(() => 6).then(print); // Same as 58
  Future.sync(() => Future(() => 7)).then(print); // Same as 59

  // Executed on priority queue
  Future.microtask(() => 8).then(print);
  Future.microtask(() => Future(() => 9)).then(print); // Same as 53

  // Then statements run immediately (as soon as the Future resolves), if there were chained then's they will be called
  // If another Future is started in then it will be added in event queue
  Future(() => 1)
      .then(print)
      .onError((error, stackTrace) => print(error))
      .whenComplete(() => print('Finally')); // Like finally on try catch
}

Future<int> awaitFutures() async {
  late final int a;

  a = await Future(() => 1);

  return a;
}

void streams() async {
  Stream.periodic(Duration(seconds: 1), (value) => value).listen((event) {
    print('STREAMED $event');
  });

  // Authority that emits values
  final StreamController controller = StreamController<int>();

  int value = 0;

  Timer.periodic(Duration(seconds: 1), (timer) {
    controller.add(value++);

    if (value > 10) {
      timer.cancel();
      controller.close();
    }
  });

  // Contains a stream
  // Subscriptions always listen until explicit cancel
  StreamSubscription subscription = controller.stream.listen(print);

  // Streams can only have one listener
  // Broadcast streams can be listened by n
  StreamController<int>.broadcast();

  // Await streams

  await controller.stream.forEach((element) {
    print('AWAITED $element');
  });
}

// In dart every event runs on a single thread, even futures

// Mutator (single) thread -> Is where the events are dispatched
// Event -> instruction in dart ->  print(1 + 3)
// Event queue -> list of events
// Micro task queue -> list of events with higher priority (Micro task Futures are calculated first than other futures)
// Event loop -> Manager who processes events
// Event handler -> Decides what to do with the events, wait and process other events if they are future (asynchronous)
// Isolate heap vm memory keep a references to futures and events that are resolved

// Isolates have other threads for maintenance (garbage collection, etc.)

// Isolates groups -> x amount of isolates share the same memory, and make easier to make them communicate
