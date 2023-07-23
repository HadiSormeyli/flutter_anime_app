import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/config/config.dart';
import 'package:flutter_anime_app/presentation/screens/search/search_screen.dart';
import 'package:flutter_anime_app/presentation/screens/user/user_screen.dart';
import 'package:flutter_svg/svg.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const UserScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: _pages[_currentIndex],
        bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(xLargeRadius),
                topRight: Radius.circular(xLargeRadius)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 32.0, sigmaY: 56.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(xLargeRadius),
                      topRight: Radius.circular(xLargeRadius)),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: .5,
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  showSelectedLabels: false,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: primaryColor,
                  unselectedItemColor: greyColor,
                  onTap: _onTabTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/${(_currentIndex == 0) ? "fill_" : ""}home.svg',
                        color: (_currentIndex == 0) ? primaryColor.withOpacity(0.7) : greyColor,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/${(_currentIndex == 1) ? "fill_" : ""}search-normal.svg',
                        color: (_currentIndex == 1) ? primaryColor.withOpacity(0.7) : greyColor,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/${(_currentIndex == 2) ? "fill_" : ""}user.svg',
                        color: (_currentIndex == 2) ? primaryColor.withOpacity(0.7) : greyColor,
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
            )));
  }
}
