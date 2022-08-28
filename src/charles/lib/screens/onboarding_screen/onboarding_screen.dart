import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/onboarding_screen/api/onboading_api.dart';
import 'package:hexabyte/screens/onboarding_screen/config/form_structure.dart';
import 'package:hexabyte/screens/select_role_screen.dart/select_role_screen.dart';
import 'package:hexabyte/utils/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Onboarding',
          style: GoogleFonts.montserrat(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.025,
            ),
            Center(
              child: Text(
                'Welcome! Enter your details',
                style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
              width: size.width * 0.9,
              child: Column(children: <Widget>[
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: onBoardingForm.map((item) {
                      if (item['type'] == 'text') {
                        return Padding(
                          padding: const EdgeInsets.all(9),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 11.0),
                              child: Center(
                                child: FormBuilderTextField(
                                  name: item['name'],
                                  decoration: InputDecoration(
                                    labelText: item['label'],
                                    labelStyle: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    border: InputBorder.none,
                                  ),

                                  // valueTransformer: (text) => num.tryParse(text),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
                                  keyboardType: item['keyboardType'],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                        LocationPermission permission =
                            await Geolocator.requestPermission();

                        if (permission == LocationPermission.denied) {
                          Fluttertoast.showToast(
                              msg: 'Location is needed to move further.');
                          return;
                        }

                        EasyLoading.show(status: 'loading...');

                        Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy:
                                LocationAccuracy.bestForNavigation);
                        print(position.longitude);
                        print(position.latitude);
                        print(_formKey.currentState!.value);
                        print(FirebaseAuth.instance.currentUser!.phoneNumber!);
                        final formValue = {..._formKey.currentState!.value};
                        formValue.update('age', (value) => int.parse(value));
                        final response =
                            await OnboardingApi.dataCollection(data: {
                          ...formValue,
                          // 'location': {
                          //   'type': 'Point',
                          //   'coordinates': [position.longitude, position.latitude]
                          // },
                          'location': [position.latitude, position.longitude],
                          'phone': FirebaseAuth
                              .instance.currentUser!.phoneNumber!
                              .substring(3)
                        });
                        if (response == 1) {
                          EasyLoading.dismiss();
                          navContext.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SelectRoleScreen(),
                            ),
                          );
                        } else {
                          EasyLoading.dismiss();
                          Fluttertoast.showToast(msg: 'Server error');
                        }
                      } else {
                        Fluttertoast.showToast(msg: 'validation failed');
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
                SizedBox(
                  height: size.height * 0.05,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
