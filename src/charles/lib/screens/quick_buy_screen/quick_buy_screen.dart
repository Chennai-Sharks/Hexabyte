import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/common/search_bar.dart';
import 'package:hexabyte/screens/quick_buy_screen/api/quick_buy_api.dart';
import 'package:hexabyte/screens/quick_buy_screen/widget/info_card.dart';
import 'package:hexabyte/screens/search_screen/search_screen.dart';

import '../profile_screen/profile_screen.dart';

class QuickBuyScreen extends StatefulWidget {
  const QuickBuyScreen({Key? key}) : super(key: key);

  @override
  State<QuickBuyScreen> createState() => _QuickBuyScreenState();
}

class _QuickBuyScreenState extends State<QuickBuyScreen> {
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = const Color(0xFFE9EFC0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9EFC0),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Buy',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Image.asset(
            "assets/logo.png",
            height: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: const SearchBar(),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: AutoSizeText(
                'Recommended for you',
                style: GoogleFonts.montserrat(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            FutureBuilder(
                future: QuickBuyApi.nearestItems(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // print(snapshot.data);
                    final response = snapshot.data as List<dynamic>;
                    return Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: InfoCard(
                            id: response[index]['_id']['\$oid'],
                            name: response[index]['food_waste_title'],
                            price: response[index]['cost'],
                            availableQty: response[index]['balance_qty'],
                            distance: '4.9 km',
                            duration: response[index]['duration'],
                            productData: response[index],
                            imageUrl: 'assets/logo.png',
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: AutoSizeText(
                'All Items nearby',
                style: GoogleFonts.montserrat(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            FutureBuilder(
                future: QuickBuyApi.nearestItems(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // print(snapshot.data);
                    final response = snapshot.data as List<dynamic>;
                    print(response[0]);
                    return Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length ?? 1,
                        itemBuilder: (context, index) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: InfoCard(
                            imageUrl: "assets/logo.png",
                            id: response[index]['_id']['\$oid'],
                            name: response[index]['food_waste_title'],
                            price: response[index]['cost'],
                            availableQty: response[index]['balance_qty'],
                            distance: '4.9 km',
                            duration: response[index]['duration'],
                            productData: response[index],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
            Container(
              height: MediaQuery.of(context).size.height * 0.03,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
