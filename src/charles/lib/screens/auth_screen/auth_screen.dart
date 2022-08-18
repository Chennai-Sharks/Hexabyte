// import 'package:app/providers/auth_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/otp_screen/otp_screen.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            height: 90,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          Center(
            child: AutoSizeText(
              'Hexabyte',
              style: GoogleFonts.exo(
                fontSize: 50,
                color: Theme.of(context).secondaryHeaderColor.withAlpha(900),
                fontWeight: FontWeight.bold,
                wordSpacing: 3,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, right: 50),
            child: Center(
              child: AutoSizeText(
                'Application for using food waste as consumable organic resource',
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Theme.of(context).secondaryHeaderColor.withAlpha(900),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: FormBuilderTextField(
                name: 'phoneno',
                decoration: InputDecoration(
                  labelText: 'Enter phone number',
                  fillColor: const Color(0xFFF2F2F2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                keyboardType: TextInputType.number,
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(context),
                //   FormBuilderValidators.numeric(context),
                //   FormBuilderValidators.max(context, 10),
                // ]),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.width * 0.1
                : MediaQuery.of(context).size.width * 0,
          ),
          SizedBox(
            //alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.75,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Utils.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 3,
              ),
              onPressed: () async {
                final navContext = Navigator.of(context);
                _formKey.currentState?.save();
                final mobileno = _formKey.currentState?.value['phoneno'];
                if (mobileno == null) {
                  Fluttertoast.showToast(msg: 'Phone number is empty');
                } else if (mobileno.length == 10) {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  await pref.setString('phone', mobileno);
                  navContext.push(
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(phone: mobileno),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(msg: 'Invalid Phone number');
                }
              },
              child: const Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 15,
                  color: Utils.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
