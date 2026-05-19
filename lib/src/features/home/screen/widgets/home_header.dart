import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/app/index.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenu;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;

  const HomeHeader({
    super.key,
    required this.onMenu,
    required this.onSearch,
    required this.onNotifications,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        backgroundColor: AppColors.greyDarkest,
        elevation: 0,
        leading: IconButton(
          onPressed: onMenu,
          icon: const Icon(Icons.menu, color: AppColors.scaffold),
        ),
        title: Text(
          'Tajweed app',
          style: AppFonts.nunito
              .withSize(FontSizes.headline3)
              .withColor(AppColors.scaffold)
              .semiBold(),
        ),
        actions: [
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search, color: AppColors.scaffold),
          ),
          IconButton(
            onPressed: onNotifications,
            icon: const Icon(Icons.settings, color: AppColors.scaffold),
          ),
        ],
      ),
    );
  }
}
