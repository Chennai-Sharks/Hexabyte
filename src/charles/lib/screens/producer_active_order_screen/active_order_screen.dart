import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/producer_active_order_screen/api/listed_products_api.dart';
import 'package:hexabyte/screens/producer_active_order_screen/widgets/active_order_card.dart';

class ActiveOrderScreen extends StatefulWidget {
  const ActiveOrderScreen({Key? key}) : super(key: key);

  @override
  State<ActiveOrderScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
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
              'Active orders',
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
          future: ActiveOrders.getOrders(),
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
                  final response = snapshot.data as List;
                  if (response.isEmpty) {
                    return const Center(child: Text('No data.'));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      // ListedProductApi.getMyProducts(data: data);
                    },
                    child: ListView.builder(
                      itemCount: (snapshot.data as List).length,
                      itemBuilder: (BuildContext context, index) => ActiveOrderCard(
                        name: response[index]['name'], // 6
                        phone: response[index]['phone'], //7
                        foodWasteTitle: response[index]['food_waste_title'],
                        subscribedQty: response[index]['subscribed_qty'], //
                        // status: response[index]['status'], //5
                        business: response[index]['business'],
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }
}
