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
    'Food Waste',
    'Organic Waste',
    'Fruit Pulp',
    'Fruit Peels',
    'Fruit Seeds',
    'Vegetable Peels',
    'Sugary Starchy Waste',
    'Fatty Food Waste',
    'Edible Oil Waste',
  ];
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Combo Buys',
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
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.all(9),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: FormBuilderFilterChip(
                        name: "preferences",
                        spacing: 10,
                        initialValue: const [],
                        validator: (value) => value!.isEmpty
                            ? 'This field cannot be empty.'
                            : null,
                        checkmarkColor: Colors.black,
                        disabledColor: Colors.grey.shade100,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        decoration: InputDecoration(
                          labelText: "Pick any 3 out",
                          border: InputBorder.none,
                          labelStyle: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        options: (preferenceList as List<String?>)
                            .map(
                              (eachItem) => FormBuilderFieldOption(
                                key: Key(eachItem!),
                                value: eachItem,
                                child: Text(
                                  eachItem.sentenceCase,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Utils.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () async {
                    final navContext = Navigator.of(context);
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      // EasyLoading.show(status: 'Loading...');
                      // final formValue = {..._formKey.currentState!.value};
                      final List<dynamic> finalList =
                          _formKey.currentState!.value['preferences'];

                      if (finalList.length == 0) {
                        EasyLoading.dismiss();
                        Fluttertoast.showToast(
                            msg: 'No products has been added!');
                      } else if (finalList.length > 3) {
                        EasyLoading.dismiss();
                        Fluttertoast.showToast(
                            msg:
                                'Number of products must be less than or equal to 3 ... ');
                      } else {
                        for (int i = 0; i < finalList.length; i++) {
                          print(finalList[i]);
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CurationProviderPage(
                                    preferencesList: finalList as dynamic)));
                        Fluttertoast.showToast(
                            msg: 'Fetching your preferences ...');
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Validation Failed ...');
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 15,
                      color: Utils.white,
                    ),
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
