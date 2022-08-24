import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollableCategories extends StatelessWidget {
  final List<String?> categories;
  final List<String?> categoriesImgList;

  const ScrollableCategories(
      {super.key, required this.categories, required this.categoriesImgList});

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      width: size.width,
      child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 4,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // if (index == 0) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const Braces()));
                      // }
                      // if (index == 1) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const FancyDress()));
                      // }
                      // if (index == 2) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const Shoes()));
                      // }
                      // if (index == 3) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const Jewelry()));
                      // }
                      // if (index == 4) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const Sunglasses()));
                      // }
                    },
                    child: Center(
                      child: Container(
                        height: 120,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(color: Colors.red, blurRadius: 0.1),
                          ],
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SvgPicture.asset(categoriesImg[index]!,
                                  width: 100, height: 50),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 5, right: 5),
                              child: Center(
                                child: Text(
                                  categories[index]!,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.mukta(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

List<String?> categories = [
  "Clothing",
  "Fancy Dresses",
  'Shoes',
];

List<String?> categoriesImg = [
  "assets/clothes.svg",
  "assets/fancy.svg",
  'assets/shoe.svg',
];

List<String?> secondCategories = ["Jewelry", 'Sunglasses'];

List<String?> secondCategoriesImg = [
  "assets/jewelry.svg",
  'assets/sunglass.svg'
];
