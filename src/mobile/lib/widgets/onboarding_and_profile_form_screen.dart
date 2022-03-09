import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingAndProfileFormScreen extends StatefulWidget {
  final String? appTitle;
  final String? name;
  final String? purpose;
  final String? location;
  final List<String?>? preferences;

  const OnboardingAndProfileFormScreen(
      {Key? key, this.appTitle, this.name, this.purpose, this.location, this.preferences})
      : super(key: key);

  @override
  _OnboardingAndProfileFormScreenState createState() => _OnboardingAndProfileFormScreenState();
}

class _OnboardingAndProfileFormScreenState extends State<OnboardingAndProfileFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return SafeArea(
      child: Scaffold(
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
                  widget.appTitle!,
                  style: GoogleFonts.exo(fontSize: 24, color: Colors.grey.shade900, fontWeight: FontWeight.bold),
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
                    initialValue: const {
                      "name": "",
                      "purpose": "",
                      "state": "Tamil Nadu",
                      "preferences": "",
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: 'name',

                                    decoration: const InputDecoration(
                                      labelText: 'Your Name',
                                      labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                                      border: InputBorder.none,
                                    ),

                                    // valueTransformer: (text) => num.tryParse(text),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                                child: Center(
                                  child: FormBuilderTextField(
                                    name: 'purpose',
                                    decoration: const InputDecoration(
                                      labelText: 'Your Purpose',
                                      labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                                      border: InputBorder.none,
                                    ),
                                    valueTransformer: (text) => num.tryParse(text!),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                                child: Center(
                                  child: FormBuilderDropdown(
                                    name: 'state',
                                    decoration: const InputDecoration(
                                      labelText: 'Choose State',
                                      labelStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none,
                                    ),
                                    // initialValue: 'Male',
                                    allowClear: true,

                                    validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                                    items: stateOptions
                                        .map((gender) => DropdownMenuItem(
                                              value: gender,
                                              child: Text(gender),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: FormBuilderFilterChip(
                                    name: 'preferences',
                                    checkmarkColor: Colors.black,
                                    disabledColor: Colors.grey.shade100,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    decoration: const InputDecoration(
                                        labelText: 'Preferences',
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(fontSize: 16, color: Colors.black)),
                                    options: [
                                      FormBuilderFieldOption(
                                        value: 'Test',
                                        child: Text(
                                          'Test',
                                          style: GoogleFonts.exo(color: Colors.black),
                                        ),
                                      ),
                                      FormBuilderFieldOption(
                                          value: 'Test 1',
                                          child: Text(
                                            'Test 1',
                                            style: GoogleFonts.exo(color: Colors.black),
                                          )),
                                      FormBuilderFieldOption(
                                          value: 'Test 2',
                                          child: Text('Test 2', style: GoogleFonts.exo(color: Colors.black))),
                                      FormBuilderFieldOption(
                                          value: 'Test 3',
                                          child: Text('Test 3', style: GoogleFonts.exo(color: Colors.black))),
                                      FormBuilderFieldOption(
                                          value: 'Test 4',
                                          child: Text('Test 4', style: GoogleFonts.exo(color: Colors.black))),
                                      FormBuilderFieldOption(
                                          value: 'Test 2',
                                          child: Text('Test 2', style: GoogleFonts.exo(color: Colors.black))),
                                      FormBuilderFieldOption(
                                          value: 'Test 3',
                                          child: Text('Test 3', style: GoogleFonts.exo(color: Colors.black))),
                                      FormBuilderFieldOption(
                                          value: 'Test 4',
                                          child: Text('Test 4', style: GoogleFonts.exo(color: Colors.black))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                      height: size.height * 0.05,
                      minWidth: size.width * 0.4,
                      color: color,
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          print(_formKey.currentState!.value);
                        } else {
                          print("validation failed");
                        }
                      },
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
      ),
    );
  }
}

var stateOptions = [
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttar Pradesh",
  "Uttarakhand",
  "Gairsain",
  "West Bengal"
];
