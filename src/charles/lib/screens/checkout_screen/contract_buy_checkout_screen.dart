import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../common/custom_divider.dart';
import '../profile_screen/profile_screen.dart';

class ContractBuyCheckoutScreen extends StatefulWidget {
  final String? totalPrice, sellerId, productName, weight, imageUrl;

  const ContractBuyCheckoutScreen(
      {super.key,
      this.totalPrice,
      this.sellerId,
      this.productName,
      this.weight,
      this.imageUrl});

  @override
  State<ContractBuyCheckoutScreen> createState() =>
      _ContractBuyCheckoutScreenState();
}

class _ContractBuyCheckoutScreenState extends State<ContractBuyCheckoutScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? days;
  @override
  void initState() {
    days = 1;
    super.initState();
    initaliseRazorPay();
  }

  Razorpay? _razorpay;

  void _handlePayment(PaymentSuccessResponse res) {}

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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double? taxes = days! * 30 * double.parse(widget.totalPrice!) * 15 / 100;
    double? shippingCharges =
        days! * 30 * double.parse(widget.totalPrice!) / 10;
    double? totalAmount =
        taxes + (int.parse(widget.totalPrice!) * 30 * days!) + shippingCharges;

    Size? size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9EFC0),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
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
            FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: const Offset(2.0, 2.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11.0),
                        child: Center(
                          child: FormBuilderTextField(
                            name: 'duration',
                            initialValue: '1',
                            maxLength: 10,
                            onChanged: (value) {
                              setState(() {
                                days = int.parse(value!);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter number of months:',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              counterText: '',
                              border: InputBorder.none,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                    child: Image.asset(widget.imageUrl! == null
                        ? 'assets/logo.png'
                        : widget.imageUrl!),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.45,
                  child: Text(
                    widget.productName!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.33,
                  child: Text(
                    "Rs. ${int.parse(widget.totalPrice!) * 30 * days!} /-",
                    style: GoogleFonts.montserrat(
                        fontSize: 19, color: Colors.green.shade600),
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
            InputOutputRow("Value of Product",
                "Rs. ${int.parse(widget.totalPrice!) * 30 * days!} /-", ""),
            InputOutputRow("Taxes", "Rs. $taxes /-", " - 15 %"),
            InputOutputRow(
                "Shipping Charges", "Rs. $shippingCharges /-", " - 10%"),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Center(
                      child: Text(
                        "Proceed To Payment",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
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

  Widget InputOutputRow(
      String? inputText, String? outputText, String? percentage) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              inputText!,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              percentage!,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
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
