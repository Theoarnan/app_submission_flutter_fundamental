import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/argument_detail.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/detail_restaurant_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/favorites_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/home_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/search_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/settings_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/router_app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RestaurantBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moo Makan',
        theme: ThemeCustom.themeSetting(),
        navigatorKey: navigationKey,
        initialRoute: RouterAppPath.homePage,
        routes: {
          RouterAppPath.splashPage: (context) => const SplashPage(),
          RouterAppPath.homePage: (context) => const HomePage(),
          RouterAppPath.searchPage: (context) => const SearchPage(),
          RouterAppPath.detailRestaurantPage: (context) => DetailRestaurantPage(
                restaurantModel: (ModalRoute.of(context)!.settings.arguments
                        as DetailArguments)
                    .dataRestaurant,
                isFromFavorites: (ModalRoute.of(context)!.settings.arguments
                        as DetailArguments)
                    .isFromFavorite,
              ),
          RouterAppPath.favoritesRestaurantPage: (context) =>
              const FavoritesPage(),
          RouterAppPath.settingsPage: (context) => const SettingsPage(),
        },
      ),
    );
  }
}
