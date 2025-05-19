import 'dart:ui';
import 'package:cashnity/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends GetView<HomeController> {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;
    final Color subTextColor = isDarkMode ? Colors.white70 : Colors.black54;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Drawer(
          backgroundColor: isDarkMode
              ? Colors.black.withOpacity(0.2)
              : Colors.white.withOpacity(0.3),
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, size: 32, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello, ${controller.user?.name}!',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.user?.email ?? '',
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              DrawerTile(
                onTap: () {},
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
              ),
              DrawerTile(
                onTap: () {},
                icon: Icons.compare_arrows_outlined,
                label: 'Transactions',
              ),
              DrawerTile(
                onTap: () {},
                icon: Icons.settings_outlined,
                label: 'Settings',
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: DrawerTile(
                  onTap: () {
                    controller.showLogoutDialog();
                  },
                  icon: Icons.logout,
                  label: 'Logout',
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  const DrawerTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;
    final Color effectiveColor =
        color ?? (selected ? Colors.amber : defaultColor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        leading: Icon(icon, color: effectiveColor),
        title: Text(
          label,
          style: TextStyle(
            color: effectiveColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        selected: selected,
        selectedTileColor: effectiveColor.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        onTap: onTap,
      ),
    );
  }
}
