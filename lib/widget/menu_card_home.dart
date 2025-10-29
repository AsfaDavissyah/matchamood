import 'package:flutter/material.dart';
import 'package:matcha/page/detail_page.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../model/menu_model.dart';

class MenuCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback? onFavoriteTap;

  const MenuCard({super.key, required this.item, this.onFavoriteTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailPage(item: item)),
        );
      },

      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 175,
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.textPrimary, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name.length > 15
                          ? '${item.name.substring(0, 15)}...'
                          : item.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.currency}${item.price}',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.textPrimary,
                                width: 1.5,
                              ),
                              color: AppColors.primary.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.favorite_border_rounded,
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

              Positioned(
                top: 0,
                left: 10,
                right: 10,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.textPrimary, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(item.image, fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
