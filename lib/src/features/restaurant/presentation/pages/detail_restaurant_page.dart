import 'package:app_submission_flutter_fundamental/src/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/icon_text_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/sliver_app_delegate.dart';
import 'package:flutter/material.dart';

class DetailRestaurantPage extends StatefulWidget {
  const DetailRestaurantPage({Key? key}) : super(key: key);

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
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://restaurant-api.dicoding.dev/images/medium/03',
                        ),
                        fit: BoxFit.fitWidth,
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
            _header('Kafe Kita', 24),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
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
                      testText,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _header2('Menu Restaurant', 18),
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
                          GridView.count(
                            crossAxisCount: 2,
                            physics: const ClampingScrollPhysics(),
                            children: List.generate(14, (index) {
                              return Card(
                                color: Colors.white,
                                elevation: 1,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          '${ConstantName.dirAssetImg}illustration_food.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ).copyWith(bottom: 8),
                                      child: const Text(
                                        'Salad lengkeng',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            physics: const ClampingScrollPhysics(),
                            children: List.generate(9, (index) {
                              return Card(
                                color: Colors.white,
                                elevation: 1,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          '${ConstantName.dirAssetImg}illustration_drink.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ).copyWith(bottom: 8),
                                      child: const Text(
                                        'Kopi espresso',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
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
        minHeight: 50,
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

  SliverPersistentHeader _header2(String text, double fontSize) {
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
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.restaurant_menu_sharp,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Foods',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.coffee,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Drinks',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String testText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ac convallis dui, quis convallis magna. Sed a enim et risus facilisis rhoncus sit amet sed enim. Sed mollis luctus libero, laoreet tempus mi convallis at. Cras aliquam ac mauris vitae ullamcorper. Proin mollis non nisl malesuada tempor. Donec non quam id sem ultricies dictum nec non urna. Duis leo ante, venenatis in elementum vel, ultricies non ipsum. Morbi laoreet sem et sem laoreet suscipit. Donec nec neque volutpat, viverra ante ac, ullamcorper tortor';
