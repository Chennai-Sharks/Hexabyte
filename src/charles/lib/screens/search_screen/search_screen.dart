import 'package:flutter/material.dart';
import 'package:hexabyte/screens/search_screen/widgets/after_search.dart';

import 'package:hexabyte/screens/search_screen/widgets/before_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // if first search done is false, meaning that user has pressed the search bar from home
  // if first searchdone is true, meaning a search has been done so from now on only show after_search.dart
  bool firstSearchDone = false;
  final TextEditingController searchController = TextEditingController();

  void updateFirstSearchDone() {
    setState(() {
      firstSearchDone = true;
    });
  }

  void goBackToFirstSearch() {
    setState(() {
      firstSearchDone = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: firstSearchDone
          ? AfterSearch(
              searchController: searchController,
              goBackToFirstSearch: goBackToFirstSearch,
            )
          : BeforeSearch(
              searchDone: updateFirstSearchDone,
              searchController: searchController,
              // updateRecentSearches: updateRecentSearches,
              // recentSearches: recentSearches,
            ),
    );
  }
}
