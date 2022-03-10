import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/providers/search/search_provider.dart';
import 'package:hexabyte/screens/product_details_screen/product_details_screen.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final SearchProvider _searchProvider = SearchProvider();

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
                  // print(pattern.);
                  // backend call.
                  final searchResults = _searchProvider.searchResults(
                    query: pattern,
                  );

                  return searchResults;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text((suggestion as Map)['product_name']),
                    subtitle: Text('${suggestion['price'].toString()} Rs'),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  final data = suggestion as Map;
                  print(data);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        productName: data['product_name'],
                        sellerId: data['uuid'].toString(),
                        category: data['category'],
                        description: data['description'] ?? 'No description',
                        location: data['location'],
                        weight: data['weight'].toString(),
                        price: data['price'].toString(),
                        orderType: 'Onetime only',
                      ),
                    ),
                  );
                },
              ),
            ),
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: Center(
                      child: FormBuilderDropdown(
                        name: 'state',
                        decoration: const InputDecoration(
                          labelText: 'Choose Category',
                          labelStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                        ),
                        // initialValue: 'Male',
                        allowClear: true,

                        validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                        items: [
                          'Consumable food scraps',
                          'Eggshells',
                          'Excess food',
                          'Rotten peels',
                          'Spoilt vegetables/fruits',
                          'Waste oils'
                        ]
                            .map((data) => DropdownMenuItem(
                                  value: data,
                                  child: Text(data),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
