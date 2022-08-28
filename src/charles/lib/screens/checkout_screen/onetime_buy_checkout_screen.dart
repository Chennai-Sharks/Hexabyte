import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/product_details_screen/api/purchase_product_api.dart';
import 'package:hexabyte/screens/product_details_screen/widgets/payment_success_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:recase/recase.dart';

import '../../common/custom_divider.dart';
import '../profile_screen/profile_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final String? totalPrice, sellerId, productName, weight, imageUrl, productId;

  const CheckoutScreen(
      {super.key, this.productId, this.totalPrice, this.sellerId, this.productName, this.weight, this.imageUrl});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double? taxes;
  double? shippingCharges;
  double? totalAmount;
  @override
  void initState() {
    super.initState();
    taxes = double.parse(widget.totalPrice!) / 10;
    shippingCharges = double.parse(widget.totalPrice!) / 10;
    totalAmount = taxes! + int.parse(widget.totalPrice!) + shippingCharges!;
    initaliseRazorPay();
  }

  Razorpay? _razorpay;

  void _handlePayment(PaymentSuccessResponse res) async {
    final navContext = Navigator.of(context);
    EasyLoading.show(status: 'Waiting for confirmation');

    await PurchaseProductApi.purchaseApi(data: {
      "customer_id": FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3),
      "producer_id": widget.sellerId,
      "item_id": {"\$oid": widget.productId},
      "duration": 1,
      "subscribed_qty": int.parse(widget.weight!),
      "cost": double.parse(widget.totalPrice!),
      "ship_charge": shippingCharges,
      "tax": taxes,
      "one_time": true
    });
    EasyLoading.dismiss();

    navContext.pushReplacement(MaterialPageRoute(builder: (context) => PaymentSuccessPage()));
  }

  void initaliseRazorPay() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePayment);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymentError);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handleExternalWallet);
  }

  void _handlepaymentError(PaymentFailureResponse res) {}
  void _handleExternalWallet(ExternalWalletResponse res) {}
  void launchRazorPay(double? totalAmount) {
    var options = {
      "key": "rzp_live_eULnQWUHUQXgbx",
      "amount": ((totalAmount!) * 100).toString(),
      "name": "Kishore M",
      "description": "Purchase of ${widget.productName}"
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      // ignore: avoid_print
      Fluttertoast.showToast(msg: 'Error in payment.');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9EFC0),
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Checkout',
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Image.asset(
            "assets/logo.png",
            height: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                    height: size.height * 0.25,
                    width: size.width * 0.8,
                    color: Colors.white,
                    child: SvgPicture.asset(
                      'assets/credit_card.svg',
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: size.width * 0.12,
                    height: size.width * 0.12,
                    color: Colors.white,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    widget.productName!,
                    style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    width: size.width * 0.16,
                    child: Text(
                      "Rs. " + widget.totalPrice! + " /-",
                      style: GoogleFonts.montserrat(fontSize: 19, color: Colors.green.shade600),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomDividerView(
                dividerHeight: 1.0,
                color: Color(0xFFE9EFC0),
              ),
            ),
            InputOutputRow("Value of Product", "Rs. ${widget.totalPrice!} /-"),
            InputOutputRow("Shipping Charges", "Rs. $shippingCharges /-"),
            InputOutputRow("Taxes", "Rs. $taxes/-"),
            const SizedBox(
              height: 40,
            ),
            TotalInputOutputRow("Total Amount", "Rs. $totalAmount /-"),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomDividerView(
                dividerHeight: 1.0,
                color: Color(0xFFE9EFC0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SizedBox(
                  width: size.width * .40,
                  height: size.height * .08,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFB4E197),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: Center(
                      child: Text(
                        "Proceed To Payment",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(color: Colors.black),
                      ),
                    ),
                    onPressed: () async {
                      launchRazorPay(1);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget InputOutputRow(String? inputText, String? outputText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  inputText!,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 6.0, top: 3),
              //   child: Center(
              //     child: Text(
              //       percentage!,
              //       style: GoogleFonts.montserrat(
              //         color: Colors.black,
              //         fontSize: 13,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              outputText!,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TotalInputOutputRow(String? inputText, String? outputText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              inputText!,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              outputText!,
              style: GoogleFonts.montserrat(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
