import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/router/navigation.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/empty_error_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<RestaurantBloc>(context).add(GetAllDataRestaurant());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<RestaurantBloc>(context)
                  .add(GetAllDataRestaurant());
              Navigation.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          title: const Text(
            'Favorites',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: BlocListener<RestaurantBloc, RestaurantState>(
          listener: (context, state) {
            if (state is RemoveFromFavoritesRestaurantSuccess) {
              BlocProvider.of<RestaurantBloc>(context)
                  .add(GetAllFavoritesRestaurant());
            }
          },
          child: SafeArea(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                BlocBuilder<RestaurantBloc, RestaurantState>(
                  builder: (context, state) {
                    if (state is RestaurantLoadingState) {
                      return const Expanded(
                        flex: 1,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is RestaurantLoadedState) {
                      final List<RestaurantModel>? data = state.data;
                      if (data!.isEmpty) {
                        return const Expanded(
                          child: EmptyErrorState(
                            imgAsset:
                                '${ConstantName.dirAssetImg}illustration_no_data.png',
                            title: 'Oops,',
                            subTitle: "Haven't added a favorite yet",
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.separated(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            final dataRestaurant = data[index];
                            return Dismissible(
                              key: Key(dataRestaurant.id.toString()),
                              background: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 16,
                                ),
                                color: ThemeCustom.redColor,
                                child: const Text(
                                  'Remove',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                BlocProvider.of<RestaurantBloc>(context).add(
                                  RemoveFromFavoritesRestaurant(
                                    id: dataRestaurant.id,
                                  ),
                                );
                              },
                              child: ListTileRestaurant(
                                dataRestaurant: dataRestaurant,
                                isFromFavorite: true,
                              ),
                            );
                          },
                        ),
                      );
                    }

                    if (state is RestaurantErrorState) {
                      return Expanded(
                        child: EmptyErrorState(
                          imgAsset:
                              '${ConstantName.dirAssetImg}illustration_error.png',
                          title: 'Sorry,',
                          subTitle:
                              'We failed to load favorites restaurant data',
                          withoutButton: false,
                          onPressed: () {
                            BlocProvider.of<RestaurantBloc>(context)
                                .add(GetAllDataRestaurant());
                          },
                          titleButton: 'Try Again',
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
