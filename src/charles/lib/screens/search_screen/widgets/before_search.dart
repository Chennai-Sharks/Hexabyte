import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/search_screen/api/search_api.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeforeSearch extends StatefulWidget {
  final Function searchDone;
  final TextEditingController searchController;
  // final Function updateRecentSearches;
  // final List<String> recentSearches;
  const BeforeSearch({
    Key? key,
    required this.searchDone,
    required this.searchController,
    // required this.updateRecentSearches,
    // required this.recentSearches,
  }) : super(key: key);

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
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 2.0, bottom: 2.0),
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
                              hideOnLoading: false,
                              hideOnEmpty: true,
                              keepSuggestionsOnLoading: false,
                              loadingBuilder: (context) => const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Loading...',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              textFieldConfiguration: TextFieldConfiguration(
                                autofocus: true,
                                controller: widget.searchController,
                                onSubmitted: (value) {
                                  final search = snapshot.data!
                                      .getStringList('trending_search');
                                  if (search != null) {
                                    final recentSearches = [value, ...search];

                                    snapshot.data!.setStringList(
                                        'trending_search', recentSearches);
                                  } else {
                                    snapshot.data!.setStringList(
                                        'trending_search', [value]);
                                  }
                                  // widget.searchController.text = value;
                                  widget.searchDone();
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search for items',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
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

                                final searchResults =
                                    await SearchApi.productSearch(
                                        searchText: pattern);
                                return searchResults;
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(
                                      (suggestion as Map)['food_waste_title']),
                                  // subtitle: Text('${suggestion['price'].toString()} Rs'),
                                );
                              },
                              onSuggestionSelected: (suggestion) async {
                                final data = suggestion as Map;
                                widget.searchController.text =
                                    data['food_waste_title'];
                                final search = snapshot.data!
                                    .getStringList('trending_search');
                                if (search != null) {
                                  final List<String> recentSearches = [
                                    data['food_waste_title'],
                                    ...search
                                  ];

                                  snapshot.data!.setStringList(
                                      'trending_search', recentSearches);
                                } else {
                                  snapshot.data!.setStringList(
                                      'trending_search',
                                      [data['food_waste_title']]);
                                }

                                widget.searchDone();
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
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: snapshot.data!
                                    .getStringList('trending_search')
                                    ?.isEmpty ??
                                true
                            ? Container(
                                margin: const EdgeInsets.all(20),
                                child: const Center(
                                  child: Text('No Recent searches.'),
                                ),
                              )
                            : Center(
                                child: FormBuilderChoiceChip(
                                  name: 'recent_search',
                                  spacing: 10,
                                  onChanged: (value) {
                                    // use on changed to go to next search (after_search)
                                    widget.searchController.text =
                                        value as String;
                                    widget.searchDone();
                                  },
                                  disabledColor: Colors.grey.shade100,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  options: (snapshot.data!
                                              .getStringList('trending_search')
                                              ?.take(6) ??
                                          [])
                                      .map(
                                        (eachItem) => FormBuilderFieldOption(
                                          key: Key(eachItem),
                                          value: eachItem,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                child: const Icon(
                                                  Icons.replay,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              Text(
                                                eachItem.sentenceCase,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.black),
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
                    // SizedBox(
                    //   height: height * 0.03,
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 25),
                    //   child: AutoSizeText(
                    //     'Recommended products',
                    //     style: GoogleFonts.montserrat(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 18,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(9),
                    //   child: Container(
                    //     margin: const EdgeInsets.only(left: 25),
                    //     child: Center(
                    //       child: FormBuilderChoiceChip(
                    //         name: 'recent_search',
                    //         spacing: 10,
                    //         onChanged: (value) {
                    //           // use on changed to go to next search (after_search)
                    //           print(value);
                    //         },
                    //         disabledColor: Colors.grey.shade100,
                    //         crossAxisAlignment: WrapCrossAlignment.start,
                    //         decoration: const InputDecoration(
                    //           border: InputBorder.none,
                    //         ),
                    //         options: (['prod_1', 'prod_2', 'prod_3', 'prod_4', 'prod_5', 'prod_6'])
                    //             .map(
                    //               (eachItem) => FormBuilderFieldOption(
                    //                 key: Key(eachItem),
                    //                 value: eachItem,
                    //                 child: Row(
                    //                   mainAxisSize: MainAxisSize.min,
                    //                   children: [
                    //                     Container(
                    //                       margin: const EdgeInsets.only(right: 5),
                    //                       child: const Icon(
                    //                         Icons.replay,
                    //                         color: Colors.black45,
                    //                       ),
                    //                     ),
                    //                     Text(
                    //                       eachItem.sentenceCase,
                    //                       style: GoogleFonts.montserrat(color: Colors.black),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             )
                    //             .toList(),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
