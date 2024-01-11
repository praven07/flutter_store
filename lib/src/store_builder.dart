import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:store/store.dart';

class StoreBuilder<T extends Store, S> extends StatefulWidget {

  /// The [Store] that the builder is connected to and listens
  /// for state changes.
  final T store;

  /// This builder is used to build [Widget] based on the state of the [Store]
  final Widget Function(BuildContext, S) builder;

  const StoreBuilder({
    super.key,
    required this.store,
    required this.builder,
  });

  @override
  State<StoreBuilder<T, S>> createState() => _StoreBuilderState<T, S>();
}

class _StoreBuilderState<T extends Store, S>
    extends State<StoreBuilder<T, S>> {
  late S _stateSnapshot;
  StreamSubscription<S>? _subscription;

  @override
  void initState() {
    super.initState();
    assert(
    widget.store.initialState != null,
    "The provided store does not have an initial state.",
    );
    _stateSnapshot = widget.store.initialState;
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant StoreBuilder<T, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.store != widget.store) {
      _unsubscribe();
      _subscribe();
    }
  }

  void _subscribe() {
    _subscription = widget.store.state.listen((event) {
      setState(() {
        _stateSnapshot = event;
      });
    }) as StreamSubscription<S>?;
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _stateSnapshot);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }
}
