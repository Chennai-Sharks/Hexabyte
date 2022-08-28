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
      backgroundColor: const Color(0xFFE9EFC0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9EFC0),
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
      ),
      body: FutureBuilder(
          future: ListedProductApi.getMyProducts(),
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
                  print('here');
                  print(snapshot.data);
                  final response = snapshot.data as List?;
                  if (response == null) {
                    return const Center(child: Text('No data.'));
                  }
                  if (response.isEmpty) {
                    return const Center(child: Text('No data.'));
                  }
                  final reversedData = response.reversed.toList();
                  return RefreshIndicator(
                    onRefresh: () async {
                      // ListedProductApi.getMyProducts(data: data);
                    },
                    child: ListView.builder(
                      itemCount: (snapshot.data as List).length,
                      itemBuilder: (BuildContext context, index) => ListedProductCard(
                        title: reversedData[index]['food_waste_title'],
                        description: reversedData[index]['description'],
                        business: reversedData[index]['business'],
                        subscribedQty: reversedData[index]['subscribed_qty'],
                        totalQty: reversedData[index]['total_qty'],
                        tags: reversedData[index]['applicable_tags'],
                        balanceQty: reversedData[index]['balance_qty'],
                        cost: reversedData[index]['cost'],
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }
}
