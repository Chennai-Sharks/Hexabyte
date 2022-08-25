import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/add_product_screen/add_product_screen.dart';
import 'package:hexabyte/screens/curation_screen/curation_screen.dart';
import 'package:hexabyte/screens/home_screen/home_screen.dart';
import 'package:hexabyte/screens/profile_screen/profile_screen.dart';
import 'package:hexabyte/screens/quick_buy_screen/quick_buy_screen.dart';

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
      QuickBuyScreen(),
      CurationScreen(),
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
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: color.withAlpha(80),
            labelTextStyle: MaterialStateProperty.all(
              GoogleFonts.montserrat(
                fontSize: 12,
              ),
            )),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: color.withOpacity(0.05),
          destinations: const [
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.home, size: 20),
              label: "Home",
            ),
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.cartArrowDown, size: 20),
                label: 'Quick Buy'),
            NavigationDestination(
                icon: Icon(Icons.create, size: 20), label: 'Curation'),
            NavigationDestination(
                icon: Icon(Icons.add, size: 20), label: 'Add Product'),
            NavigationDestination(
                icon: FaIcon(
                  FontAwesomeIcons.userCircle,
                  size: 20,
                  color: Colors.black,
                ),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
