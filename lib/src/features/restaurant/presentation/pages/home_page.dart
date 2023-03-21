import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/empty_error_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/home_header_section.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_restaurant.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/router_app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantBloc>(context).add(GetAllDataRestaurant());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          '${ConstantName.dirAssetImg}logo.png',
          width: 120,
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<RestaurantBloc>(context)
                  .add(GetAllDataRestaurant());
              Navigator.of(context).pushNamed(RouterAppPath.searchPage);
            },
            icon: const Icon(
              Icons.search,
              color: ThemeCustom.primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeaderSection(),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<RestaurantBloc, RestaurantState>(
                  builder: (context, state) {
                    if (state is RestaurantLoadingState) {
                      return SizedBox(
                        height: size.height * 0.78,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is NoInternetState) {
                      return SizedBox(
                        height: size.height * 0.78,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              EmptyErrorState(
                                imgAsset:
                                    '${ConstantName.dirAssetImg}no_internet.png',
                                title: 'Sorry,',
                                subTitle:
                                    "We we can't connect internet, please check your connection",
                                withoutButton: false,
                                onPressed: () async {
                                  BlocProvider.of<RestaurantBloc>(context)
                                      .add(GetAllDataRestaurant());
                                },
                                titleButton: 'Refresh',
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (state is RestaurantLoadedState) {
                      final List<RestaurantModel>? data = state.data;
                      return SizedBox(
                        height: size.height * 0.78,
                        child: ListView.separated(
                          itemCount: data!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            final dataRestaurant = data[index];
                            return ListTileRestaurant(
                              dataRestaurant: dataRestaurant,
                            );
                          },
                        ),
                      );
                    }

                    if (state is RestaurantErrorState) {
                      return SizedBox(
                        height: size.height * 0.78,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              EmptyErrorState(
                                imgAsset:
                                    '${ConstantName.dirAssetImg}illustration_error.png',
                                title: 'Sorry,',
                                subTitle: 'We failed to load restaurant data',
                                withoutButton: false,
                                onPressed: () {
                                  BlocProvider.of<RestaurantBloc>(context)
                                      .add(GetAllDataRestaurant());
                                },
                                titleButton: 'Try Again',
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
