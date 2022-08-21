import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/search_screen/widgets/after_search_card.dart';

class AfterSearch extends StatefulWidget {
  final Function goBackToFirstSearch;
  final TextEditingController searchController;
  const AfterSearch({Key? key, required this.searchController, required this.goBackToFirstSearch}) : super(key: key);

  @override
  State<AfterSearch> createState() => _AfterSearchState();
}

class _AfterSearchState extends State<AfterSearch> {
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
                          autofocus: false,
                          controller: widget.searchController,
                          onTap: () {
                            widget.goBackToFirstSearch();
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: Colors.grey,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                ),
                            border: InputBorder.none,
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return [];
                        },
                        itemBuilder: (context, suggestion) {
                          return const ListTile(
                            title: Text(''),
                            // subtitle: Text('${suggestion['price'].toString()} Rs'),
                          );
                        },
                        onSuggestionSelected: (suggestion) {},
                      ),
                    ),
                    // UIHelper.horizontalSpaceMedium(),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: AutoSizeText(
                  'Results matching your search',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const AfterSearchCard(),
              const AfterSearchCard(),
              const AfterSearchCard(),
              const AfterSearchCard(),
              const AfterSearchCard(),
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