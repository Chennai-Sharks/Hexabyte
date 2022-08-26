import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/product_details_screen/product_details_screen.dart';
import 'package:recase/recase.dart';

class AfterSearchCard extends StatelessWidget {
  final String? id;
  final String? name;
  final int? price;
  final int? availableQty;
  final String? distance;
  final int? duration;
  final Map? productData;
  const AfterSearchCard({
    Key? key,
    required this.id,
    required this.availableQty,
    required this.distance,
    required this.name,
    required this.price,
    required this.duration,
    required this.productData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              id: id,
              productData: productData,
            ),
          ));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 8,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // AutoSizeText(
                      //   'Seller id: ${productData!['producer_id']}',
                      //   style: GoogleFonts.montserrat(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 18,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 6,
                      // ),
                      AutoSizeText(
                        (name ?? 'N/A').titleCase,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            'Score: 5.0',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          // AutoSizeText(
                          //   '. ${duration ?? 'N/A'} days',
                          //   overflow: TextOverflow.ellipsis,
                          //   style: GoogleFonts.montserrat(
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.grey,
                          //     fontSize: 15,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      AutoSizeText(
                        '${price ?? '200'}/- Rs per kg',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      AutoSizeText(
                        'Available Qty: ${availableQty ?? 'N/A'}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
