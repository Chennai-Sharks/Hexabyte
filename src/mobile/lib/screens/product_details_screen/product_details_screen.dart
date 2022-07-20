import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/product_details_screen/widgets/payment_success_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

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
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? _month = 30;
  int? _stepperValue = 1;
  int? _contractBuyCost;
  int? _oneTimeBuyCost;

  @override
  void initState() {
    super.initState();
    initaliseRazorPay();
    _oneTimeBuyCost = int.parse(widget.price!);
    _contractBuyCost = int.parse(widget.price!) * _month!;
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
      "amount": (int.parse(widget.price!) * 100 * _stepperValue!).toString(),
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

  void launchRazorPayForMonths(int? val, int? _stepperValue) {
    var options = {
      "key": "rzp_test_ZdIhaAYTQ8urAz",
      "amount": (int.parse(widget.price!) * 100 * val! * _stepperValue!).toString(),
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
    Size? size = MediaQuery.of(context).size;
    Color? color = Colors.redAccent.shade700;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                child: Card(
                  elevation: 20,
                  child: Container(
                    height: size.height * 0.38,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Text(
                        widget.productName!,
                        style: GoogleFonts.exo(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                          child: Text(
                            "Rs. " + widget.price! + " /-  per kg ",
                            style: GoogleFonts.exo(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VxStepper(
                                defaultValue: 1,
                                max: int.parse(widget.weight!),
                                min: 1,
                                onChange: (value) {
                                  setState(() {
                                    _stepperValue = value;
                                    _oneTimeBuyCost = _stepperValue! * int.parse(widget.price!);
                                    _contractBuyCost = _oneTimeBuyCost! * _month!;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'KGs',
                                style: GoogleFonts.exo(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 25, 15, 0),
                      child: Text(
                        widget.description!,
                        style: GoogleFonts.exo(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.025),
                    qAndAns(color, "One Time Buy Price ", "Rs. " + _oneTimeBuyCost.toString() + " /-", context),
                    qAndAns(color, "Contract Buy Price ", "Rs. " + _contractBuyCost.toString() + " /-", context),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        qAndAns(color, "Category ", widget.category!, context),
                        qAndAns(color, "Order Type ", widget.orderType!, context),
                        qAndAns(color, "Status of Order ", widget.orderStatus.toString(), context),
                        qAndAns(color, "Location ", widget.location!, context),
                        SizedBox(height: size.height * 0.05),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              launchRazorPay();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSuccessPage()));
                            },
                            child: Container(
                              width: size.width * 0.4,
                              height: 50,
                              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'One Time Buy',
                                  style: GoogleFonts.exo(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(
                              'Or',
                              style: GoogleFonts.exo(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        FormBuilder(
                          key: _formKey,
                          initialValue: const {
                            "month": "1 month",
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 11.0),
                                      child: Center(
                                        child: FormBuilderDropdown(
                                          name: 'month',
                                          decoration: const InputDecoration(
                                            labelText: 'Choose Contract',
                                            labelStyle: TextStyle(color: Colors.black),
                                            border: InputBorder.none,
                                          ),
                                          // initialValue: 'Male',
                                          allowClear: true,
                                          onChanged: (value) {
                                            if (value == '1 month') {
                                              setState(() {
                                                _month = 30;
                                                _contractBuyCost = _oneTimeBuyCost! * _month!;
                                              });
                                            } else if (value == '3 months') {
                                              setState(() {
                                                _month = 90;
                                                _contractBuyCost = _oneTimeBuyCost! * _month!;
                                              });
                                            } else if (value == '6 months') {
                                              setState(() {
                                                _month = 180;
                                                _contractBuyCost = _oneTimeBuyCost! * _month!;
                                              });
                                            } else if (value == '12 months') {
                                              setState(() {
                                                _month = 360;
                                                _contractBuyCost = _oneTimeBuyCost! * _month!;
                                              });
                                            } else {
                                              setState(() {
                                                _month = 720;
                                                _contractBuyCost = _oneTimeBuyCost! * _month!;
                                              });
                                            }
                                          },
                                          validator:
                                              FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                                          items: monthOptions
                                              .map((gender) => DropdownMenuItem(
                                                    value: gender,
                                                    child: Text(gender),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: MaterialButton(
                              height: size.height * 0.05,
                              minWidth: size.width * 0.4,
                              color: color,
                              child: Text(
                                "Contract Buy",
                                style: GoogleFonts.exo(color: Colors.white),
                              ),
                              onPressed: () {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  print(_formKey.currentState!.value);
                                  launchRazorPayForMonths(_month, _stepperValue);
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => PaymentSuccessPage()));
                                } else {
                                  print("validation failed");
                                }
                              },
                            ),
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

  var monthOptions = ['1 month', '3 months', '6 months', '12 months', '24 months'];

  Widget qAndAns(Color? color, String? question, String? ans, BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width * 0.43,
            child: Text(
              question!,
              style: GoogleFonts.exo(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width * 0.43,
            child: Text(
              ans!,
              style: GoogleFonts.exo(fontSize: 18, color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
