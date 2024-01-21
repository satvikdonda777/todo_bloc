import 'package:auto_route/auto_route.dart';
import 'package:todo_demo/features/splash/view/splash_page.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRoute extends _$AppRoute {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashPageRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: TodoListPageRoute.page,
        ),
        AutoRoute(
          page: TodoDetailsPageRoute.page,
        ),
      ];
}
