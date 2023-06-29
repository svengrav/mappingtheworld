typedef NotifierListeners = List<NotifierListener>;

/// Adds a simple notifier and listener interface to a class.
mixin Notifier {
  final NotifierListeners _listeners = [];

  /// Notify all listeners.
  void notify<T>(T sender, [NotifierListenerArgs? args]) {
    for(var listener in _listeners) {
      listener._notify(sender, args);
    }
  }

  /// Add listener to this notifier.
  void addListener<T>(NotifierListener listener) {
    if(!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// Removes listener from this notifier.
  void removeListener(NotifierListener listener) {
    if(_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }
}

/// Defines the notifier listener.
class NotifierListener<T, A extends NotifierListenerArgs> {
  NotifierListener(this.callback);

  final Function(T sender, A? args) callback;

  void _notify(T sender, [A? args]) {
    callback.call(sender, args);
  }
}

/// Defines the notifier listener arguments.
abstract class NotifierListenerArgs {
  const NotifierListenerArgs();
}

typedef OnValueChanged<T, A> = Function(T sender, ValueListenerArgs<A>? args);

class ValueListener<T, A> extends NotifierListener<T, ValueListenerArgs<A>> {
  ValueListener(OnValueChanged<T, A> callback) : super(callback);
}

class ValueListenerArgs<T> extends NotifierListenerArgs {
  const ValueListenerArgs(this.value);

  final T value;
}

