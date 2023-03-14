import 'dart:async';

import 'package:app_submission_flutter_fundamental/src/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/router/router_app_path.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplashPage() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacementNamed(RouterAppPath.homePage);
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('${ConstantName.dirAssetImg}logo_app.png',
                  fit: BoxFit.fill),
              const SizedBox(
                height: 50,
              ),
              const CircularProgressIndicator(
                color: ThemeCustom.primaryColor,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: ThemeCustom.secondaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
