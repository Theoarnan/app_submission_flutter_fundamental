import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 28,
          ),
          Text.rich(
            TextSpan(
              text: 'Hi, ',
              style: TextStyle(
                fontSize: 24,
                color: ThemeCustom.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'Arnan A Theopilus 👋',
                  style: TextStyle(
                    fontSize: 24,
                    color: ThemeCustom.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Find your favorite food in popular restaurant',
            style: TextStyle(
              fontSize: 16,
              color: ThemeCustom.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
