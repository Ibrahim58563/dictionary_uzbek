import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dictionary/utils/app_colors.dart';
import 'package:dictionary/whole_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bookmark_screen.dart';
import 'contact_us_screen.dart';
import 'history_screen.dart';
import 'search_screen.dart';

class AnimatedBottomNavBar extends StatefulWidget {
  const AnimatedBottomNavBar({super.key});

  @override
  State<AnimatedBottomNavBar> createState() => _AnimatedBottomNavBarState();
}

class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar> {
  int _selectedIndex = 4;
  Widget? _selectedWidget;
  @override
  void initState() {
    _selectedWidget = const SearchScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedWidget,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          setState(() {
            _selectedWidget = const SearchScreen();
            _selectedIndex = 5;
          });
        },
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.search_rounded,
          color: AppColors.primary,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        borderColor: AppColors.primary.withOpacity(0.2),
        activeColor: AppColors.primary,
        inactiveColor: AppColors.grey,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        icons: const [
          Icons.book_rounded,
          Icons.bookmark,
          Icons.history,
          Icons.phone,
        ],
        height: 60,
        activeIndex: _selectedIndex,
        onTap: onPressed,
      ),
    );
  }

  void onPressed(index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _selectedWidget = const WholeDictionaryScreen();
      } else if (index == 1) {
        _selectedWidget = const BookMarkScreen();
      } else if (index == 2) {
        _selectedWidget = const HistoryScreen();
      } else if (index == 3) {
        _selectedWidget = const ContactUsScreen();
      } else if (index == 4) {
        _selectedWidget = const SearchScreen();
      }
    });
  }
}
