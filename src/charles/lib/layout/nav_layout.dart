import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/active_order_screen/active_order_screen.dart';
import 'package:hexabyte/screens/active_order_screen/widgets/active_order_card.dart';
import 'package:hexabyte/screens/add_product_screen/add_product_screen.dart';
import 'package:hexabyte/screens/home_screen/home_screen.dart';
import 'package:hexabyte/screens/listed_products_screen/listed_products_screen.dart';
import 'package:hexabyte/screens/order_history_screen/order_history_screen.dart';
import 'package:hexabyte/screens/profile_screen/profile_screen.dart';
import 'package:hexabyte/screens/quick_buy_screen/quick_buy_screen.dart';

class NavigationLayout extends StatefulWidget {
  final bool isConsumer;
  const NavigationLayout({Key? key, required this.isConsumer}) : super(key: key);

  @override
  NavigationLayoutState createState() => NavigationLayoutState();
}

class NavigationLayoutState extends State<NavigationLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabNavigations = widget.isConsumer
        ? [
            const HomeScreen(),
            const QuickBuyScreen(),
            // const CurationScreen(),
            const OrderHistoryScreen(),
          ]
        : [
            const ListedProductsScreen(),
            const AddProductsScreen(),
            const ActiveOrderScreen(),
          ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Text(''),
        backgroundColor: const Color(0xFFE9EFC0),
        toolbarHeight: 0,
      ),
      body: tabNavigations[_currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: const Color(0xFF83BD75),
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
          // backgroundColor: const Color.fromARGB(255, 215, 225, 209),
          backgroundColor: const Color(0xFFE9EFC0),
          destinations: widget.isConsumer
              ? const [
                  NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.home, size: 20),
                    label: "Home",
                  ),
                  NavigationDestination(icon: FaIcon(FontAwesomeIcons.cartArrowDown, size: 20), label: 'Quick Buy'),
                  // NavigationDestination(icon: Icon(Icons.create, size: 20), label: 'Combo Buy'),
                  NavigationDestination(icon: Icon(Icons.open_in_browser_rounded, size: 20), label: 'My orders'),
                ]
              : const [
                  NavigationDestination(
                    icon: FaIcon(
                      FontAwesomeIcons.userCircle,
                      size: 20,
                      color: Colors.black,
                    ),
                    label: 'Listed Products',
                  ),
                  NavigationDestination(icon: Icon(Icons.add, size: 20), label: 'Add Product'),
                  NavigationDestination(
                    icon: FaIcon(
                      FontAwesomeIcons.userCircle,
                      size: 20,
                      color: Colors.black,
                    ),
                    label: 'Active orders',
                  ),
                ],
        ),
      ),
    );
  }
}
