import 'package:calculator/data/data.dart';
import 'package:calculator/pages/home_page.dart';
import 'package:calculator/utils/my_button.dart';
import 'package:calculator/utils/top_buttons.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  // variables
  List listOfCountries = [];
  String countryCode1 = 'NPR';
  String countryCode2 = 'INR';
  bool isCalculatorSelected = false;
  String userInputAmount = '0';
  String requiredOutput = '0';
  var userInputValue = 0.0;
  var userOutputValue = 0.0;

  double val1 = 1.0;
  double val2 = 1.0;

  // this will execute at very first
  @override
  void initState() {
    super.initState();
    getData();
  }

  // fetching data from internet
  void getData() {
    Map myMap = resData;

    // getting keys from data
    myMap.forEach((key, value) {
      listOfCountries.add(key);
    });

    // removing duplicate data
    listOfCountries = listOfCountries.toSet().toList();
    // print(listOfCountries);
  }

  // on pressed function
  void onPressed(String sign) {
    setState(() {
      if (sign == 'C') {
        userInputAmount = "0";
        requiredOutput = "0";
        userInputValue = 0.0;
        userOutputValue = 0.0;
      } else if (sign == 'DEL') {
        if (userInputAmount.isNotEmpty) {
          userInputAmount =
              userInputAmount.substring(0, userInputAmount.length - 1);
        }
      } else {
        userInputAmount += sign;
        userInputValue = double.parse(userInputAmount);
      }
    });
  }

  // calculating function
  void calculation(double firstValue, double secondValue, double givenValue) {
    setState(() {
      userOutputValue = (secondValue / firstValue * givenValue);
      requiredOutput = userOutputValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // switcher
          Container(
            height: 90,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 30),
              child: Row(children: [
                TopButton(
                  text: 'Calculator',
                  isSelected: isCalculatorSelected,
                  onClick: () {
                    setState(() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const HomePage(),
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(
                  width: 20.0,
                ),
                TopButton(
                  text: 'Converter',
                  isSelected: !isCalculatorSelected,
                  onClick: () {
                    setState(() {
                      isCalculatorSelected = false;
                    });
                  },
                ),
              ]),
            ),
          ),

          // display screen
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    const BoxShadow(
                        offset: Offset(-3, -3),
                        blurRadius: 2.0,
                        spreadRadius: 1,
                        inset: true,
                        color: Colors.white),
                    BoxShadow(
                        offset: const Offset(3, 3),
                        blurRadius: 10.0,
                        spreadRadius: 2,
                        inset: true,
                        color: Colors.grey.shade400),
                  ]),

              // calculation data of the string
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // we have current of this country
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30.0, top: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                      radius: 45,
                                      backgroundImage:
                                          AssetImage("assets/download.jpg")),

                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Currency As ",
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  // creating dropdown of keys from received data
                                  DropdownButton<String>(
                                    items: listOfCountries
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.toString(),
                                            child: Text(
                                              "$e",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: ((value2) {
                                      setState(() {
                                        countryCode1 = value2!;
                                        val1 = resData[countryCode1]! / 1.0;
                                        val2 = resData[countryCode2]! / 1.0;

                                        calculation(val1, val2, userInputValue);
                                      });
                                    }),
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                                    value: countryCode1,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                userInputAmount,
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18),
                              ),
                            ],
                          )),

                      // we need to convert to this country
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30.0, top: 35, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 45,
                                    backgroundImage:
                                        AssetImage("assets/download.jpg"),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Currency As ",
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  // creating dropdown of keys from received data
                                  DropdownButton<String>(
                                    items: listOfCountries
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.toString(),
                                            child: Text(
                                              "$e",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: ((value1) {
                                      setState(() {
                                        countryCode2 = value1!;
                                        val1 = resData[countryCode1]! / 1.0;
                                        val2 = resData[countryCode2]! / 1.0;

                                        calculation(val1, val2, userInputValue);
                                      });
                                    }),
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                                    value: countryCode2,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                requiredOutput,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18),
                              ),
                            ],
                          ))
                    ],
                  )),
            ),
          ),

          // number pad
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemCount: boxContent.length,
                    itemBuilder: (BuildContext context, int index) {
                      return !emptyBox.contains(index)
                          ? MyButton(
                              sign: boxContent[index],
                              onPressed: (() {
                                onPressed(boxContent[index]);
                                val1 = resData[countryCode1]! / 1.0;
                                val2 = resData[countryCode2]! / 1.0;
                                calculation(val1, val2, userInputValue);
                              }))
                          : const SizedBox();
                    }),
              )),
        ],
      ),
    );
  }
}
