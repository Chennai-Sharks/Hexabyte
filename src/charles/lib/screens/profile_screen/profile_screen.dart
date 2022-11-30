import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/screens/auth_screen/auth_screen.dart';
import 'package:hexabyte/screens/profile_screen/api/profile_screen_api.dart';
import 'package:hexabyte/screens/select_role_screen.dart/select_role_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color? color = Colors.green.shade600;
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NavigationLayout(
                  isConsumer: true,
                ),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              final navContext = Navigator.of(context);
              navContext.pushReplacement(MaterialPageRoute(builder: (context) => const SelectRoleScreen()));
            },
          ),
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
      body: Container(
        height: size.height,
        width: size.width,
        decoration:
            const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/curation_bg.gif'))),
        child: FutureBuilder(
          future: ProfileScreenApi.getUserProfile(),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              case ConnectionState.done:
                {
                  final response = snapshot.data as Map?;
                  print(response);
                  if (response == null) {
                    return const Center(child: Text('No data.'));
                  }
                  if (response.isEmpty) {
                    return const Center(child: Text('No data.'));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: ProfilePicture(
                            name: response['name'] ?? 'NN',
                            radius: 40,
                            fontsize: 25,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(bottom: 3, left: 15.0, top: 10),
                        width: size.width,
                        child: Text(
                          'Name',
                          style: GoogleFonts.montserrat(fontSize: 14.0, color: color, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, top: 10),
                          width: size.width,
                          child: Text(
                            response['name'] ?? 'Not available',
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
                          style: GoogleFonts.montserrat(fontSize: 14.0, color: color, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, top: 10),
                          width: size.width,
                          child: Text(
                            response['business'] ?? 'Not available',
                            style: GoogleFonts.montserrat(fontSize: 22.0),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(bottom: 3, left: 15.0, top: 10),
                        width: size.width,
                        child: Text(
                          'Phone number',
                          style: GoogleFonts.montserrat(fontSize: 14.0, color: color, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, top: 10),
                          width: size.width,
                          child: Text(
                            response['phone'] ?? 'Not available',
                            style: GoogleFonts.montserrat(fontSize: 22.0),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(bottom: 3, left: 15.0, top: 10),
                        width: size.width,
                        child: Text(
                          'Email Id',
                          style: GoogleFonts.montserrat(fontSize: 14.0, color: color, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, top: 10),
                          width: size.width,
                          child: Text(
                            response['email'] ?? 'Not available',
                            style: GoogleFonts.montserrat(fontSize: 22.0),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
