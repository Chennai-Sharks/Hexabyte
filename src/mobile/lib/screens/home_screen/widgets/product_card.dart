import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/utils/utils.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final int weight;
  final String category;
  final String toWhom; //biogas, animal feed, etc

  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.weight,
    required this.category,
    required this.toWhom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                color: Colors.red,
                child: Image.asset(
                  'assets/logo.png',
                  height: 160,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.exo(
                      color: Utils.primaryFontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                      top: 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Rs. ',
                          style: GoogleFonts.exo(
                            color: Utils.primaryFontColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          price.toString(),
                          style: GoogleFonts.exo(
                            color: Utils.primaryFontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          weight.toString(),
                          style: GoogleFonts.exo(
                            color: Utils.primaryFontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' KG',
                          style: GoogleFonts.exo(
                            color: Utils.primaryFontColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text(category),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Chip(
                        label: Text(toWhom),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
