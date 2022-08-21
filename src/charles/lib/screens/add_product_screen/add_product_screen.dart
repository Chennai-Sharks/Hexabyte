import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/screens/add_product_screen/api/add_product_api.dart';
import 'package:hexabyte/screens/add_product_screen/config/form_structure.dart';
import 'package:recase/recase.dart';
import 'package:hexabyte/utils/utils.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  AddProductsScreenState createState() => AddProductsScreenState();
}

class AddProductsScreenState extends State<AddProductsScreen> {
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
                'Enter the details',
                style: GoogleFonts.montserrat(fontSize: 24, color: Colors.grey.shade900, fontWeight: FontWeight.bold),
              ),
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
                        EasyLoading.show(status: 'Loading...');
                        final formValue = {..._formKey.currentState!.value};
                        // formValue['age'] = int.parse(formValue['age']);
                        formValue.update('duration', (value) => int.parse(value));
                        formValue.update('total_qty', (value) => int.parse(value));
                        formValue['producer_id'] = FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3);
                        final response = await AddProductApi.itemAddition(data: formValue);

                        if (response == 1) {
                          EasyLoading.dismiss();
                          Fluttertoast.showToast(msg: 'Product added successfully!');

                          navContext.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const NavigationLayout(),
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
