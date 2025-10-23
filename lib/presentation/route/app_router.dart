import 'package:go_router/go_router.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/pages/detail_screen.dart';
import 'package:prueba_jairo_rios/presentation/pages/form_screen.dart';
import 'package:prueba_jairo_rios/presentation/pages/home_screen.dart';
import 'package:prueba_jairo_rios/presentation/route/string_rout_names.dart';

class AppRouter {
  static final GoRouter router =
      GoRouter(initialLocation: StringRoutNames.homeScreen, routes: [
    GoRoute(
        path: StringRoutNames.homeScreen,
        builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: StringRoutNames.detailScreen,
      builder: (context, state) =>
          DetailScreen(userInformation: state.extra as UserInformation),
    ),
    GoRoute(
        path: StringRoutNames.formScreen,
        builder: (context, state) => const FormScreen()),
  ]);
}
