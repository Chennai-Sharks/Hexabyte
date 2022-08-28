import 'package:count_stepper/count_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/curation_screen/api/curation_api.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:recase/recase.dart';

import '../../profile_screen/profile_screen.dart';

class CurationProviderPage extends StatefulWidget {
  final List<dynamic> preferencesList;

  const CurationProviderPage({super.key, required this.preferencesList});

  @override
  State<CurationProviderPage> createState() => _CurationProviderPageState();
}

class _CurationProviderPageState extends State<CurationProviderPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;

    // Size? size = MediaQuery.of(context).size;

    // Color? color = Colors.redAccent.shade700;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select your combo',
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
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Image.asset(
            "assets/logo.png",
            height: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: CurationApi.getCurationData(data: {
              "phone": FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3),
              "tags": widget.preferencesList,
            }),
            builder: (context, AsyncSnapshot<Object> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                print('here');
                print(snapshot.data);
                final keys = (snapshot.data as Map).keys.toList();
                final data = (snapshot.data ?? {}) as Map;
                return Center(
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...keys
                            .map((item) => Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: FormBuilderCheckboxGroup(
                                          name: item,
                                          // spacing: 10,
                                          initialValue: const [],
                                          validator: (value) => value!.isEmpty ? 'This field cannot be empty.' : null,
                                          // checkmarkColor: Colors.black,
                                          // disabledColor: Colors.grey.shade100,
                                          // crossAxisAlignment: WrapCrossAlignment.start,
                                          decoration: InputDecoration(
                                            labelText: 'Select for ${(item as String).titleCase} combo',
                                            border: InputBorder.none,
                                            labelStyle: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          options: (data[item] as List)
                                              .map(
                                                (eachItem) => FormBuilderFieldOption(
                                                  // key: Key((eachItem['producer_id'] as int).toString()),
                                                  value: eachItem['food_waste_title'],
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Name:' + (eachItem['food_waste_title'] as String).sentenceCase,
                                                        style: GoogleFonts.montserrat(color: Colors.black),
                                                      ),
                                                      Text(
                                                        'Available Qty:' +
                                                            (eachItem['balance_qty'] as int).toString().sentenceCase,
                                                        style: GoogleFonts.montserrat(color: Colors.black),
                                                      ),
                                                      CountStepper(
                                                        defaultValue: 1,
                                                        min: 1,
                                                        max: eachItem['balance_qty'],
                                                        onPressed: (value) {
                                                          print(item);
                                                          eachItem['subscribed_qty'] = value;
                                                          print(data);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
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
                                  print(_formKey.currentState!.value);
                                  print(data);

                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => AddQuantityCurationPage(
                                  //           selectedCombo: _formKey.currentState!.value,
                                  //           data: snapshot.data as Map,
                                  //         )));

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
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
