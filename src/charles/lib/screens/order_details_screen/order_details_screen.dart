import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? productName;
  final String? price;
  final String? weight;
  final String? category;
  final String? orderStatus;
  final String? orderType;
  final String? description;
  final String? location;
  final String? imageUrl;

  const OrderDetailsScreen(
      {Key? key,
      this.productName,
      this.price,
      this.weight,
      this.category,
      this.orderStatus,
      this.orderType,
      this.imageUrl,
      this.description,
      this.location})
      : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                child: Card(
                  elevation: 20,
                  child: Container(
                    height: size.height * 0.38,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.imageUrl!),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  widget.productName!,
                  style: GoogleFonts.montserrat(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                child: Text(
                  "Rs. " + widget.price! + " /-  for " + widget.weight! + ' kg',
                  style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 25, 15, 0),
                child: Text(
                  widget.description!,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  qAndAns(color, "Category ", widget.category!, context),
                  qAndAns(color, "Order Type ", widget.orderType!, context),
                  qAndAns(color, "Status of Order ", widget.orderStatus.toString(), context),
                  qAndAns(color, "Location ", widget.location!, context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget qAndAns(Color? color, String? question, String? ans, BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width * 0.45,
            child: Text(
              question!,
              style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width * 0.45,
            child: Text(
              ans!,
              style: GoogleFonts.montserrat(fontSize: 18, color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
