import 'package:flutter/widgets.dart';
import 'package:store/store.dart';

class StoreProvider<T extends Store> extends InheritedWidget {

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

    StoreProvider storeProvider = context.dependOnInheritedWidgetOfExactType<StoreProvider>() as StoreProvider;
    return storeProvider.store as T;
  }
}