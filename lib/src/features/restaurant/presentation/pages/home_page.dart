import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/notification_helper.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/shared_preference_app.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/empty_error_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/home_header_section.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_restaurant.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/router_app_path.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantBloc>(context).add(GetAllDataRestaurant());
    _notificationHelper.configureSelectNotificationSubject(
      context,
      RouterAppPath.detailRestaurantPage,
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await selectNotificationSubject.drain();
    selectNotificationSubject.close();
  }

  String getAsset() {
    bool isDark = SharePreferencesApp.getThemeMode();
    if (isDark) return '${ConstantName.dirAssetImg}logo_dark.png';
    return '${ConstantName.dirAssetImg}logo.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Image.asset(
          getAsset(),
          width: 120,
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<RestaurantBloc>(context).add(
                GetAllDataRestaurant(),
              );
              Navigator.of(context).pushNamed(RouterAppPath.searchPage);
            },
            icon: const Icon(
              Icons.search,
              color: ThemeCustom.primaryColor,
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: ConstantName.constFavorites,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.bookmark),
                      SizedBox(width: 4),
                      Text('Favorites'),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: ConstantName.constSetting,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 4),
                      Text('Settings'),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: ConstantName.constLogout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.power_settings_new_rounded),
                      SizedBox(width: 4),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (value) {
              onSelectedProccess(value, context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderSection(),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoadingState) {
                    return const Expanded(
                      flex: 1,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is NoInternetState ||
                      state is RestaurantErrorState) {
                    final noInternetState = state is NoInternetState;
                    return Expanded(
                      child: EmptyErrorState(
                        imgAsset: noInternetState
                            ? '${ConstantName.dirAssetImg}no_internet.png'
                            : '${ConstantName.dirAssetImg}illustration_error.png',
                        title: 'Sorry,',
                        subTitle: noInternetState
                            ? "We we can't connect internet, please check your connection"
                            : 'We failed to load restaurant data',
                        withoutButton: false,
                        onPressed: () async {
                          BlocProvider.of<RestaurantBloc>(context)
                              .add(GetAllDataRestaurant());
                        },
                        titleButton: 'Refresh',
                      ),
                    );
                  }

                  if (state is RestaurantLoadedState) {
                    final List<RestaurantModel>? data = state.data;
                    return Expanded(
                      child: ListView.separated(
                        itemCount: data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          final dataRestaurant = data[index];
                          return ListTileRestaurant(
                            dataRestaurant: dataRestaurant,
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSelectedProccess(int value, BuildContext context) {
    switch (value) {
      case ConstantName.constFavorites:
        BlocProvider.of<RestaurantBloc>(context)
            .add(GetAllFavoritesRestaurant());
        Navigator.of(context).pushNamed(RouterAppPath.favoritesRestaurantPage);
        break;
      case ConstantName.constSetting:
        BlocProvider.of<SettingBlocCubit>(context).getSetting();
        Navigator.of(context).pushReplacementNamed(
          RouterAppPath.settingsPage,
        );
        break;
      case ConstantName.constLogout:
        BlocProvider.of<SettingBlocCubit>(context).logoutApp();
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouterAppPath.splashPage,
          (route) => false,
        );
        break;
      default:
    }
  }
}
