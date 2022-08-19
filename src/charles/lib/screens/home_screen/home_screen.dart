import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/appbar_layout.dart';
import 'package:hexabyte/providers/auth/auth_provider.dart';
import 'package:hexabyte/providers/home/home_provider.dart';
import 'package:hexabyte/screens/home_screen/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthProvider _authProvider = AuthProvider();
  final HomeProvider _homeProvider = HomeProvider();

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance);
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;

    final controller = ScrollController();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Container(
          color: color,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8, 40, 8),
                    child: Image.asset(
                      "assets/logo.png",
                      height: 40,
                    ),
                  ),
                  Text(
                    'HexaByte',
                    style: GoogleFonts.rubik(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              HomePageAppBar(),
            ],
          ),
        ),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.only(right: 10),
            //       child: GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (context) => const ProfileScreen(),
            //             ),
            //           );
            //         },
            //         child: CircleAvatar(
            //           child: Image.asset('assets/logo.png'),
            //           maxRadius: 22,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            AutoSizeText(
              'What would you like to order today',
              textAlign: TextAlign.center,
              style: GoogleFonts.exo(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AutoSizeText(
                'Popular Seller',
                style: GoogleFonts.exo(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const ProductCard(
                    category: 'Category 1',
                    toWhom: 'Biogas',
                    weight: 20,
                    price: 200,
                    name: 'Egg shells',
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AutoSizeText(
                'Popular Items',
                style: GoogleFonts.exo(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const ProductCard(
                    category: 'Category 1',
                    toWhom: 'Biogas',
                    weight: 20,
                    price: 200,
                    name: 'Egg shells',
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
