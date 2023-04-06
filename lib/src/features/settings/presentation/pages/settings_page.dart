import 'dart:io';

import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/dialog_state.dart';
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
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
              if (state is SettingSettingSuccess) {
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
                        value: state.isDarkTheme,
                        onChanged: (value) {
                          BlocProvider.of<SettingBlocCubit>(context)
                              .changeTheme(isDark: value);
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
                        value: state.isActivedNotif,
                        onChanged: (value) {
                          if (Platform.isIOS) {
                            DialogState.dialogState(
                              context,
                              icon: Icon(
                                Icons.device_hub_rounded,
                                size: 90,
                                color: Colors.green.withOpacity(0.8),
                              ),
                              title: 'Oops,',
                              subTitle: 'Feature ready Comming Soon!',
                            );
                          } else {
                            BlocProvider.of<SettingBlocCubit>(context)
                                .changeRestaurantNotif(isSaveNotif: value);
                          }
                        },
                      ),
                    )
                  ],
                );
              }
              return const SizedBox();
            }),
          ),
        ),
      ),
    );
  }
}
