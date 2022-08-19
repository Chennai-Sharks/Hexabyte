import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recase/recase.dart';

class BeforeSearch extends StatefulWidget {
  final Function searchDone;
  final TextEditingController searchController;
  const BeforeSearch({Key? key, required this.searchDone, required this.searchController}) : super(key: key);

  @override
  State<BeforeSearch> createState() => _BeforeSearchState();
}

class _BeforeSearchState extends State<BeforeSearch> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Container(
                padding: const EdgeInsets.only(left: 15.0, top: 2.0, bottom: 2.0),
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: const Offset(2.0, 2.0),
                    )
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: TypeAheadField(
                        hideOnLoading: true,
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          controller: widget.searchController,
                          onSubmitted: (value) {
                            print(value);
                            // widget.searchController.text = value;
                            widget.searchDone();
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for items',
                            hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: Colors.grey,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                ),
                            border: InputBorder.none,
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.isEmpty) {
                            return [];
                          }
                          return [
                            {'product_name': 'hello'}
                          ];
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text((suggestion as Map)['product_name']),
                            // subtitle: Text('${suggestion['price'].toString()} Rs'),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          final data = suggestion as Map;
                          print(data);
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductDetailsPage(
                          //       productName: data['product_name'],
                          //       sellerId: data['uuid'].toString(),
                          //       category: data['category'],
                          //       description: data['description'] ?? 'No description',
                          //       location: data['location'],
                          //       weight: data['weight'].toString(),
                          //       price: data['price'].toString(),
                          //       orderType: 'Onetime only',
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: AutoSizeText(
                  'Recent Searches',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: Center(
                    child: FormBuilderChoiceChip(
                      name: 'recent_search',
                      spacing: 10,
                      onChanged: (value) {
                        // use on changed to go to next search (after_search)
                        print(value);
                      },
                      disabledColor: Colors.grey.shade100,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      options: (['prod_1', 'prod_2', 'prod_3', 'prod_4', 'prod_5', 'prod_6'])
                          .map(
                            (eachItem) => FormBuilderFieldOption(
                              key: Key(eachItem),
                              value: eachItem,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      Icons.replay,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Text(
                                    eachItem.sentenceCase,
                                    style: GoogleFonts.roboto(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 7,
                color: Colors.black12,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: AutoSizeText(
                  'Recommended products',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: Container(
                  margin: const EdgeInsets.only(left: 25),
                  child: Center(
                    child: FormBuilderChoiceChip(
                      name: 'recent_search',
                      spacing: 10,
                      onChanged: (value) {
                        // use on changed to go to next search (after_search)
                        print(value);
                      },
                      disabledColor: Colors.grey.shade100,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      options: (['prod_1', 'prod_2', 'prod_3', 'prod_4', 'prod_5', 'prod_6'])
                          .map(
                            (eachItem) => FormBuilderFieldOption(
                              key: Key(eachItem),
                              value: eachItem,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      Icons.replay,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Text(
                                    eachItem.sentenceCase,
                                    style: GoogleFonts.roboto(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
