import 'package:app_submission_flutter_fundamental/src/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/grid_detail_restaurant.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/icon_text_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/sliver_app_delegate.dart';
import 'package:flutter/material.dart';

class DetailRestaurantPage extends StatefulWidget {
  final RestaurantModel restaurantModel;
  const DetailRestaurantPage({
    Key? key,
    required this.restaurantModel,
  }) : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.restaurantModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Hero(
                      tag: data.pictureId,
                      child: FadeInImage(
                        image: NetworkImage(
                          data.pictureId,
                        ),
                        placeholder: const AssetImage(
                            '${ConstantName.dirAssetImg}placeholder_image.png'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              '${ConstantName.dirAssetImg}placeholder_image.png',
                              fit: BoxFit.fitWidth);
                        },
                        fit: BoxFit.fitWidth,
                        placeholderFit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _header(data.name, 24),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTextCustom(
                      icon: const Icon(
                        Icons.place,
                        size: 16,
                        color: ThemeCustom.blueColor,
                      ),
                      data: data.city,
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
                      data: data.rating,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ).copyWith(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThemeCustom.secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      data.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _headerTabbar('Menu Restaurant', 18),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: controller,
                        children: [
                          GridDetailRestaurant(
                            data: data.menus.foods,
                          ),
                          GridDetailRestaurant(
                            data: data.menus.drinks,
                            isFoodsSection: false,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverPersistentHeader _header(String text, double fontSize) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 30,
        maxHeight: 50,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          color: Colors.white,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: ThemeCustom.secondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader _headerTabbar(String text, double fontSize) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60,
        maxHeight: 90,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(top: 16),
          color: Colors.white,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: ThemeCustom.secondaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              TabBar(
                controller: controller,
                unselectedLabelColor:
                    ThemeCustom.secondaryColor.withOpacity(0.8),
                labelColor: ThemeCustom.primaryColor,
                tabs: [
                  _tabCustom(
                    icon: Icons.restaurant_menu_sharp,
                    title: 'Foods',
                  ),
                  _tabCustom(
                    icon: Icons.coffee,
                    title: 'Drinks',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Tab _tabCustom({
    required IconData icon,
    required String title,
  }) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
