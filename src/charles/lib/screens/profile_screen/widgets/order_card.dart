import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatefulWidget {
  final String? productName;
  final String? price;
  final String? category;
  final String? orderStatus;
  final String? buyingType;
  final String? location;
  final String? weight;
  final String? description;
  final String? imageUrl;

  const OrderCard(
      {Key? key,
      this.productName,
      this.price,
      this.category,
      this.orderStatus,
      this.buyingType,
      this.location,
      this.weight,
      this.description,
      this.imageUrl})
      : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: size.height * 0.15,
          child: Card(
            color: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 20),
                  child: Container(
                    height: size.width * 0.24,
                    width: size.width * 0.24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.imageUrl!),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.productName!,
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        widget.category!,
                        style: GoogleFonts.notoSansAnatolianHieroglyphs(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.buyingType!,
                            style: GoogleFonts.notoSansAnatolianHieroglyphs(
                              fontSize: 12,
                              color: widget.buyingType! == "Contract" ? color : Colors.green.shade700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Rs. " + widget.price! + " /-",
                            style: GoogleFonts.notoSansAnatolianHieroglyphs(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
