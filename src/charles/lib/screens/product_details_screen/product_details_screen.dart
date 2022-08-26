import 'package:count_stepper/count_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/common/custom_divider.dart';
import 'package:hexabyte/screens/checkout_screen/contract_buy_checkout_screen.dart';
import 'package:hexabyte/screens/checkout_screen/onetime_buy_checkout_screen.dart';
import 'package:hexabyte/screens/search_screen/search_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:recase/recase.dart';

class ProductDetailsPage extends StatefulWidget {
  final String? productName;
  final String? price;
  final String? weight;
  final String? category;
  final String? orderStatus;
  final String? orderType;
  final String? description;
  final String? location;
  final String? imageUrl;
  final String? sellerId;

  final String? id;
  final Map? productData;

  const ProductDetailsPage({
    Key? key,
    this.productName,
    this.price,
    this.weight,
    this.category,
    this.orderStatus,
    this.orderType,
    this.imageUrl,
    this.description,
    this.location,
    this.sellerId,
    this.id,
    this.productData,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? _days = 1;
  int? _stepperValue = 1;
  int? _contractBuyCost;
  int? _oneTimeBuyCost;

  @override
  void initState() {
    super.initState();
    initaliseRazorPay();
    _oneTimeBuyCost = widget.productData!['cost'] ?? 200;
    _contractBuyCost = (widget.productData!['cost'] ?? 200) * _days!;
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
  void launchRazorPay() {
    var options = {
      "key": "rzp_test_ZdIhaAYTQ8urAz",
      "amount": (int.parse(widget.productData!['cost']!) * 100 * _stepperValue!).toString(),
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

  void launchRazorPayForMonths(int? val, int? stepperValue) {
    var options = {
      "key": "rzp_test_ZdIhaAYTQ8urAz",
      "amount": (int.parse(widget.productData!['cost']!) * 100 * val! * stepperValue!).toString(),
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
    print(widget.productData);
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFC0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9EFC0),
        title: Text(
          'Product Details',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        actions: <Widget>[
          // const Icon(Icons.favorite_border),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SearchPage()));
            },
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration:
            const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/curation_bg.gif'))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: size.width * 0.45,
                              child: Text(
                                widget.productData!['food_waste_title'] ?? 'N/A',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 24.0),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: size.width * 0.45,
                              child: Text(
                                'Seller phone no: ${widget.productData!['producer_id'] ?? 'N/A'}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                        Container(
                          height: size.width * 0.4,
                          width: size.width * 0.4,
                          child: Image.asset(widget.imageUrl ?? 'assets/logo.png', fit: BoxFit.cover),
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.productData!['applicable_tags'].length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(
                            label: Text(
                              widget.productData!['applicable_tags'][index].toString().sentenceCase,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    const CustomDividerView(dividerHeight: 1.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // _buildVerticalStack(context, '5.0', 'Points'),
                        // _buildVerticalStack(context, '29 Kms', 'Distance'),
                        _buildVerticalStack(context, '${widget.productData!['cost']}/-', 'per Kg'),
                      ],
                    ),
                    const CustomDividerView(
                      dividerHeight: 1.0,
                      color: Color(0xFFE9EFC0),
                    ),
                    // const SizedBox(height: 8),
                    // Column(
                    //   children: <Widget>[
                    //     _buildOfferTile(context, '30% off up to Rs75 | Use code SWIGGYIT'),
                    //     _buildOfferTile(
                    //         context, '20% off up to Rs100 with SBI credit cards, once per week | Use code 100SBI')
                    //   ],
                    // ),
                    // SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 25.0),
                      child: Text(
                        "Description: " + (widget.productData!['description'] ?? 'N/A'),
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Rs. ",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${widget.productData!['cost'] ?? '200'}  ",
                                style: GoogleFonts.montserrat(
                                    fontSize: 23, fontWeight: FontWeight.bold, color: Colors.green.shade700),
                              ),
                              Text(
                                "/-  per kg",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFB4E197),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: size.width * 0.22,
                                    child: CountStepper(
                                      splashRadius: 26,
                                      iconColor: Color(0xFFB4E197),
                                      iconIncrementColor: Color(0xFFB4E197),
                                      defaultValue: 1,
                                      max: widget.productData!['balance_qty'] ?? 1,
                                      min: 1,
                                      onPressed: (value) {
                                        setState(() {
                                          _stepperValue = value;
                                          int price = widget.productData!['cost'] ?? 200;
                                          _oneTimeBuyCost = _stepperValue! * price;
                                          _contractBuyCost = _oneTimeBuyCost! * _days!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Kgs',
                                    style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.025),
                    // qAndAns(color, "One Time Buy Price ", "Rs. $_oneTimeBuyCost /-", context),
                    // qAndAns(color, "Contract Buy Price ", "Rs. $_contractBuyCost /-", context),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // qAndAns(color, "Category ", widget.category!, context),
                        // qAndAns(color, "Order Type ", widget.orderType!, context),
                        // qAndAns(color, "Status of Order ", widget.orderStatus.toString(), context),
                        // qAndAns(color, "Location ", widget.location!, context),
                        SizedBox(height: size.height * 0.05),

                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                                      child: Text(
                                        "One-time Buy",
                                        style: GoogleFonts.montserrat(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        //  launchRazorPay();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CheckoutScreen(
                                                    productId: widget.productData!['_id']['\$oid'],
                                                    imageUrl: widget.imageUrl,
                                                    totalPrice: _oneTimeBuyCost.toString(),
                                                    sellerId: widget.productData!['food_waste_title'],
                                                    productName: widget.productData!['food_waste_title'],
                                                    weight: _stepperValue.toString())));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                  child: SizedBox(
                                    width: size.width * .4,
                                    height: size.height * .08,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFFB4E197),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                      child: Text(
                                        "Contract Buy",
                                        style: GoogleFonts.montserrat(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        print('here');
                                        print(widget.productData);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ContractBuyCheckoutScreen(
                                                    productId: widget.productData!['_id']['\$oid'],
                                                    imageUrl: widget.imageUrl,
                                                    totalPrice: _contractBuyCost.toString(),
                                                    sellerId: widget.productData!['food_waste_title'],
                                                    productName: widget.productData!['food_waste_title'],
                                                    weight: _stepperValue.toString())));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var monthOptions = ['30 month', '3 months', '6 months', '12 months', '24 months'];

  Widget qAndAns(Color? color, String? question, String? ans, BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width * 0.43,
            child: Text(
              question!,
              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width * 0.43,
            child: Text(
              ans!,
              style: GoogleFonts.montserrat(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Expanded _buildVerticalStack(BuildContext context, String title, String subtitle) => Expanded(
      child: SizedBox(
        height: 60.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(subtitle,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.0,
                      color: Colors.green.shade600,
                    ))
          ],
        ),
      ),
    );
