
import 'dart:async';
import '../../utils/disposable.dart';

typedef OnDataCallback<T> = void Function(EventState<T> args);

class EventListener<T> {
   final OnDataCallback<T> onData;
   const EventListener(this.onData);
}

class EventState<T> {
  final T? value;
  const EventState(this.value);
}

class _EventSubscription<T> implements Disposable {
  final EventListener<T> handler;
  final StreamSubscription<EventState<T>> subscription;

  const _EventSubscription(this.handler, this.subscription);
  
  @override
  void dispose() {
    subscription.cancel();
  } 
}

class Event<T> implements Disposable {

  late final List<_EventSubscription<T>> _subscriptions = [];
  late final StreamController<EventState<T>> _controller = StreamController<EventState<T>>.broadcast();

  void subscribe(EventListener<T> handler) {
    var subscription = _controller.stream.listen(handler.onData);
    _subscriptions.add(_EventSubscription(handler, subscription));
  }

  void operator +(EventListener<T> handler) {
    subscribe(handler);
  }

  bool unsubscribe(EventListener<T> handler) {
    return _subscriptions.remove(_subscriptions.singleWhere((element) => element.handler == handler)..dispose());
  }

  bool operator -(EventListener<T> handler) {
    return unsubscribe(handler);
  }

  void unsubscribeAll() {
    for(var sub in _subscriptions) {
      sub.dispose();
    };
    _subscriptions.clear();
  }

  void broadcast(T? value) {
    if(_controller.hasListener) {
      _controller.add(EventState(value));
    }
  }

  @override
  String toString() {
    return runtimeType.toString();
  }
  
  @override
  void dispose() {
    _controller.close();
  }
}
