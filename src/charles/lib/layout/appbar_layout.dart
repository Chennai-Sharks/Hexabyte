import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatefulWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    Color? color = Colors.redAccent.shade400;
    return Container(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      color: color,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 5,
                  //     horizontal: 15,
                  //   ),
                  //   child: GestureDetector(
                  //     onTap: () {},
                  //     child: Image.asset(
                  //       'images/logo.png',
                  //       width: 100,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 20,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.location_pin,
                                    // size: 10,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 2),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.montserrat(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Deliver to ',
                                          style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Text(
                                //   '${}',
                                //   softWrap: true,
                                //
                                //
                                // ),
                              ),
                            ]),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    Color? color = Colors.redAccent.shade700;
    return Container(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      color: color,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     // Padding(
            //     //   padding: const EdgeInsets.symmetric(
            //     //     vertical: 5,
            //     //   ),
            //     //   child: TextFieldControllers(
            //     //     child: TextField(
            //     //       onChanged: (value) {
            //     //         setState(() {});
            //     //       },
            //     //       textCapitalization: TextCapitalization.words,
            //     //       style: GoogleFonts.montserrat(),
            //     //       decoration: InputDecoration(
            //     //         contentPadding: EdgeInsets.only(
            //     //           bottom: 14,
            //     //         ),
            //     //         hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade600),
            //     //         icon: Icon(
            //     //           Icons.search,
            //     //           size: 20,
            //     //           color: Theme.of(context).secondaryHeaderColor,
            //     //         ),
            //     //         hintText: "Search",
            //     //         border: InputBorder.none,
            //     //       ),
            //     //     ),
            //     //   ),
            //     // ),
            //     //   IconButton(
            //     //     onPressed: () {},
            //     //     icon: Icon(
            //     //       Icons.mic,
            //     //       color: Theme.of(context).primaryColor,
            //     //     ),
            //     //   ),
            //   ],
            // ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     height: 20,
            //     child: GestureDetector(
            //       onTap: () {},
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //             Padding(
            //               padding: const EdgeInsets.only(
            //                 left: 10,
            //               ),
            //               child: Center(
            //                 child: Icon(
            //                   Icons.location_pin,
            //                   // size: 10,
            //                   color: Theme.of(context).primaryColor,
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 10, top: 2),
            //               child: Center(
            //                 child: RichText(
            //                   text: TextSpan(
            //                     style: GoogleFonts.montserrat(
            //                       color: Theme.of(context).primaryColor,
            //                       fontSize: 14,
            //                     ),
            //                     children: <TextSpan>[
            //                       TextSpan(
            //                         text: 'Deliver to ',
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               // Text(
            //               //   '${}',
            //               //   softWrap: true,
            //               //
            //               //
            //               // ),
            //             ),
            //           ]),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 15.0),
            //             child: Center(
            //               child: GestureDetector(
            //                 onTap: () {},
            //                 child: Icon(
            //                   Icons.keyboard_arrow_down,
            //                   color: Theme.of(context).primaryColor,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class TextFieldControllers extends StatelessWidget {
  final Widget? child;

  const TextFieldControllers({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          width: size.width * 0.80,
          height: 35,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 1),
            ],
            border: Border.all(
              color: Colors.black.withAlpha(55),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
