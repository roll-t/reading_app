import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/extensions/is_dark_mode.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final backgroundColor =
        isDarkMode ? AppColors.secondaryDarkBg : const Color(0xfff2f2f2);
    final selectedColor =
        isDarkMode ? AppColors.accentColor : AppColors.primary;
    const unselectedColor = Colors.grey;

    final items = [
      {"icon": Icons.home, "label": AppContents.home},
      {"icon": Icons.menu_book, "label": AppContents.comic},
      {"icon": Icons.book, "label": AppContents.bookCase},
      {"icon": CupertinoIcons.person_solid, "label": AppContents.account},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedSlide(
              offset: isSelected ? const Offset(0, 0) : const Offset(0, 0.3),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: isSelected ? 1 : 0.7,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      size: isSelected ? 20 : 18,
                      color: isSelected ? selectedColor : unselectedColor,
                    ),
                    if (isSelected) // Chỉ hiện label nếu được chọn
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: selectedColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
