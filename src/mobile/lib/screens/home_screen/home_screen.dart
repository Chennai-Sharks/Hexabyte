import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/providers/auth/auth_provider.dart';
import 'package:hexabyte/screens/auth_screen/auth_screen.dart';
import 'package:hexabyte/screens/home_screen/widgets/product_card.dart';
import 'package:hexabyte/screens/profile_screen/profile_screen.dart';
import 'package:hexabyte/screens/profile_screen/widgets/option_container.dart';
import 'package:hexabyte/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthProvider _authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance);
    return Scaffold(
      backgroundColor: Utils.primaryBackground,
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
                color: Utils.primaryFontColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AutoSizeText(
                'Recommended',
                style: GoogleFonts.exo(
                  color: Utils.primaryFontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.3,
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
            optionContainer(
              Colors.red,
              const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              "Logout",
              context,
              () async {
                print('tap');
                Fluttertoast.showToast(msg: 'Logging out');
                await _authProvider.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: AutoSizeText(
                'Popular Seller',
                style: GoogleFonts.exo(
                  color: Utils.primaryFontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.3,
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
                  color: Utils.primaryFontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.3,
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
