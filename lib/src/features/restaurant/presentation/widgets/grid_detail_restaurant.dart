import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/food_drink_model.dart';
import 'package:flutter/material.dart';

class GridDetailRestaurant extends StatelessWidget {
  final List<FoodDrinkCategoriesModel> data;
  final bool isFoodsSection;
  const GridDetailRestaurant({
    super.key,
    required this.data,
    this.isFoodsSection = true,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: const ClampingScrollPhysics(),
      children: List.generate(data.length, (index) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 1,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                    child: Image.asset(
                      isFoodsSection
                          ? '${ConstantName.dirAssetImg}illustration_food.png'
                          : '${ConstantName.dirAssetImg}illustration_drink.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ).copyWith(bottom: 10),
                  child: Text(
                    data[index].name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
