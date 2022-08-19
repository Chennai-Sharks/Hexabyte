import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/add_product_screen/add_product_screen.dart';
import 'package:hexabyte/screens/home_screen/home_screen.dart';
import 'package:hexabyte/screens/profile_screen/profile_screen.dart';
import 'package:hexabyte/screens/search_screen/search_screen.dart';

class NavigationLayout extends StatefulWidget {
  const NavigationLayout({Key? key}) : super(key: key);

  @override
  NavigationLayoutState createState() => NavigationLayoutState();
}

class NavigationLayoutState extends State<NavigationLayout> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Color? color = Colors.redAccent.shade700;

    final tabNavigations = [
      HomeScreen(),
      SearchPage(),
      Container(),
      const AddProductsScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Text(''),
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: tabNavigations[_currentIndex],
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const FaIcon(FontAwesomeIcons.home, size: 20),
            title: Center(
              child: Text(
                'HexaByte',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                ),
              ),
            ),
            activeColor: color,
            inactiveColor: color,
          ),
          BottomNavyBarItem(
            icon: const FaIcon(FontAwesomeIcons.cartArrowDown, size: 20),
            title: Center(
              child: Text(
                'Quick buy',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                ),
              ),
            ),
            activeColor: color,
            inactiveColor: color,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.create, size: 20),
            title: Center(
              child: Text(
                'Curation',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                ),
              ),
            ),
            activeColor: color,
            inactiveColor: color,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add, size: 20),
            title: Center(
              child: Text(
                'Add Product',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                ),
              ),
            ),
            activeColor: color,
            inactiveColor: color,
          ),
          BottomNavyBarItem(
            icon: const FaIcon(FontAwesomeIcons.userCircle, size: 20),
            title: Center(
              child: Text(
                'Profile',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                ),
              ),
            ),
            activeColor: color,
            inactiveColor: color,
          ),
        ],
        animationDuration: const Duration(milliseconds: 400),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
