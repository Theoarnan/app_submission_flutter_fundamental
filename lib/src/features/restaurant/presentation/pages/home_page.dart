import 'package:app_submission_flutter_fundamental/src/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/empty_error_state.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/home_header_section.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_restaurant.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/services/services.dart';
import 'package:app_submission_flutter_fundamental/src/features/router/router_app_path.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                FutureBuilder<List<RestaurantModel>>(
                  future: ServicesImpl().getRestaurantData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<RestaurantModel>? data = snapshot.data;
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

                    if (snapshot.hasError) {
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
                                  setState(() {});
                                },
                                titleButton: 'Try Again',
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: size.height * 0.78,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
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
