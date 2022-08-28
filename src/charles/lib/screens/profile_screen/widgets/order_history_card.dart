import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexabyte/common/custom_divider.dart';
import 'package:hexabyte/common/dotted_seperator.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({Key? key}) : super(key: key);

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
                      'Name of the prod',
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
                      children: const <Widget>[
                        Text('Rs 1120/-'),
                        SizedBox(
                          height: 8,
                        ),
                        // Icon(Icons.keyboard_arrow_right, color: Colors.grey[600])
                      ],
                    )
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
                const Chip(label: Text('One-time'))
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
              const Text('Something'),
              const SizedBox(
                height: 8,
              ),
              const Text('July 14, 2:11 AM'),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Rating:',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
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
