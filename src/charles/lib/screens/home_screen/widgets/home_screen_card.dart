import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenCard extends StatefulWidget {
  final String? sloganText, descriptionText, buttonText, imageUrl;
  final IconData? icon;
  final Color? color;
  final Widget? navigatorWidget;

  const HomeScreenCard(
      {super.key,
      this.imageUrl,
      this.sloganText,
      this.descriptionText,
      this.buttonText,
      this.icon,
      this.color,
      this.navigatorWidget});

  @override
  State<HomeScreenCard> createState() => _HomeScreenCardState();
}

class _HomeScreenCardState extends State<HomeScreenCard> {
  @override
  Widget build(BuildContext context) {
    Size? size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
      child: Center(
        child: Container(
          width: size.width * 0.92,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 2, spreadRadius: 0.5)]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.imageUrl!),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 20, 12, 6),
                child: Text(
                  widget.sloganText!,
                  style: GoogleFonts.montserrat(
                    color: widget.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 0, 25),
                child: Text(
                  widget.descriptionText!,
                  style: GoogleFonts.nunito(
                    color: widget.color,
                    fontSize: 22,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 14, 14, 26),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => widget.navigatorWidget!));
                    },
                    child: Container(
                      height: size.height * 0.075,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: widget.color!,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.buttonText!,
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                color: widget.color!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                widget.icon!,
                                size: 32,
                                color: widget.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
