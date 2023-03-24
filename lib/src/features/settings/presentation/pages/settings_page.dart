import 'package:app_submission_flutter_fundamental/src/common/utils/shared_preference_app.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/bloc/setting_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/bloc/setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SharePreferencesAppImpl sharePreferencesAppImpl =
      SharePreferencesAppImpl();
  bool isActiveLigth = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<RestaurantBloc>(context).add(GetAllDataRestaurant());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<RestaurantBloc>(context)
                  .add(GetAllDataRestaurant());
              Navigator.maybePop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 4,
            ),
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<SettingBlocCubit, SettingState>(
                builder: (context, state) {
              final stateThemeSuccess = (state is SettingThemeSuccess);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 0),
                    title: const Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Switch.adaptive(
                      value: stateThemeSuccess
                          ? state.isDarkTheme
                          : !isActiveLigth,
                      onChanged: (value) {
                        if (isActiveLigth) {
                          isActiveLigth = false;
                          BlocProvider.of<SettingBlocCubit>(context)
                              .changeTheme(isDark: true);
                        } else {
                          isActiveLigth = true;
                          BlocProvider.of<SettingBlocCubit>(context)
                              .changeTheme(isDark: false);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 0),
                    title: const Text(
                      'Restaurant Notification',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
