// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

abstract class _$AppRoute extends RootStackRouter {
  // ignore: unused_element
  _$AppRoute({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    TodoDetailsPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TodoDetailsPage(),
      );
    },
    TodoListPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TodoListPage(),
      );
    },
  };
}

/// generated route for
/// [SplashPage]
class SplashPageRoute extends PageRouteInfo<void> {
  const SplashPageRoute({List<PageRouteInfo>? children})
      : super(
          SplashPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TodoDetailsPage]
class TodoDetailsPageRoute extends PageRouteInfo<void> {
  const TodoDetailsPageRoute({List<PageRouteInfo>? children})
      : super(
          TodoDetailsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoDetailsPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TodoListPage]
class TodoListPageRoute extends PageRouteInfo<void> {
  const TodoListPageRoute({List<PageRouteInfo>? children})
      : super(
          TodoListPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoListPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
