import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/utils.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc_cubit.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/empty_error_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/grid_detail_restaurant.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/icon_text_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/sliver_app_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewontroller = TextEditingController();

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
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<RestaurantBlocCubit>(context).getAllDataRestaurant();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<RestaurantBlocCubit, RestaurantState>(
            listener: (context, state) {
              if (state is RestaurantAddReviewsSuccessState) {
                Navigator.pop(context);
                BlocProvider.of<RestaurantBlocCubit>(context)
                    .getDetailDataRestaurant(
                  widget.restaurantModel.id,
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 250),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 100,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                'Success',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Thank you for your submitted review for the restaurant',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ThemeCustom.secondaryColor
                                        .withOpacity(0.6)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: BlocBuilder<RestaurantBlocCubit, RestaurantState>(
                builder: (context, state) {
              if (state is RestaurantLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is RestaurantErrorState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyErrorState(
                        imgAsset:
                            '${ConstantName.dirAssetImg}illustration_error.png',
                        title: 'Sorry,',
                        subTitle: 'We failed to load detail restaurant data',
                        withoutButton: false,
                        onPressed: () {
                          RestaurantBlocCubit().getDetailDataRestaurant(
                              widget.restaurantModel.id);
                        },
                        titleButton: 'Try Again',
                      ),
                    ],
                  ),
                );
              }

              if (state is RestaurantDetailLoadedState) {
                final data = state.data;
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
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
                                  '${ConstantName.networkAssetImg}${data.pictureId}',
                                ),
                                placeholder: const AssetImage(
                                    '${ConstantName.dirAssetImg}placeholder_image.png'),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
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
                                BlocProvider.of<RestaurantBlocCubit>(context)
                                    .getAllDataRestaurant();
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.arrow_back_ios_new,
                                    size: 20),
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
                            SizedBox(
                              height: 20,
                              child: ListView.builder(
                                itemCount: data.categories.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        color: ThemeCustom.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Center(
                                      child: Text(
                                        data.categories[index].name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            IconTextCustom(
                              icon: const Icon(
                                Icons.location_city_rounded,
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
                                Icons.place,
                                size: 16,
                                color: ThemeCustom.redColor,
                              ),
                              data: data.address,
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
                              height: 6,
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
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ).copyWith(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Reviews',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ThemeCustom.secondaryColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'View All',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.separated(
                                itemCount: data.customerReviews.length > 3
                                    ? 3
                                    : data.customerReviews.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    style: ListTileStyle.list,
                                    leading: CircleAvatar(
                                      child: Text(
                                        Utils.generateInitialText(
                                            data.customerReviews[index].name),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.customerReviews[index].name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          data.customerReviews[index].date,
                                          style: const TextStyle(
                                            color: ThemeCustom.thirdColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      data.customerReviews[index].review,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      alignment: Alignment.center),
                                  onPressed: () {
                                    _showModalBottom(context);
                                  },
                                  child: const Text(
                                    'Add Review',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    _headerTabbar('Menu Restaurant', 18),
                    SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
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
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            }),
          ),
        ),
      ),
    );
  }

  _showModalBottom(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.36,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    'Add Review',
                    style: TextStyle(
                      fontSize: 24,
                      color: ThemeCustom.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Name...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeCustom.thirdColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: reviewontroller,
                  maxLines: 8,
                  decoration: InputDecoration(
                    labelText: 'Review',
                    hintText: 'Review...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeCustom.thirdColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        final name = nameController.text;
                        final review = reviewontroller.text;
                        Map<String, dynamic> body = {
                          'id': widget.restaurantModel.id,
                          'name': name,
                          'review': review
                        };
                        BlocProvider.of<RestaurantBlocCubit>(context)
                            .addReviewRestaurant(body);
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        );
      },
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
