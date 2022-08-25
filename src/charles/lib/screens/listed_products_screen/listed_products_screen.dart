import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/screens/listed_products_screen/api/listed_products_api.dart';
import 'package:hexabyte/screens/listed_products_screen/widgets/listed_product_card.dart';

class ListedProductsScreen extends StatefulWidget {
  const ListedProductsScreen({Key? key}) : super(key: key);

  @override
  State<ListedProductsScreen> createState() => _ListedProductsScreenState();
}

class _ListedProductsScreenState extends State<ListedProductsScreen> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Listed Products',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const NavigationLayout(
                      isConsumer: false,
                    )));
          },
        ),
      ),
      body: FutureBuilder(
          future: ListedProductApi.getMyProducts(data: data),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                {
                  return const Center(
                    child: Text('Loading...'),
                  );
                }
              case ConnectionState.done:
                {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ListedProductApi.getMyProducts(data: data);
                    },
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, index) => ListedProductCard(),
                    ),
                  );
                }
            }
          }),
    );
  }
}
