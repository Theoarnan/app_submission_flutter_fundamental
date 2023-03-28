import 'package:flutter/material.dart';

class IconTextCustom extends StatelessWidget {
  final Icon icon;
  final String data;

  const IconTextCustom({Key? key, required this.icon, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        const SizedBox(
          width: 6,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 180,
          child: Text(
            data,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
