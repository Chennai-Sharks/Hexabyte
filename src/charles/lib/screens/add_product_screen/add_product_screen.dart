import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/providers/add_product/add_product_provider.dart';
// import 'package:hexabyte/widgets/onboarding_and_profile_form_screen.dart';
import 'package:hexabyte/screens/onboarding_screen/onboarding_screen.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final AddProductProvider _addProductProvider = AddProductProvider();

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Your Product",
          style:
              GoogleFonts.exo(fontSize: 24, color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.025,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                width: size.width * 0.95,
                child: Column(children: <Widget>[
                  FormBuilder(
                      key: _formKey,
                      initialValue: {
                        "name": "",
                        "category": 'Consumable food scraps',
                        "location": stateOptions[0].toString(),
                      },
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5)],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: FormBuilderTextField(
                                        name: 'product_name',
                                        style: TextStyle(fontSize: 16),

                                        decoration: InputDecoration(
                                          labelText: 'Name Of Product',
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).secondaryHeaderColor,
                                          ),
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
                                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5)],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: FormBuilderDropdown(
                                        name: 'location',
                                        decoration: InputDecoration(
                                          labelText: 'Choose Location',
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).secondaryHeaderColor,
                                          ),
                                        ),
                                        allowClear: true,
                                        validator:
                                            FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
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
                                padding: const EdgeInsets.only(left: 9.0, right: 9, top: 9),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5)],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Center(
                                      child: FormBuilderDropdown(
                                        name: 'category',
                                        decoration: InputDecoration(
                                          labelText: 'Choose Category',
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).secondaryHeaderColor,
                                          ),
                                        ),
                                        allowClear: true,
                                        validator:
                                            FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                                        items: [
                                          'Consumable food scraps',
                                          'Eggshells',
                                          'Excess food',
                                          'Rotten peels',
                                          'Spoilt vegetables/fruits',
                                          'Waste oils'
                                        ]
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
                                padding: const EdgeInsets.all(09),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5)],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Center(
                                      child: FormBuilderTextField(
                                        name: 'weight',

                                        decoration: InputDecoration(
                                          labelText: 'Weight (in KG)',
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).secondaryHeaderColor,
                                          ),
                                          border: InputBorder.none,
                                        ),

                                        // valueTransformer: (text) => num.tryParse(text),
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(context),
                                          FormBuilderValidators.numeric(context),
                                        ]),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9, right: 9),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5)],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Center(
                                      child: FormBuilderTextField(
                                        name: 'price',

                                        decoration: InputDecoration(
                                          labelText: 'Cost (In Rupees)',
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).secondaryHeaderColor,
                                          ),
                                          border: InputBorder.none,
                                        ),

                                        // valueTransformer: (text) => num.tryParse(text),
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(context),
                                          FormBuilderValidators.numeric(context),
                                        ]),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9, right: 9, top: 9, bottom: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5)],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Center(
                                      child: FormBuilderTextField(
                                        name: 'description',

                                        decoration: InputDecoration(
                                          labelText: 'Description',
                                          labelStyle: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).secondaryHeaderColor,
                                          ),
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
                            ]),
                      )),
                  MaterialButton(
                    height: size.height * 0.08,
                    minWidth: size.width * 0.4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: color,
                    child: Text(
                      "Submit",
                      style: GoogleFonts.exo(
                          color: Theme.of(context).primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        print(_formKey.currentState!.value);
                        await _addProductProvider.addProduct(_formKey.currentState!.value);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const NavigationLayout()),
                        );
                        Fluttertoast.showToast(msg: 'Product added');
                      } else {
                        print("validation failed");
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
