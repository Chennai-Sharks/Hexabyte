import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/add_product_screen/add_product_screen.dart';
import 'package:hexabyte/screens/home_screen/widgets/home_screen_card.dart';
import 'package:hexabyte/screens/home_screen/widgets/search_bar.dart';
import 'package:hexabyte/screens/search_screen/search_screen.dart';

import 'widgets/scroll_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('assets/home_bg.png'))),
          child: Column(
            children: [
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: const Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: const SearchBar(),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/home_bg.png'))),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollableCategories(
                categories: categories,
                categoriesImgList: categoriesImg,
              ),
              ScrollableCategories(
                categories: secondCategories,
                categoriesImgList: secondCategoriesImg,
              ),
              const HomeScreenCard(
                color: Colors.orange,
                imageUrl:
                    "https://c.tenor.com/6kZnvYgHAMMAAAAC/wasted-house-parched.gif",
                descriptionText: "Products across the country",
                sloganText: "Come let's purchase !!!",
                buttonText: "EXPLORE PRODUCTS",
                icon: FontAwesomeIcons.productHunt,
                navigatorWidget: AddProductsScreen(),
              ),
              HomeScreenCard(
                color: Colors.purple.shade900,
                imageUrl:
                    "https://64.media.tumblr.com/0120d5711147ae7d7a876b2213a61373/tumblr_nt748trUEB1uz3idyo1_500.gif",
                descriptionText: "Products across the country",
                sloganText: "Come let's purchase !!!",
                buttonText: "EXPLORE INSTAMART",
                icon: FontAwesomeIcons.luggageCart,
                navigatorWidget: AddProductsScreen(),
              ),
              const HomeScreenCard(
                color: Colors.green,
                imageUrl:
                    "https://i.pinimg.com/originals/39/a0/51/39a0515d87ac9194c801e6104e9552f7.gif",
                descriptionText: "Products across the country",
                sloganText: "Come let's purchase !!!",
                buttonText: "EXPLORE INSTAMART",
                icon: FontAwesomeIcons.luggageCart,
                navigatorWidget: AddProductsScreen(),
              ),
              const HomeScreenCard(
                color: Colors.redAccent,
                imageUrl:
                    "https://thumbs.gfycat.com/MistyMilkyAlbacoretuna-max-1mb.gif",
                descriptionText: "Products across the country",
                sloganText: "Come let's purchase !!!",
                buttonText: "EXPLORE INSTAMART",
                icon: FontAwesomeIcons.luggageCart,
                navigatorWidget: AddProductsScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
