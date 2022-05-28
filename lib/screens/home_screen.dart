import 'dart:convert';
import 'dart:math';
import 'package:covid_19/api.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/footer.dart';
import 'package:covid_19/widgets/header.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future getAllTimeInfoByCountry(String country) async {
  final response = await requestAllTimeInfoByCountry(country);
  if (response.statusCode == 200) {
    return jsonDecode(await response.stream.bytesToString());
  } else {
    return;
  }
}

Future getWorldInfo() async {
  final response = await requestWorldInfo();
  if (response.statusCode == 200) {
    return jsonDecode(await response.stream.bytesToString());
  } else {
    return;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var dropDownValue = kCountries[Random().nextInt(kCountries.length)];
  var deathAllTime;
  var activeAllTime;
  var infectedAllTime;
  var lastUpdateAllTime;

  var deathToday;
  var activeToday;
  var infectedToday;
  var lastUpdateToday;

  var worldInfected;
  var worldDeath;

  void updateData() {
    getAllTimeInfoByCountry(dropDownValue).then((result) {
      setState(() {
        // last element of result is the last update
        deathAllTime = result[result.length - 1]["Deaths"];
        activeAllTime = result[result.length - 1]["Active"];
        infectedAllTime = result[result.length - 1]["Confirmed"];
        lastUpdateAllTime =
            result[result.length - 1]["Date"].toString().split('T');
        lastUpdateAllTime = lastUpdateAllTime[0];

        // set today cases
        deathToday = result[result.length - 1]["Deaths"] -
            result[result.length - 2]["Deaths"];
        activeToday = result[result.length - 1]["Active"] -
            result[result.length - 2]["Active"];
        infectedToday = result[result.length - 1]["Confirmed"] -
            result[result.length - 2]["Confirmed"];
      });
    });
    getWorldInfo().then((result) {
      setState(() {
        worldInfected = result["TotalConfirmed"];
        worldDeath = result["TotalDeaths"];
      });
    });
  }

  var randomQuote;
  @override
  initState() {
    super.initState();
    randomQuote = getRandomQuote();
    updateData();
  }

  setDropDownValue(value) {
    dropDownValue = value;
    setState(() {
      dropDownValue = value;
    });
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              image: 'assets/icons/Drcorona.svg',
              textTop: randomQuote == null ? "" : randomQuote.keys.elementAt(0),
              textBottom:
                  randomQuote == null ? "" : randomQuote.values.elementAt(0),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  SvgPicture.asset('assets/icons/maps-and-flags.svg'),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                      value: dropDownValue,
                      items: kCountries.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) => {setDropDownValue(value)},
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'All time Cases\n\n',
                                style: kTitleTextstyle),
                            lastUpdateAllTime == null
                                ? const TextSpan(text: "")
                                : TextSpan(
                                    text: lastUpdateAllTime,
                                    style: const TextStyle(
                                        color: kTextLightColor)),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          number: infectedAllTime ?? 0,
                          title: "Infected",
                          color: kInfectedColor,
                        ),
                        Counter(
                          number: deathAllTime ?? 0,
                          title: "Dead",
                          color: kDeathColor,
                        ),
                        Counter(
                          number: activeAllTime ?? 0,
                          title: "Active",
                          color: kRecovercolor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'Today Cases Update\n\n',
                                style: kTitleTextstyle),
                            lastUpdateAllTime == null
                                ? const TextSpan(text: "")
                                : TextSpan(
                                    text: lastUpdateAllTime,
                                    style: const TextStyle(
                                        color: kTextLightColor)),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          number: infectedToday ?? 0,
                          title: "Infected",
                          color: kInfectedColor,
                        ),
                        Counter(
                          number: deathToday ?? 0,
                          title: "Dead",
                          color: kDeathColor,
                        ),
                        Counter(
                          number: activeToday ?? 0,
                          title: "Active",
                          color: kRecovercolor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'WorldWide Cases\n\n',
                                style: kTitleTextstyle),
                            lastUpdateAllTime == null
                                ? const TextSpan(text: "")
                                : TextSpan(
                                    text: lastUpdateAllTime,
                                    style: const TextStyle(
                                        color: kTextLightColor)),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Counter(
                          number: worldInfected ?? 0,
                          title: "Infected",
                          color: kInfectedColor,
                        ),
                        Counter(
                          number: worldDeath ?? 0,
                          title: "Dead",
                          color: kDeathColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}
