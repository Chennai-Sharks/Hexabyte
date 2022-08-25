import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/common/custom_divider.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/screens/auth_screen/auth_screen.dart';
import 'package:hexabyte/screens/loading_screen/loading_screen.dart';
import 'package:hexabyte/screens/profile_screen/widgets/order_history_card.dart';
import 'package:hexabyte/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Your Profile",
          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const NavigationLayout(
                      isConsumer: true,
                    )));
          },
        ),
        actions: <Widget>[
          // const Icon(Icons.favorite_border),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final navContext = Navigator.of(context);
              await FirebaseAuth.instance.signOut();
              navContext.pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, top: 10),
                  width: size.width,
                  child: Text(
                    FirebaseAuth.instance.currentUser!.phoneNumber!,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, top: 10),
                  width: size.width,
                  child: Text(
                    'Order History',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => OrderHistoryCard(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
