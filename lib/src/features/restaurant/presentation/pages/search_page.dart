import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc_cubit.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/empty_error_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String search = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<RestaurantBlocCubit>(context).getAllDataRestaurant();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height - 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<RestaurantBlocCubit>(context)
                                .getAllDataRestaurant();
                            Navigator.maybePop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: ThemeCustom.secondaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Search restaurant or city...',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: ThemeCustom.thirdColor,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onChanged: (value) {
                              BlocProvider.of<RestaurantBlocCubit>(context)
                                  .searchDataRestaurant(searchController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<RestaurantBlocCubit, RestaurantState>(
                        builder: (context, state) {
                      if (state is RestaurantLoadingState) {
                        return const SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is RestaurantErrorState) {
                        return SizedBox(
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
                                    RestaurantBlocCubit()
                                        .searchDataRestaurant('');
                                  },
                                  titleButton: 'Try Again',
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (state is RestaurantLoadedState) {
                        final List<RestaurantModel>? data = state.data;
                        if (data!.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: EmptyErrorState(
                              imgAsset:
                                  '${ConstantName.dirAssetImg}illustration_no_data.png',
                              title: 'Oops,',
                              subTitle:
                                  'We could not find the data ${searchController.text} you are looking for',
                            ),
                          );
                        }
                        return SizedBox(
                          child: ListView.separated(
                            itemCount: data.length,
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

                      return const SizedBox();
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}