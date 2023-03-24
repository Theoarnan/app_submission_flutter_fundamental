import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:flutter/material.dart';

class DialogState {
  /// Dialog information
  static Future dialogState(
    BuildContext context, {
    required Icon icon,
    required String title,
    required String subTitle,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 250),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: ThemeCustom.secondaryColor.withOpacity(0.6)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
