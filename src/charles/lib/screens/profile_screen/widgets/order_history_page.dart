import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'order_history_card.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 15.0, top: 10),
                  width: size.width,
                  child: Text(
                    'Order History',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => const OrderHistoryCard(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
