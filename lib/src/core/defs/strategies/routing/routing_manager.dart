import 'package:flutter/widgets.dart';

import '../../core/components/observable.dart';
import '../../helpers/debugging_printer.dart';

/// Interface for routing management operations.
abstract class RoutingManager<A> {
  /// The actor instance that will perform the routing operations.
  A get actor;

  /// Observable that tracks the current route.
  final currentRouteObs = Observable<String>('');

  /// Observable that tracks navigation history.
  final navigationHistoryObs = Observable<List<String>>([]);

  /// Observable that tracks the breadcrumb (fil d'ariane) navigation path.
  final breadcrumbObs = Observable<List<String>>([]);

  /// Route information provider for MaterialApp.Router.
  RouteInformationProvider? get routeInformationProvider;

  /// Route information parser for MaterialApp.Router.
  RouteInformationParser<Object>? get routeInformationParser;

  /// Router delegate for MaterialApp.Router.
  RouterDelegate<Object>? get routerDelegate;

  /// Router configuration for MaterialApp.Router.
  RouterConfig<Object>? get routerConfig;

  /// Back button dispatcher for MaterialApp.Router.
  BackButtonDispatcher? get backButtonDispatcher;

  /// Navigate to a new route.
  Future<T?> push<T extends Object?>(String route, {Object? arguments});

  /// Navigate to a new route and replace the current route.
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(String route,
      {Object? arguments, TO? result});

  /// Navigate to a new route and remove all previous routes.
  Future<T?> pushAndRemoveUntil<T extends Object?>(String route, RoutePredicate predicate,
      {Object? arguments});

  /// Navigate to a new route and clear the entire navigation stack.
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String route, RoutePredicate predicate,
      {Object? arguments});

  /// Navigate to a new route with a name.
  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments});

  /// Navigate to a new route with a name and replace the current route.
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(String routeName,
      {Object? arguments, TO? result});

  /// Pop the current route and return a result.
  Future<void> pop<T extends Object?>([T? result]);

  /// Pop routes until the predicate returns true.
  void popUntil(RoutePredicate predicate);

  /// Check if the route can be popped.
  bool canPop();

  /// Get the current route name.
  String get currentRoute => currentRouteObs.value;

  /// Get the navigation history.
  List<String> get navigationHistory => navigationHistoryObs.value;

  /// Get the current breadcrumb (fil d'ariane) navigation path.
  List<String> get breadcrumb => breadcrumbObs.value;

  /// Pre-routing hook that can be overridden.
  /// Called before any navigation operation.
  @mustCallSuper
  Future<bool> preRouting(String route, {Object? arguments}) async {
    Debugger.magenta("$RoutingManager pre-routing to: $route");
    return true; // Return true to allow navigation, false to prevent it
  }

  /// Post-routing hook that can be overridden.
  /// Called after any navigation operation completes.
  @mustCallSuper
  void postRouting(String route, {Object? arguments}) {
    Debugger.magenta("$RoutingManager post-routing from: $route");
    // Update observables
    currentRouteObs.value = route;
    final history = List<String>.from(navigationHistoryObs.value);
    if (!history.contains(route)) {
      history.add(route);
      navigationHistoryObs.value = history;
    }
    // Update breadcrumb
    final breadcrumb = List<String>.from(breadcrumbObs.value);
    breadcrumb.add(route);
    breadcrumbObs.value = breadcrumb;
  }

  /// Pre-pop hook that can be overridden.
  /// Called before popping a route.
  @mustCallSuper
  Future<bool> prePop([Object? result]) async {
    Debugger.magenta("$RoutingManager pre-pop from: $currentRoute");
    return true; // Return true to allow pop, false to prevent it
  }

  /// Post-pop hook that can be overridden.
  /// Called after popping a route.
  @mustCallSuper
  void postPop([Object? result]) {
    Debugger.magenta("$RoutingManager post-pop from: $currentRoute");
    // Update observables
    final history = List<String>.from(navigationHistoryObs.value);
    if (history.isNotEmpty) {
      history.removeLast();
      navigationHistoryObs.value = history;
      if (history.isNotEmpty) {
        currentRouteObs.value = history.last;
      } else {
        currentRouteObs.value = '';
      }
    }
    // Update breadcrumb
    final breadcrumb = List<String>.from(breadcrumbObs.value);
    if (breadcrumb.isNotEmpty) {
      breadcrumb.removeLast();
      breadcrumbObs.value = breadcrumb;
    }
  }
}
