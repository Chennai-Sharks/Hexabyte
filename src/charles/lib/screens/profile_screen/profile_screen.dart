import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/providers/auth/auth_provider.dart';
import 'package:hexabyte/providers/proflile/profile_provider.dart';
import 'package:hexabyte/screens/auth_screen/auth_screen.dart';
import 'package:hexabyte/screens/loading_screen/loading_screen.dart';
import 'package:hexabyte/screens/profile_screen/widgets/option_container.dart';
import 'package:hexabyte/screens/profile_screen/widgets/your_orders.dart';
import 'package:hexabyte/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final String? name;
  final String? email;
  final String? imageUrl;

  const ProfileScreen({Key? key, this.name, this.email, this.imageUrl}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthProvider _authProvider = AuthProvider();
  final ProfileProvider _profileProvider = ProfileProvider();
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = Utils.primaryColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
          elevation: 0,
          title: Text(
            'My Profile',
            style: GoogleFonts.exo(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            splashRadius: 25,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: FutureBuilder(
          future: _profileProvider.getProfileData(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data);
              return Container(
                color: Theme.of(context).primaryColor,
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                        child: Container(
                          height: size.height * 0.48,
                          color: Theme.of(context).secondaryHeaderColor.withAlpha(50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: size.height * 0.03),
                              Center(
                                child: Container(
                                  height: size.width * 0.3,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/logo.png'),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.015),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Hello',
                                      style: GoogleFonts.notoSansAnatolianHieroglyphs(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).secondaryHeaderColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => OnboardingAndProfileFormScreen(
                                          //       appTitle: "Update Your Profile",
                                          //       location: "Location",

                                          //       name: "Name",
                                          //       preferences: ["preferences"],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.pencilAlt,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "Location",
                                  style: GoogleFonts.notoSansAnatolianHieroglyphs(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.05),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  optionContainer(
                                    color,
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
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Your Orders',
                            style: GoogleFonts.exo(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   color: Colors.grey.shade200,
                      //   child: const YourOrders(),
                      // ),
                    ],
                  ),
                ),
              );
            }
            return const LoadingScreen();
          },
        ),
      ),
    );
  }
}
