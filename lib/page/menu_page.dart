import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../model/menu_model.dart';
import 'detail_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItem> menuList = [];

  @override
  void initState() {
    super.initState();
    loadMenuData();
  }

  Future<void> loadMenuData() async {
    final String response = await rootBundle.loadString('assets/menu_data.json');
    final data = json.decode(response);

    setState(() {
      menuList = (data['menu'] as List)
          .map((json) => MenuItem.fromJson(json))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.textPrimary, width: 2),
                      ),
                      child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    ),
                  ),
                  const Text(
                    'Our Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: menuList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: menuList.length,
                      itemBuilder: (context, index) {
                        final item = menuList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(item: item),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 115,
                                  margin: const EdgeInsets.only(left: 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: AppColors.textPrimary,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 90),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "${item.currency}${item.price}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 15,
                                  child: Container(
                                    width: 144,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.textPrimary,
                                        width: 1.5,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        item.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
