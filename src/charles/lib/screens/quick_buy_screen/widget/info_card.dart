import 'package:flutter/material.dart';
import 'package:hexabyte/screens/product_details_screen/product_details_screen.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailsPage(
              category: 'some category',
              description: 'Some descritption',
              imageUrl: 'assets/logo.png',
              location: 'Location',
              orderStatus: 'orderStatus',
              orderType: 'One time buy',
              price: '200',
              productName: 'Product name',
              sellerId: 'Seller id',
              weight: '100',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  )
                ],
              ),
              child: Image.asset(
                // restaurant.image,
                'assets/logo.png',
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    // restaurant.name,
                    'Name',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 20.0),
                  ),
                  Text(
                    // restaurant.desc,
                    'within 20kms',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[800], fontSize: 13.5),
                  ),
                  Text(
                    // restaurant.coupon,
                    'some info',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red[900], fontSize: 13.0),
                  ),
                  const Divider(),
                  FittedBox(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: 14.0,
                          color: Colors.grey[600],
                        ),
                        Text(
                          // restaurant.ratingTimePrice,
                          '5.0 - Rs.100/- per Kg',
                          style: const TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
