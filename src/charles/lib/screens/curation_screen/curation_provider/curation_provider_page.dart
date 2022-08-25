import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../profile_screen/profile_screen.dart';

class CurationProviderPage extends StatefulWidget {
  final List<dynamic> preferencesList;

  const CurationProviderPage({super.key, required this.preferencesList});

  @override
  State<CurationProviderPage> createState() => _CurationProviderPageState();
}

class _CurationProviderPageState extends State<CurationProviderPage> {
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Preferences',
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
      body: ListView.builder(
          itemCount: widget.preferencesList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                    ),
                    child: Text(
                      widget.preferencesList[index],
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 200.0),
                    child: Divider(
                      thickness: 2,
                      color: color,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
