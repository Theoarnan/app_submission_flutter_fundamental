import 'package:app_submission_flutter_fundamental/src/constants/constants_name.dart';
import 'package:app_submission_flutter_fundamental/src/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/home_header_section.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/presentation/widgets/list_tile_restaurant.dart';
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
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                const HomeHeaderSection(),
                const SizedBox(
                  height: 16,
                ),
                // List Section
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return const ListTileRestaurant();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
