import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollableCategories extends StatelessWidget {
  final List<String?> categories;
  final List<String?> categoriesImgList;
  final List<Widget?> widget;

  const ScrollableCategories(
      {super.key,
      required this.categories,
      required this.categoriesImgList,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return SizedBox(
      height: 150,
      width: size.width,
      child: Center(
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => widget[index]!));
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
                            child: Image.asset(categoriesImgList[index]!,
                                fit: BoxFit.cover, width: 50, height: 50),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 5, right: 5),
                            child: Center(
                              child: Text(
                                categories[index]!,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.mukta(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
