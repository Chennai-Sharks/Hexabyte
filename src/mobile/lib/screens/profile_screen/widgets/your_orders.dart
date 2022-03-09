import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/models/order_data.dart';
import 'package:hexabyte/screens/profile_screen/widgets/order_card.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  _YourOrdersState createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  @override
  Widget build(BuildContext context) {
    return orderData.isNotEmpty
        ? ListView.builder(
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
          )
        : Center(
            child: Text(
              'No orders till now !!!',
              style: GoogleFonts.exo(),
            ),
          );
  }
}
