import 'package:flutter/widgets.dart';

class StoreProvider<T> extends InheritedWidget {

  final T store;

  StoreProvider({
    Key? key,
    required this.store,
    Widget? child,
  })  : super(key: key, child: child!);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static T of<@required T>(BuildContext context) {

    StoreProvider storeProvider = context.dependOnInheritedWidgetOfExactType<StoreProvider<T>>() as StoreProvider<T>;
    return storeProvider.store;
  }
}