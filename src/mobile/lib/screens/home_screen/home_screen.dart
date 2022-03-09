import 'package:auto_size_text/auto_size_text.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/home_screen/widgets/product_card.dart';
import 'package:hexabyte/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    child: Image.asset('assets/logo.png'),
                    maxRadius: 22,
                  ),
                )
              ],
            ),
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
              height: MediaQuery.of(context).size.height * 0.36,
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
              height: MediaQuery.of(context).size.height * 0.36,
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
              height: MediaQuery.of(context).size.height * 0.01,
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
              height: MediaQuery.of(context).size.height * 0.36,
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
          ],
        ),
      ),
    );
  }
}
