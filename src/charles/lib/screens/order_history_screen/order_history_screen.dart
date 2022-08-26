import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/screens/order_history_screen/api/order_history_api.dart';
import 'package:hexabyte/screens/order_history_screen/widgets/order_history_card.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "My orders",
          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const NavigationLayout(
                      isConsumer: true,
                    )));
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: OrderHistoryApi.getMyOrders(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data);
                      final response = snapshot.data as List<dynamic>?;
                      if (response == null) {
                        return const Center(child: Text('No orders found'));
                      }
                      if (response.isEmpty) {
                        return const Center(child: Text('No orders found'));
                      }

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: response.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => OrderHistoryCard(
                              id: response[index]['item_id']['\$oid'],
                              name: response[index]['food_waste_title'] ?? 'Vegetable peels',
                              price: response[index]['cost_per_kg'] * response[index]['subscribed_qty'] ?? 200,
                              subscriptedQty: response[index]['subscribed_qty'] ?? 50,
                              duration: response[index]['duration'] ?? 1,
                              isOneTime: response[index]['one_time'] ?? true,
                            ),
                          ),
                        ),
                      );
                    }
                    return const Center(child: Text('Loading...'));
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



//  AfterSearchCard(
//                             id: response[index]['_id']['\$oid'],
//                             name: response[index]['food_waste_title'],
//                             price: response[index]['amount_processed'],
//                             availableQty: response[index]['balance_qty'],
//                             distance: '4.9 km',
//                             duration: response[index]['duration'],
//                             productData: response[index],
//                           ),