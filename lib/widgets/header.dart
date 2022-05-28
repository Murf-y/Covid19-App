import 'package:covid_19/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;
  const Header({
    Key? key,
    required this.image,
    required this.textTop,
    required this.textBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: const EdgeInsets.only(top: 50, right: 20),
        height: 350,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF3383CD),
                Color(0xFF11249F),
              ]),
          image: DecorationImage(
            image: AssetImage('assets/images/virus.png'),
          ),
        ),
        child: Column(
          children: [
            Navigator.of(context).canPop()
                ? Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: RotatedBox(
                            quarterTurns: -2,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () => {Navigator.of(context).pop()},
                                child: SvgPicture.asset(
                                  "assets/icons/forward.svg",
                                  color: Colors.white,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
                : Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => {
                        if (Navigator.of(context).canPop())
                          {Navigator.of(context).pop()}
                        else
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const InfoScreen()))
                          }
                      },
                      child: SvgPicture.asset('assets/icons/menu.svg'),
                    ),
                  ),
            const SizedBox(height: 40),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SvgPicture.asset(
                      image,
                      width: 250,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 190,
                    child: Text(
                      "$textTop\n$textBottom",
                      style: kHeadingTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
