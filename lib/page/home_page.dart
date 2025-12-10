import 'package:flutter/material.dart';
import 'package:matcha/model/meal.dart';
import 'package:matcha/page/menu_page.dart';
import '../services/meal_service.dart';
import '../theme/app_theme.dart';

import '../widget/header_home.dart';
import '../widget/banner_home.dart';
import '../widget/search_bar_section.dart';
import '../widget/category_home.dart';
import '../widget/menu_card_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Meal> allMeals = [];
  List<Meal> filteredMeals = [];
  List<String> categories = ["All"];

  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    try {
      final meals = await MealService.fetchAllMeals();
      final catList = await MealService.fetchCategories();

      setState(() {
        allMeals = meals;
        filteredMeals = meals;
        categories = ["All", ...catList];
      });
    } catch (e) {
      print("Error load home data: $e");
    }
  }

  void onCategorySelected(int index) {
    setState(() {
      selectedCategory = index;
      final selected = categories[index];

      if (selected == "All") {
        filteredMeals = allMeals;
      } else {
        filteredMeals = allMeals
            .where((meal) =>
                (meal.category ?? "").toLowerCase() ==
                selected.toLowerCase())
            .toList();
      }
    });
  }

  void onSearch(String query) {
  setState(() {
    if (query.isEmpty) {
      // Jika kosong → filter kembali berdasarkan kategori aktif
      onCategorySelected(selectedCategory);
      return;
    }

    filteredMeals = allMeals.where((meal) {
      final name = meal.name.toLowerCase();
      final cat = (meal.category ?? "").toLowerCase();
      final search = query.toLowerCase();

      return name.contains(search) || cat.contains(search);
    }).toList();
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
              const SizedBox(height: 20),
              const BannerSection(),
              const SizedBox(height: 20),
              SearchBarSection(onChanged: onSearch,),
              const SizedBox(height: 20),

              // CATEGORIES
              CategoryTabs(
                categories: categories
                    .map((c) => {"name": c})
                    .toList(),
                selectedCategory: selectedCategory,
                onCategorySelected: onCategorySelected,
              ),

              const SizedBox(height: 20),

              // TITLE
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MenuPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recommended for You",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: AppColors.textPrimary)),
                    Text("See all",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // GRID VIEW
              filteredMeals.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Text(
                          'No menu found',
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
                      itemCount: filteredMeals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final meal = filteredMeals[index];
                        return MenuCardHome(meal: meal);
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
