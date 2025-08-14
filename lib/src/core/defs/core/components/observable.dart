import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Observable<T> with EquatableMixin {
  Observable(T defaultValue) : _value = defaultValue;

  late T _value;
  T get value => _value;
  set value(T newValue) {
    _value = newValue;
    // Create a copy of the listeners list to avoid concurrent modification
    final currentListeners = List<VoidCallback>.from(listeners);
    for (final listener in currentListeners) {
      if (listeners.contains(listener)) {
        listener.call();
      }
    }
  }

  final List<VoidCallback> listeners = [];

  void addListener(VoidCallback listener) {
    if (!listeners.contains(listener)) listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Observable(value: $value)';
}

class Observer<T> extends StatefulWidget {
  final Observable<T> observes;
  final Widget Function(BuildContext context, T value) builder;

  const Observer({super.key, required this.observes, required this.builder});

  @override
  State<StatefulWidget> createState() => _ObserverState<T>();
}

class _ObserverState<T> extends State<Observer<T>> {
  late T value;

  void valueChangesListener() => setState(() => value = widget.observes.value);

  @override
  void initState() {
    super.initState();
    value = widget.observes.value;
    widget.observes.addListener(valueChangesListener);
  }

  @override
  void didUpdateWidget(Observer<T> oldWidget) {
    if (oldWidget.observes != widget.observes) {
      oldWidget.observes.removeListener(valueChangesListener);
      value = widget.observes.value;
      widget.observes.addListener(valueChangesListener);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.observes.removeListener(valueChangesListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, value);
}

extension ObservableBoolExt on Observable<bool> {
  void enable() {
    if (value) return;
    value = true;
  }

  void disable() {
    if (!value) return;
    value = false;
  }

  void toggle() {
    value = !value;
  }
}

extension ObservableOptionalBoolExt on Observable<bool?> {
  void enable() {
    if ((value ?? false)) return;
    value = true;
  }

  void disable() {
    if (!(value ?? true)) return;
    value = false;
  }
}

extension OptionalObservableExt<T extends Object?> on Observable<T?> {
  void annihilate() {
    if (value != null) value = null;
  }

  bool get isNull => value == null;
}

extension ObservableListExt<T> on Observable<List<T>> {
  void clear() => value = <T>[];
}

extension ObservableSetExt<T> on Observable<Set<T>> {
  void clear() => value = <T>{};
}

extension ObsUsefullUpdater<T> on Observable<T?> {
  Future<bool> updateIfDifferent(T? newValue) {
    if (value != newValue) {
      value = newValue;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
