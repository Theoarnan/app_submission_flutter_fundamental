import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/home_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/router/router_app_path.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moo Makan',
      theme: ThemeCustom.themeSetting(),
      navigatorKey: navigationKey,
      initialRoute: RouterAppPath.splashPage,
      routes: {
        RouterAppPath.splashPage: (context) => const SplashPage(),
        RouterAppPath.homePage: (context) => const HomePage(),
        RouterAppPath.searchPage: (context) => Container(),
        RouterAppPath.detailRestaurantPage: (context) => Container(),
      },
    );
  }
}
