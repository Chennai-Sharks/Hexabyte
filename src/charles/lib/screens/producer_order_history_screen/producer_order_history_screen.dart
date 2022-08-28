import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/producer_order_history_screen/api/producer_order_history_api.dart';
import 'package:hexabyte/screens/producer_order_history_screen/widgets/producer_order_history_card.dart';

class ProducerOrderHistoryScreen extends StatefulWidget {
  const ProducerOrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ProducerOrderHistoryScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ProducerOrderHistoryScreen> {
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
              'Producer order history',
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
          future: ProducerOrderHistoryApi.getOrders(),
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
                      itemBuilder: (BuildContext context, index) => ProducerOrderHistoryCard(
                        customerName: response[index]['customer_name'], // 6
                        customerPhoneNumber: response[index]['customer_phone'], //7
                        foodWasteTitle: response[index]['food_waste_title'],
                        subscribedQty: response[index]['subscribed_qty'], //
                        status: response[index]['status'], //5
                        tax: response[index]['tax'], //4
                        shipCharge: response[index]['ship_charge'], // 3
                        cost: response[index]['cost'], //
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }
}
