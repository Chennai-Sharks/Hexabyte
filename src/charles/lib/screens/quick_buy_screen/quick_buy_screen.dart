import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/common/search_bar.dart';
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
    Color? color =const  Color(0xFFE9EFC0);
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFC0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
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
                    builder: (context) => SearchPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
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
            ),
            Container(
              color: Colors.white,
              child: LimitedBox(
                maxHeight: 270.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => index % 2 == 0
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              InfoCard(),
                              InfoCard(),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
            Container(
              width: size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, top: 15),
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
            ),
            Container(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: InfoCard(),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.03,
              color : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
