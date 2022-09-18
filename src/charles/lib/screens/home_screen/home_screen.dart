import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/home_screen/widgets/home_screen_card.dart';
import 'package:hexabyte/screens/home_screen/widgets/search_bar.dart';
import 'package:hexabyte/screens/order_history_screen/order_history_screen.dart';
import 'package:hexabyte/screens/quick_buy_screen/quick_buy_screen.dart';
import 'package:hexabyte/screens/search_screen/search_screen.dart';

import '../curation_screen/curation_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'widgets/scroll_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFC0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFE9EFC0),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 42,
                  ),
                  Text(
                    'HexaByte',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: const Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: const SearchBar(),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: size.height,
        decoration:
            const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/home_bg.png'))),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ScrollableCategories(
                categories: categories,
                categoriesImgList: categoriesImg,
                widget: const [QuickBuyScreen(), CurationScreen()],
              ),
              ScrollableCategories(
                categories: secondCategories,
                categoriesImgList: secondCategoriesImg,
                widget: const [OrderHistoryScreen(), ProfileScreen()],
              ),
              const HomeScreenCard(
                color: Colors.orange,
                imageUrl: "https://c.tenor.com/6kZnvYgHAMMAAAAC/wasted-house-parched.gif",
                descriptionText: "Products across the country",
                sloganText: "Come let's purchase !!!",
                buttonText: "EXPLORE QUICK BUY",
                icon: FontAwesomeIcons.luggageCart,
                navigatorWidget: QuickBuyScreen(),
              ),
              HomeScreenCard(
                color: Colors.purple.shade900,
                imageUrl:
                    "https://64.media.tumblr.com/0120d5711147ae7d7a876b2213a61373/tumblr_nt748trUEB1uz3idyo1_500.gif",
                descriptionText: "Combos across the country",
                sloganText: "Come and purchase more than one !!!",
                buttonText: "EXPLORE COMBO BUY",
                icon: FontAwesomeIcons.luggageCart,
                navigatorWidget: const CurationScreen(),
              ),
              const HomeScreenCard(
                color: Colors.green,
                imageUrl: "https://i.pinimg.com/originals/39/a0/51/39a0515d87ac9194c801e6104e9552f7.gif",
                descriptionText: "Buy food waste by initiate a contract with the seller",
                sloganText: "Subscription !!!",
                buttonText: "EXPLORE SUBSCRIPTION",
                icon: FontAwesomeIcons.luggageCart,
                navigatorWidget: QuickBuyScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String?> categories = [
  "Quick buy",
  "Combo buy",
];

List<String?> categoriesImg = [
  "assets/fast-time.png",
  "assets/combo-box.png",
];

List<String?> secondCategories = [
  "Order History",
  'Profile',
];

List<String?> secondCategoriesImg = [
  "assets/document.png",
  "assets/user-profile.png",
];
