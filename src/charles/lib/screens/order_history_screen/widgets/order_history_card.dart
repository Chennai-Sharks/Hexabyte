import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexabyte/common/custom_divider.dart';
import 'package:hexabyte/common/dotted_seperator.dart';

class OrderHistoryCard extends StatelessWidget {
  final dynamic id;
  final dynamic name;
  final dynamic price;
  final dynamic subscriptedQty;
  final dynamic duration;
  final bool isOneTime;
  final dynamic status;
  const OrderHistoryCard({
    Key? key,
    required this.duration,
    required this.name,
    required this.id,
    required this.isOneTime,
    required this.price,
    required this.subscriptedQty,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
                      name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // Text(
                    //   'Medavakkam',
                    //   style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.0),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Rs $price/-'),
                        const SizedBox(
                          height: 8,
                        ),
                        // Icon(Icons.keyboard_arrow_right, color: Colors.grey[600])
                      ],
                    ),
                    Text('Status: $status'),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                const Spacer(),
                // Text('Delivered', style: Theme.of(context).textTheme.subtitle2),
                // const SizedBox(
                //   height: 12,
                // ),
                // ClipOval(
                //   child: Container(
                //     padding: const EdgeInsets.all(2.2),
                //     color: Colors.green,
                //     child: const Icon(Icons.check, color: Colors.white, size: 14.0),
                //   ),
                // )
                Chip(label: isOneTime ? const Text('One-time') : const Text('Contract'))
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
              Text('Subscribed Quantity: $subscriptedQty Kg'),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Rating:',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return const Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return const Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return Container();
                    }
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                    Fluttertoast.showToast(msg: 'Rating recorded');
                  },
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const CustomDividerView(dividerHeight: 1.5, color: Colors.black)
            ],
          )
        ],
      ),
    );
  }
}
