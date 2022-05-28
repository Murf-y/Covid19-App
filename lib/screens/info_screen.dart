import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/footer.dart';
import 'package:covid_19/widgets/header.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Header(
                image: "assets/icons/coronadr.svg",
                textTop: "Get to know",
                textBottom: "About Covid-19"),
            Symptoms(),
            Prevention(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class Prevention extends StatelessWidget {
  const Prevention({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 10),
          Text(
            "Prevention",
            style: kTitleTextstyle,
          ),
          SizedBox(height: 10),
          PreventionCard(
            image: "assets/images/wear_mask.png",
            title: "Wear face mask",
            subTitle:
                "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
          ),
          SizedBox(
            height: 20,
          ),
          PreventionCard(
            image: "assets/images/wash_hands.png",
            title: "Wash your hands",
            subTitle:
                "Regularly clean your hands with an alcohol-based hand rub or wash them with soap and water.",
          ),
        ],
      ),
    );
  }
}

class Symptoms extends StatelessWidget {
  const Symptoms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Symptoms",
            style: kTitleTextstyle,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SymptomCard(
                image: "assets/images/headache.png",
                title: "Headache",
                isActive: true,
              ),
              SymptomCard(
                image: "assets/images/fever.png",
                title: "Fever",
              ),
              SymptomCard(
                image: "assets/images/caugh.png",
                title: "Caugh",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PreventionCard extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const PreventionCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 136,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 10,
                  color: kActiveShadowColor,
                ),
              ],
            ),
          ),
          Image.asset(
            image,
            fit: BoxFit.contain,
          ),
          Positioned(
            bottom: 15,
            left: 150,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              height: 140,
              width: MediaQuery.of(context).size.width - 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: kTitleTextstyle.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        "assets/icons/forward.svg",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key? key,
    required this.image,
    this.isActive = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 90,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: kSubTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
