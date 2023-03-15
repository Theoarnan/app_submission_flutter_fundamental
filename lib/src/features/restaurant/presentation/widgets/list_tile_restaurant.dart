import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/icon_text_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/router/router_app_path.dart';
import 'package:flutter/material.dart';

class ListTileRestaurant extends StatelessWidget {
  const ListTileRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(RouterAppPath.detailRestaurantPage);
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return const DetailRestaurantPage();
        // }));
      },
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
            children: const [
              Padding(
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
              SizedBox(
                height: 8,
              ),
              IconTextCustom(
                icon: Icon(
                  Icons.place,
                  size: 16,
                  color: ThemeCustom.blueColor,
                ),
                data: 'Jl. Hokkya No 43 Kec. Paron, Ngawi, Jawa Timur',
              ),
              SizedBox(
                height: 4,
              ),
              IconTextCustom(
                icon: Icon(
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
