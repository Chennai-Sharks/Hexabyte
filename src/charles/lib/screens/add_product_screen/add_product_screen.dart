import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/screens/add_product_screen/api/add_product_api.dart';
import 'package:hexabyte/screens/add_product_screen/config/form_structure.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:recase/recase.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  AddProductsScreenState createState() => AddProductsScreenState();
}

class AddProductsScreenState extends State<AddProductsScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Your Product",
          style: GoogleFonts.montserrat(
              fontSize: 24, color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE9EFC0),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration:
            const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/curation_bg.gif'))),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.025,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: Column(children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: addProductFormStructure.map((item) {
                          if (item['type'] == 'text') {
                            return Padding(
                              padding: const EdgeInsets.all(9),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 11.0),
                                  child: Center(
                                    child: FormBuilderTextField(
                                      name: item['name'],

                                      decoration: InputDecoration(
                                        labelText: item['label'],
                                        labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                      maxLines: item['multiline'] ?? false ? 5 : 1,

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
                          } else if (item['type'] == 'multichip') {
                            return Padding(
                              padding: const EdgeInsets.all(9),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: FormBuilderFilterChip(
                                      name: item['name'],
                                      spacing: 10,
                                      initialValue: const [],
                                      validator: (value) => value!.isEmpty ? 'This field cannot be empty.' : null,
                                      checkmarkColor: Colors.black,
                                      disabledColor: Colors.grey.shade100,
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      decoration: InputDecoration(
                                        labelText: item['label'],
                                        border: InputBorder.none,
                                        labelStyle: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      options: (item['values'] as List<String>)
                                          .map(
                                            (eachItem) => FormBuilderFieldOption(
                                              key: Key(eachItem),
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
                            );
                          } else if (item['type'] == 'date') {
                            return Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: FormBuilderDateTimePicker(
                                      name: item['name'],
                                      decoration: InputDecoration(
                                        labelText: 'Select expiry date',
                                        border: InputBorder.none,
                                        labelStyle: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      initialDatePickerMode: DatePickerMode.day,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2023),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: FormBuilderDropdown<String>(
                                      // autovalidate: true,
                                      name: 'gender',
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Duration Type',
                                        suffix: FaIcon(FontAwesomeIcons.calendar),
                                        hintText: '',
                                      ),
                                      validator:
                                          FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                                      items: (item['values'] as List<String?>)
                                          .map((value) => DropdownMenuItem(
                                                alignment: AlignmentDirectional.center,
                                                value: value,
                                                child: Text(value!),
                                              ))
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {});
                                      },
                                      valueTransformer: (val) => val?.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
                              EasyLoading.show(status: 'Loading...');
                              final formValue = {..._formKey.currentState!.value};
                              print(formValue);
                              // formValue['age'] = int.parse(formValue['age']);
                              formValue.update('duration', (value) => int.parse(value));
                              formValue.update('total_qty', (value) => int.parse(value));
                              formValue.update('cost', (value) => int.parse(value));
                              formValue.update('expiry_date', (value) => (value as DateTime).toString());

                              formValue['producer_id'] = FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3);
                              final response = await AddProductApi.itemAddition(data: formValue);

                              if (response == 1) {
                                EasyLoading.dismiss();
                                Fluttertoast.showToast(msg: 'Product added successfully!');

                                navContext.pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const NavigationLayout(isConsumer: false),
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
      ),
    );
  }
}
