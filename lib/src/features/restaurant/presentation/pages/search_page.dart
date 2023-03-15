import 'package:app_submission_flutter_fundamental/src/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/models/restaurant_model.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_restaurant.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/services/services.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      onPressed: () => Navigator.maybePop(context),
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
                          setState(() {
                            search = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<RestaurantModel>?>(
                  future: ServicesImpl().searchRestaurantData(search),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<RestaurantModel>? data = snapshot.data;
                      if (data!.isEmpty) {
                        return Container(
                          height: MediaQuery.of(context).size.height - 110,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  '${ConstantName.dirAssetImg}illustration_no_data.png',
                                ),
                                const Text(
                                  'Oops,',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: ThemeCustom.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'We could not find the data ${searchController.text} you are looking for',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 110,
                        child: ListView.separated(
                          itemCount: data.length,
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

                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 110,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
