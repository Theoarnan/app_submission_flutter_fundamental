import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/dialog_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/empty_error_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/grid_detail_restaurant.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/icon_text_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_review.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/sliver_app_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailRestaurantPage extends StatefulWidget {
  final RestaurantModel restaurantModel;
  final bool isFromFavorites;
  final bool isFromNotif;
  const DetailRestaurantPage({
    Key? key,
    required this.restaurantModel,
    this.isFromFavorites = false,
    this.isFromNotif = false,
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
    BlocProvider.of<RestaurantBloc>(context).add(
      GetDetailDataRestaurant(id: widget.restaurantModel.id),
    );
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    controller.dispose();
    nameController.dispose();
    reviewontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isFromFavorites) {
          BlocProvider.of<RestaurantBloc>(context)
              .add(GetAllFavoritesRestaurant());
        } else {
          BlocProvider.of<RestaurantBloc>(context).add(GetAllDataRestaurant());
        }
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: BlocListener<RestaurantBloc, RestaurantState>(
            listener: (context, state) {
              if (state is RestaurantAddReviewsSuccessState) {
                Navigator.pop(context);
                BlocProvider.of<RestaurantBloc>(context).add(
                  GetDetailDataRestaurant(id: widget.restaurantModel.id),
                );
                DialogState.dialogState(
                  context,
                  icon: Icon(
                    Icons.check_circle,
                    size: 90,
                    color: Colors.green.withOpacity(0.8),
                  ),
                  title: 'Success',
                  subTitle:
                      'Thank you for your submitted review for the restaurant',
                );
              } else if (state is AddToFavoritesRestaurantSuccess ||
                  state is RemoveFromFavoritesRestaurantSuccess) {
                final stateRemoveFav =
                    state is RemoveFromFavoritesRestaurantSuccess;
                BlocProvider.of<RestaurantBloc>(context).add(
                  GetDetailDataRestaurant(id: widget.restaurantModel.id),
                );
                DialogState.dialogState(
                  context,
                  icon: Icon(
                    Icons.check_circle,
                    size: 90,
                    color: Colors.green.withOpacity(0.8),
                  ),
                  title: stateRemoveFav ? 'Removed' : 'Added',
                  subTitle:
                      '${widget.restaurantModel.name} ${stateRemoveFav ? 'remove from' : 'add to'} favorites',
                );
              }
            },
            child: BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                if (state is RestaurantLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is RestaurantErrorState || state is NoInternetState) {
                  final noInternetState = state is NoInternetState;
                  return EmptyErrorState(
                    imgAsset: noInternetState
                        ? '${ConstantName.dirAssetImg}no_internet.png'
                        : '${ConstantName.dirAssetImg}illustration_error.png',
                    title: 'Sorry,',
                    subTitle: noInternetState
                        ? "We we can't connect internet, please check your connection"
                        : 'We failed to load restaurant data',
                    withoutButton: false,
                    onPressed: () {
                      BlocProvider.of<RestaurantBloc>(context).add(
                        GetDetailDataRestaurant(
                          id: widget.restaurantModel.id,
                        ),
                      );
                    },
                    titleButton: 'Refresh',
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
                                  if (widget.isFromFavorites) {
                                    BlocProvider.of<RestaurantBloc>(context)
                                        .add(GetAllFavoritesRestaurant());
                                  } else {
                                    BlocProvider.of<RestaurantBloc>(context)
                                        .add(GetAllDataRestaurant());
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: ThemeCustom.secondaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: GestureDetector(
                                onTap: () {
                                  if (state.isFavorite) {
                                    BlocProvider.of<RestaurantBloc>(context)
                                        .add(RemoveFromFavoritesRestaurant(
                                            id: data.id));
                                  } else {
                                    BlocProvider.of<RestaurantBloc>(context)
                                        .add(AddToFavoritesRestaurant(
                                            data: data));
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.bookmark,
                                    size: 20,
                                    color: state.isFavorite
                                        ? ThemeCustom.yellowColor
                                        : Colors.grey,
                                  ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Material(
                                              child: Text(
                                                'All Reviews',
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                itemCount: data.customerReviews
                                                    .reversed.length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const Divider(),
                                                itemBuilder: (context, index) {
                                                  final newReviews = data
                                                      .customerReviews.reversed
                                                      .toList();
                                                  return ListTileReview(
                                                    data: newReviews[index],
                                                    isDetailReviews: false,
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
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
                                height: 8,
                              ),
                              SizedBox(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: data.customerReviews.length > 3
                                      ? 3
                                      : data.customerReviews.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemBuilder: (context, index) {
                                    final newReviews =
                                        data.customerReviews.reversed.toList();
                                    return ListTileReview(
                                      data: newReviews[index],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 6,
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
              },
            ),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Wrap(
              runSpacing: 16,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    'Add Review',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
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
                TextFormField(
                  controller: reviewontroller,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 8,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Review',
                    hintText: 'Review...',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ThemeCustom.thirdColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      final name = nameController.text;
                      final review = reviewontroller.text;
                      Map<String, dynamic> body = {
                        'id': widget.restaurantModel.id,
                        'name': name,
                        'review': review
                      };
                      BlocProvider.of<RestaurantBloc>(context)
                          .add(AddReviewRestaurant(review: body));
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
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
          color: Theme.of(context).scaffoldBackgroundColor,
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
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              TabBar(
                controller: controller,
                indicatorColor: ThemeCustom.primaryColor,
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
