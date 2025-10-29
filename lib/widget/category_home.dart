import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryTabs extends StatelessWidget {
  final List<dynamic> categories;
  final int selectedCategory;
  final Function(int) onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == index;

          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              width: 80,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? AppColors.textPrimary : AppColors.textPrimary,
                  width: 2,
                ),
              ),
              child: Text(
                categories[index]['name'] ?? 'Unknown',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight:
                      isSelected ? FontWeight.w800 : FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
