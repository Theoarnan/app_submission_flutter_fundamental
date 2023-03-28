import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
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
            height: 24,
          ),
          Text.rich(
            TextSpan(
              text: 'Hi, ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'Buddy',
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
            ),
          ),
        ],
      ),
    );
  }
}
