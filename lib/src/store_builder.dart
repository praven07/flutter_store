import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:store/store.dart';

class StoreBuilder<@required T extends Store, @required S> extends StatefulWidget {

  final T store;
  final Function(BuildContext, S) builder;

  const StoreBuilder({
    super.key,
    required this.store,
    required this.builder,
  });

  @override
  State<StoreBuilder> createState() => _StoreBuilderState<T, S>();
}

class _StoreBuilderState<@required T extends Store, @required S> extends State<StoreBuilder> {

  late StreamSubscription _streamSubscription;
  late S _state;

  @override
  void initState() {
    super.initState();

    /// Subscribes to the store state stream and calls the builder methods when
    /// state changes.
    _streamSubscription = widget.store.state.listen((state) {
      setState(() {
        _state = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _state);

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
