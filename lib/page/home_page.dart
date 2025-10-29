import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matcha/page/menu_page.dart';
import 'package:matcha/widget/menu_card_home.dart';
import '../theme/app_theme.dart';

import '../widget/header_home.dart';
import '../widget/banner_home.dart';
import '../widget/search_bar_section.dart';
import '../widget/category_home.dart';

import '../model/menu_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> categories = [];
  List<MenuItem> menuList = [];
  List<MenuItem> filteredMenu = [];

  int selectedCategory = 0;

  Future<void> loadMenuData() async {
    final String response = await rootBundle.loadString(
      'assets/menu_data.json',
    );
    final data = json.decode(response);

    setState(() {
      categories = List<Map<String, dynamic>>.from(data['categories']);
      menuList = (data['menu'] as List)
          .map((json) => MenuItem.fromJson(json))
          .toList();
      filteredMenu = menuList;
    });

    print("Loaded ${menuList.length} menu items");
  }

  @override
  void initState() {
    super.initState();
    loadMenuData();
  }

  void onCategorySelected(int index) {
    setState(() {
      selectedCategory = index;
      final selectedName = categories[index]['name'];
      print('Selected category: $selectedName');

      filteredMenu = menuList.where((item) {
        if (selectedName.toLowerCase() == 'all') {
          return true;
        }
        return item.category.toLowerCase() == selectedName.toLowerCase();
      }).toList();

      print('Filtered result: ${filteredMenu.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(username: 'Josh'),
              const SizedBox(height: 20.0),
              const BannerSection(),
              const SizedBox(height: 20.0),
              const SearchBarSection(),
              const SizedBox(height: 20.0),
              if (categories.isNotEmpty)
                CategoryTabs(
                  categories: categories,
                  selectedCategory: selectedCategory,
                  onCategorySelected: onCategorySelected,
                ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MenuPage()),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommended for You",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: AppColors.textPrimary
                        ),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.textSecondary
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              filteredMenu.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredMenu.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 0,
                            childAspectRatio: 0.85,
                          ),
                      itemBuilder: (context, index) {
                        final item = filteredMenu[index];
                        return MenuCard(item: item);
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.textPrimary, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
