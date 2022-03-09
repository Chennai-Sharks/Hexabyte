import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/product_details_screen/product_details_screen.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Utils.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            AutoSizeText(
              'Search Page',
              style: GoogleFonts.exo(
                color: Utils.primaryFontColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  decoration: InputDecoration(
                    label: const Text(
                      'Seach for products',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  // backend call.
                  await Future.delayed(Duration(seconds: 2));
                  return [];
                },
                itemBuilder: (context, suggestion) {
                  return const ListTile(
                    title: Text('lalala'),
                    // subtitle: Text('\$${suggestion['price']}'),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage()));
                },
              ),
            ),
            // FormBuilder(
            //   child: Padding(
            //     padding: const EdgeInsets.all(9),
            //     child: Container(
            //       decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 11.0),
            //         child: Center(
            //           child: FormBuilderDropdown(
            //             name: 'state',
            //             decoration: const InputDecoration(
            //               labelText: 'Choose State',
            //               labelStyle: TextStyle(color: Colors.black),
            //               border: InputBorder.none,
            //             ),
            //             // initialValue: 'Male',
            //             allowClear: true,

            //             validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
            //             items: stateOptions
            //                 .map((gender) => DropdownMenuItem(
            //                       value: gender,
            //                       child: Text(gender),
            //                     ))
            //                 .toList(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: height * 0.06,
            ),
            SizedBox(
              height: 210,
              child: SvgPicture.asset('assets/search.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
