import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/consumer_active_orders_screen/api/consumer_active_order_api.dart';
import 'package:hexabyte/screens/consumer_active_orders_screen/widgets/consumer_active_order_card.dart';
import 'package:hexabyte/screens/producer_order_history_screen/api/producer_order_history_api.dart';
import 'package:hexabyte/screens/producer_order_history_screen/widgets/producer_order_history_card.dart';

class ConsumerActiveOrdersScreen extends StatefulWidget {
  const ConsumerActiveOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ConsumerActiveOrdersScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ConsumerActiveOrdersScreen> {
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
              'My Active Orders',
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
          future: ConsumerActiveOrdersApi.getOrders(),
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
                      itemBuilder: (BuildContext context, index) => ConsumerActiveOrderCard(
                        foodWasteTitle: response[index]['food_waste_title'],
                        subscribedQty: response[index]['subscribed_qty'], //
                        // status: 'active', //5
                        id: response[index]['item_id']['\$oid'],
                        business: response[index]['business'], // 3
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
