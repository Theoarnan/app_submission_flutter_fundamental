import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:flutter/material.dart';

class ListTileRestaurant extends StatelessWidget {
  const ListTileRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconText({Icon? icon, String? data}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon!,
          const SizedBox(
            width: 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 180,
            child: Text(
              data!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          )
        ],
      );
    }

    return ListTile(
      onTap: () {},
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                  'https://restaurant-api.dicoding.dev/images/medium/14',
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  'Restaurant 1',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeCustom.secondaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              iconText(
                icon: const Icon(
                  Icons.place,
                  size: 16,
                  color: ThemeCustom.blueColor,
                ),
                data: 'Jl. Hokkya No 43 Kec. Paron, Ngawi, Jawa Timur',
              ),
              const SizedBox(
                height: 4,
              ),
              iconText(
                icon: const Icon(
                  Icons.star,
                  size: 16,
                  color: ThemeCustom.yellowColor,
                ),
                data: '4.6',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
