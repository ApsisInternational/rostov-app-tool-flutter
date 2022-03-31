import 'package:flutter/material.dart';
import 'apsis_one.dart';

class ONERouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _trackScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    ApsisOne.trackScreenViewEvent('$screenName');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _trackScreenView(route);
    }
  }

  @override
  void didReplace({ Route<dynamic>? newRoute, Route<dynamic>? oldRoute }) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _trackScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _trackScreenView(previousRoute);
    }
  }
}