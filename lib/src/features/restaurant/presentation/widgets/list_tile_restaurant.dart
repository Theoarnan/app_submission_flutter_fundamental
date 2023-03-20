import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc_cubit.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/icon_text_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/router_app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTileRestaurant extends StatelessWidget {
  final RestaurantModel dataRestaurant;
  const ListTileRestaurant({
    Key? key,
    required this.dataRestaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        BlocProvider.of<RestaurantBlocCubit>(context).getDetailDataRestaurant(
          dataRestaurant.id,
        );
        Navigator.of(context).pushNamed(
          RouterAppPath.detailRestaurantPage,
          arguments: dataRestaurant,
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
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  dataRestaurant.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeCustom.secondaryColor,
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
