import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../model/meal.dart';
import '../page/detail_page.dart';

class MenuCardHome extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onFavoriteTap;

  const MenuCardHome({
    super.key,
    required this.meal,
    this.onFavoriteTap,
  });

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailPage(meal: meal),
        ),
      );
    },
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // CARD (di bawah)
        Container(
          margin: const EdgeInsets.only(top: 60, left: 4, right: 4, bottom: 10),
          padding: const EdgeInsets.only(top: 65, left: 12, right: 12, bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.textPrimary, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal.name.length > 20 ? "${meal.name.substring(0, 20)}..." : meal.name,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    meal.category ?? "",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.textPrimary,
                          width: 1.5,
                        ),
                        color: AppColors.primary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // IMAGE FLOATING
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                meal.thumbnail,
                height: 120,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}
