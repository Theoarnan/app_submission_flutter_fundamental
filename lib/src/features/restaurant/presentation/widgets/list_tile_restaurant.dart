import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/argument_detail.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/icon_text_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/router_app_path.dart';
import 'package:flutter/material.dart';

class ListTileRestaurant extends StatelessWidget {
  final RestaurantModel dataRestaurant;
  final bool isFromFavorite;
  const ListTileRestaurant({
    Key? key,
    required this.dataRestaurant,
    this.isFromFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouterAppPath.detailRestaurantPage,
          arguments: DetailArguments(
            dataRestaurant: dataRestaurant,
            isFromFavorite: isFromFavorite,
          ),
        );
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: 100,
            child: Hero(
              tag: dataRestaurant.pictureId,
              child: FadeInImage(
                image: NetworkImage(
                  '${ConstantName.networkAssetImg}${dataRestaurant.pictureId}',
                ),
                placeholder: const AssetImage(
                    '${ConstantName.dirAssetImg}placeholder_image.png'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      '${ConstantName.dirAssetImg}placeholder_image.png',
                      fit: BoxFit.fitWidth);
                },
                fit: BoxFit.cover,
                placeholderFit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.58,
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  dataRestaurant.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              IconTextCustom(
                icon: const Icon(
                  Icons.place,
                  size: 16,
                  color: ThemeCustom.blueColor,
                ),
                data: dataRestaurant.city,
              ),
              const SizedBox(
                height: 4,
              ),
              IconTextCustom(
                icon: const Icon(
                  Icons.star,
                  size: 16,
                  color: ThemeCustom.yellowColor,
                ),
                data: dataRestaurant.rating.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
