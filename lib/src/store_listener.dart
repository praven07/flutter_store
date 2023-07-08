import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:store/store.dart';

class StoreListener<@required T extends Store, @required S>
    extends StatefulWidget {
  final T store;
  final Function(S) listener;
  final Widget child;

  const StoreListener({
    super.key,
    required this.store,
    required this.listener,
    required this.child,
  });

  @override
  State<StoreListener> createState() => _StoreListenerState<T, S>();
}

class _StoreListenerState<@required T extends Store, @required S> extends State<StoreListener> {

  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription = widget.store.state.listen((action) {
      widget.listener(action);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
