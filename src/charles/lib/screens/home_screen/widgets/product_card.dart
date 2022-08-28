import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    height: MediaQuery.of(context).size.height * 0.4 * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).secondaryHeaderColor,
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
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          price.toString(),
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          weight.toString(),
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' KG',
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          category,
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Chip(
                        label: Text(
                          toWhom,
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
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
