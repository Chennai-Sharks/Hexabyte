import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/screens/auth_screen/auth_screen.dart';
import 'package:hexabyte/screens/profile_screen/widgets/order_history_card.dart';

import '../../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color? color =Colors.green.shade600;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: const Color(0xFFE9EFC0),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Your Profile",
          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),

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
        child: Container(
            height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/curation_bg.gif'))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
Center(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, top: 20),
                  width: size.width,
                  child: Center(
                    child: Text(
                      FirebaseAuth.instance.currentUser!.phoneNumber!,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            
              const   Center(
                child:CircleAvatar(
                  backgroundColor:Colors.white ,
                  backgroundImage: AssetImage('assets/user-profile.png'),
                  radius: 60,
                  ),
              ),
                Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(bottom: 3, left: 15.0, top: 10),
                              width: size.width,
                              child: Text(
                                'Name',
                                style: GoogleFonts.montserrat( fontSize: 14.0, color: color, fontWeight: FontWeight.bold),
                              ),
                            ),

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 0, left: 15.0, top: 10),
                  width: size.width,
                  child: Text(
                    'Kishore M',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
              ),


               ),
                 
               Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 3, left: 15.0, top: 10),
                width: size.width,
                child: Text(
                  'Business Type',
                  style: GoogleFonts.montserrat( fontSize: 14.0, color: color, fontWeight: FontWeight.bold),
                ),
              ),
  
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal:8.0),
                 child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, top: 10),
                  width: size.width,
                  child: Text(
                    'Small Scale Business',
                    style: GoogleFonts.montserrat( fontSize: 22.0),
                  ),
              ),
               ),

                  ],
          ),
        ),
      ),
    );
  }
}