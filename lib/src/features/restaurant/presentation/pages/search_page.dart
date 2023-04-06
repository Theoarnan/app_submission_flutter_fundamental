import 'package:app_submission_flutter_fundamental/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/bloc/restaurant_bloc.dart';
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String search = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<RestaurantBloc>(context).add(GetAllDataRestaurant());
        Navigator.of(context).pop();
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
                            BlocProvider.of<RestaurantBloc>(context)
                                .add(GetAllDataRestaurant());
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
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
                              hintText: 'Search restaurant...',
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
                              BlocProvider.of<RestaurantBloc>(context).add(
                                SearchDataRestaurant(
                                  search: searchController.text,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<RestaurantBloc, RestaurantState>(
                        builder: (context, state) {
                      if (state is RestaurantLoadingState) {
                        return const SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is RestaurantErrorState ||
                          state is NoInternetState) {
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
                              SearchDataRestaurant(
                                search: searchController.text,
                              ),
                            );
                          },
                          titleButton: 'Try Again',
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
                        return ListView.separated(
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
