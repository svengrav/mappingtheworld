
import 'dart:collection';
import 'package:flutter/material.dart';
import 'event.dart';

typedef EventWidgetBuilder<T> = Widget Function(BuildContext context, T? value, Queue<EventState<T>> history);

class EventBuilder<T> extends StatefulWidget {
  const EventBuilder({
    super.key,
    required this.event,
    required this.builder,
    this.maxHistory = 10,
    this.child, 
  });

  final Event<T> event;
  final EventWidgetBuilder<T> builder;
  final Widget? child;
  final int maxHistory;

  @override
  State<StatefulWidget> createState() => _EventBuilderState<T>();
}

class _EventBuilderState<T> extends State<EventBuilder<T>> {
  EventListener<T>? listener;
  Queue<EventState<T>> history = Queue();
  EventState<T>? state;
  
  @override
  void initState() {
    super.initState();
    listener = EventListener<T>((eventState) { 
      if(state != null) {
        history.addLast(state!);
      }

      if(history.length > widget.maxHistory) {
        history.removeFirst();
      }

      setState(() {
        state = eventState;
      });
    });

    widget.event.subscribe(listener!);
  }

  @override
  void didUpdateWidget(EventBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.event != widget.event) {
      oldWidget.event.subscribe(listener!);
      widget.event.subscribe(listener!);
    }
  }

  @override
  void dispose() {
    widget.event.unsubscribe(listener!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state?.value, history);
  }
}