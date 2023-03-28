import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/argument_detail.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/background_services.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/notification_helper.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/shared_preference_app.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/detail_restaurant_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/favorites_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/home_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/search_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/bloc/setting_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/bloc/setting_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/pages/settings_page.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/pages/splash_page.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/router_app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/navigation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharePreferencesApp.getInstance();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RestaurantBloc(),
        ),
        BlocProvider(
          create: (context) => SettingBlocCubit()..getSetting(),
        )
      ],
      child: BlocBuilder<SettingBlocCubit, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Moo Makan',
            theme: getTheme(state, context),
            navigatorKey: navigatorKey,
            initialRoute: RouterAppPath.splashPage,
            routes: {
              RouterAppPath.splashPage: (context) => const SplashPage(),
              RouterAppPath.homePage: (context) => const HomePage(),
              RouterAppPath.searchPage: (context) => const SearchPage(),
              RouterAppPath.detailRestaurantPage: (context) {
                final routeData = (ModalRoute.of(context)!.settings.arguments
                    as DetailArguments);
                return DetailRestaurantPage(
                  restaurantModel: routeData.dataRestaurant,
                  isFromFavorites: routeData.isFromFavorite,
                );
              },
              RouterAppPath.favoritesRestaurantPage: (context) =>
                  const FavoritesPage(),
              RouterAppPath.settingsPage: (context) => const SettingsPage(),
            },
          );
        },
      ),
    );
  }

  ThemeData getTheme(SettingState state, BuildContext context) {
    final isStateSettingSuccess = state is SettingSettingSuccess;
    if (isStateSettingSuccess) {
      if (state.isDarkTheme) return ThemeCustom.darkThemeData(context);
      return ThemeCustom.lightThemeData(context);
    }
    return ThemeCustom.lightThemeData(context);
  }
}
