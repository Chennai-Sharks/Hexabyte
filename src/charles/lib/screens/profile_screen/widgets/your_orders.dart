import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/providers/order/order_history_provider.dart';
import 'package:hexabyte/screens/loading_screen/loading_screen.dart';
import 'package:hexabyte/screens/profile_screen/widgets/order_card.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  final OrderHistoryProvider _orderHistoryProvider = OrderHistoryProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _orderHistoryProvider.orderHistory(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final orderData = snapshot.data as List;
          return orderData.isNotEmpty
              ? Container(
                  color: Theme.of(context).secondaryHeaderColor,
                  height: MediaQuery.of(context).size.height * 1.2,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderData.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        productName: orderData[index]['productName'],
                        price: orderData[index]['price'],
                        category: orderData[index]['category'],
                        orderStatus: orderData[index]['orderStatus'],
                        buyingType: orderData[index]['buyingType'],
                        location: orderData[index]['location'],
                        weight: orderData[index]['weight'],
                        description: orderData[index]['description'],
                        imageUrl: orderData[index]['imageUrl'],
                      );
                    },
                  ),
                )
              : Center(
                  child: Text(
                    'No orders till now !!!',
                    style: GoogleFonts.exo(),
                  ),
                );
        }
        return const LoadingScreen();
      }),
    );
  }
}
