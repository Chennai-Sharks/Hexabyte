import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/providers/auth/auth_provider.dart';
import 'package:hexabyte/providers/home/home_provider.dart';
import 'package:hexabyte/screens/auth_screen/auth_screen.dart';
import 'package:hexabyte/screens/home_screen/widgets/product_card.dart';
import 'package:hexabyte/screens/loading_screen/loading_screen.dart';
import 'package:hexabyte/screens/profile_screen/widgets/option_container.dart';
import 'package:hexabyte/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthProvider _authProvider = AuthProvider();
  final HomeProvider _homeProvider = HomeProvider();

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
            // Padding(
            //   padding: const EdgeInsets.only(left: 20.0),
            //   child: AutoSizeText(
            //     'Recommended',
            //     style: GoogleFonts.exo(
            //       color: Utils.primaryFontColor,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //     ),
            //     textAlign: TextAlign.start,
            //   ),
            // ),

            // [
            //   {
            //     "_id": {"$oid": "6228d290755156ee50a9dd6d"},
            //     "product_name": "egg shells",
            //     "category": "Eggshells",
            //     "location": "Assam",
            //     "weight": 72,
            //     "price": 82,
            //     "uuid": 104,
            //     "img_url": "https://www.kindpng.com/picc/m/7-75336_cracked-eggshells-egg-shells-hd-png-download.png"
            //   },
            //   {
            //     "_id": {"$oid": "6228d290755156ee50a9dd70"},
            //     "product_name": "eggs",
            //     "category": "Eggshells",
            //     "location": "Delhi",
            //     "weight": 85,
            //     "price": 271,
            //     "uuid": 106,
            //     "img_url": "https://www.kindpng.com/picc/m/7-75336_cracked-eggshells-egg-shells-hd-png-download.png"
            //   },
            //   {
            //     "_id": {"$oid": "6228d290755156ee50a9dd74"},
            //     "product_name": "egg ",
            //     "category": "Eggshells",
            //     "location": "Gujarat",
            //     "weight": 81,
            //     "price": 891,
            //     "uuid": 106,
            //     "img_url": "https://www.kindpng.com/picc/m/7-75336_cracked-eggshells-egg-shells-hd-png-download.png"
            //   },
            //   {
            //     "_id": {"$oid": "6228d290755156ee50a9dd69"},
            //     "product_name": "vegetable market waste",
            //     "category": "Spoilt vegetables/fruits",
            //     "location": "Andhra Pradesh",
            //     "weight": 55,
            //     "price": 513,
            //     "uuid": 104,
            //     "img_url": "https://www.kindpng.com/picc/m/7-75336_cracked-eggshells-egg-shells-hd-png-download.png"
            //   },
            //   {
            //     "_id": {"$oid": "6228d290755156ee50a9dd6a"},
            //     "product_name": "hotel leftovers",
            //     "category": "Spoilt vegetables/fruits",
            //     "location": "Andhra Pradesh",
            //     "weight": 21,
            //     "price": 857,
            //     "uuid": 102,
            //     "img_url": "https://www.kindpng.com/picc/m/7-75336_cracked-eggshells-egg-shells-hd-png-download.png"
            //   },
            //   {
            //     "_id": {"$oid": "6228d290755156ee50a9dd6e"},
            //     "product_name": "fruit waste",
            //     "category": "Spoilt vegetables/fruits",
            //     "location": "Assam",
            //     "weight": 97,
            //     "price": 984,
            //     "uuid": 104,
            //     "img_url": "https://www.kindpng.com/picc/m/7-75336_cracked-eggshells-egg-shells-hd-png-download.png"
            //   },
            //   {
            //     "_id": {"$oid": "6228d290755156ee50a9dd72"},
            //     "product_name": "vegetable market waste",
            //     "category": "Spoilt vegetables/fruits",
            //     "location": "Delhi",
            //     "weight": 15,
            //     "price": 856,
            //     "uuid": 104,
            //     "img_url": "https://www.kindpng.com/picc/m/7-75336_cracked-eggshells-egg-shells-hd-png-download.png"
            //   }
            // ].map((recommendedList) =>  ListView.builder(
            //             physics: const BouncingScrollPhysics(),
            //             scrollDirection: Axis.horizontal,
            //             itemCount: recommendedList.length,
            //             itemBuilder: (context, index) {
            //               return ProductCard(
            //                 category: recommendedList[index]['category'],
            //                 toWhom: recommendedList[index]['location'],
            //                 weight: recommendedList[index]['weight'],
            //                 price: recommendedList[index]['price'],
            //                 name: recommendedList[index]["product_name"],
            //               );
            //             },
            //           ) ).toList(),

            // Container(
            //   padding: const EdgeInsets.only(left: 20),
            //   height: MediaQuery.of(context).size.height * 0.3,
            //   child: FutureBuilder(
            //       future: _homeProvider.recommended(),
            //       builder: ((context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.done) {
            //           print('data ${snapshot.data}');
            //           final recommendedList = snapshot.data as List;
            //           return;
            //         }
            //         return const LoadingScreen();
            //       })),
            // ),

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
