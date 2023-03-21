import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:flutter/material.dart';

class EmptyErrorState extends StatelessWidget {
  final String imgAsset;
  final String title;
  final String subTitle;
  final bool withoutButton;
  final String? titleButton;
  final Function? onPressed;

  const EmptyErrorState({
    Key? key,
    required this.imgAsset,
    required this.title,
    required this.subTitle,
    this.withoutButton = true,
    this.titleButton = 'Try Again',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgAsset,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              color: ThemeCustom.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          withoutButton
              ? const SizedBox()
              : ElevatedButton(
                  onPressed: () => onPressed!(),
                  child: Text(
                    titleButton!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
