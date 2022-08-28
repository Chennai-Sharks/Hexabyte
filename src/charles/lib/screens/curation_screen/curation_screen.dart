import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/curation_screen/curation_provider/curation_provider_page.dart';
import 'package:recase/recase.dart';

import '../../utils/utils.dart';
import '../profile_screen/profile_screen.dart';

class CurationScreen extends StatefulWidget {
  const CurationScreen({Key? key}) : super(key: key);

  @override
  State<CurationScreen> createState() => _CurationScreenState();
}

class _CurationScreenState extends State<CurationScreen> {
  List<String?> preferenceList = [
    'food_waste',
    'organic_waste',
    'fruit_pulp',
    'fruit_peels',
    'fruit_seeds',
    'vegetable_peels',
    'sugary_starchy_waste',
    'fatty_foodwaste',
    'edible_oilwaste',
  ];
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9EFC0),
        elevation: 0,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Combo Buy',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
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
            const SizedBox(
              height: 10,
            )
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
      body: Container(
        height: size.height,
        decoration:
            const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/curation_bg.gif'))),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.05),
                Text(
                  'Select Tags',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: FormBuilderFilterChip(
                        name: "preferences",
                        spacing: 10,
                        initialValue: const [],
                        validator: (value) => value!.isEmpty ? 'This field cannot be empty.' : null,
                        checkmarkColor: Colors.black,
                        disabledColor: Colors.grey.shade100,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        decoration: InputDecoration(
                          // labelText: "Pick",
                          border: InputBorder.none,
                          labelStyle: GoogleFonts.montserrat(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        options: (preferenceList)
                            .map(
                              (eachItem) => FormBuilderFieldOption(
                                key: Key(eachItem!),
                                value: eachItem,
                                child: Text(
                                  eachItem.sentenceCase,
                                  style: GoogleFonts.montserrat(color: Colors.black),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.14,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Utils.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () async {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          final List<dynamic> finalList = _formKey.currentState!.value['preferences'];

                          if (finalList.isEmpty) {
                            EasyLoading.dismiss();
                            Fluttertoast.showToast(msg: 'No products has been added!');
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CurationProviderPage(preferencesList: finalList as dynamic)));
                            Fluttertoast.showToast(msg: 'Fetching your preferences ...');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Validation Failed ...');
                        }
                      },
                      child: Text(
                        'Submit',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Utils.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
