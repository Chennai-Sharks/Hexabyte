import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/common/dotted_seperator.dart';
import 'package:hexabyte/utils/app_colors.dart';
import 'package:recase/recase.dart';

class ListedProductCard extends StatelessWidget {
  final dynamic title;
  final dynamic description;
  final dynamic business;
  final dynamic subscribedQty;
  final dynamic totalQty;
  final dynamic tags;
  final dynamic balanceQty;
  final dynamic cost;
  const ListedProductCard({
    Key? key,
    required this.balanceQty,
    required this.business,
    required this.description,
    required this.subscribedQty,
    required this.tags,
    required this.title,
    required this.totalQty,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 1,
              blurRadius: 0.5,
            )
          ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Tags: ${(tags as List<dynamic>).join(', ').sentenceCase}',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Cost per Kg: '),
                            Text(
                              'Rs. $cost/-',
                              style: GoogleFonts.montserrat(
                                  color: Colors.green.shade600, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // Icon(Icons.keyboard_arrow_right, color: Colors.grey[600])
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    // const Chip(label: Text('One-time'))
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const DottedSeperatorView(),
              const SizedBox(
                height: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    description,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Text(
                  //   'July 14, 2:11 AM',
                  //   style: GoogleFonts.montserrat(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  // Text(
                  //   'Rating: 5.0 ⭐',
                  //   style: GoogleFonts.montserrat(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: <Widget>[
                  //             OutlinedButton(
                  //               style: OutlinedButton.styleFrom(
                  //                 side: BorderSide(width: 1.5, color: darkOrange!),
                  //               ),
                  //               child: Text(
                  //                 'DISMISS',
                  //                 style: Theme.of(context).textTheme.subtitle2!.copyWith(color: darkOrange),
                  //               ),
                  //               onPressed: () {},
                  //             ),
                  //             // UIHelper.verticalSpaceMedium(),
                  //             const SizedBox(height: 12),
                  //           ],
                  //         ),
                  //       ),
                  //       const SizedBox(width: 12),
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: <Widget>[
                  //             OutlinedButton(
                  //               style: OutlinedButton.styleFrom(
                  //                 side: const BorderSide(
                  //                   width: 1.5,
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //               child: Text(
                  //                 'EDIT QTY',
                  //                 style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black),
                  //               ),
                  //               onPressed: () {},
                  //             ),
                  //             // UIHelper.verticalSpaceMedium(),
                  //             const SizedBox(height: 12),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
