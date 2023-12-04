import 'package:calculator/pages/converter_page.dart';
import 'package:calculator/utils/my_button.dart';
import 'package:calculator/utils/top_buttons.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// variables
String input = '';
String output = '';
String input1 = "";
int equalPressed = 0;
double firstNum = 0.0;
double secondNUm = 0.0;
bool isCalculatorSelected = true;

class _HomePageState extends State<HomePage> {
  List<String> numPad = [
    'C',
    '%',
    'DEL',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '='
  ];

  // on pressed function
  void onPressed(String sign) {
    setState(() {
      if (sign == '=') {
        equalPressed++;
        if (input.isNotEmpty) {
          input1 = input;
          input1 = input1.replaceAll("x", "*");
          input1 = input1.replaceAll("÷", "/");
          evaluate();
        }

        if (equalPressed % 2 == 0) {
          equalPressed = 0;
          input = output;
          output = "";
        }
      } else if (sign == 'C') {
        equalPressed = 0;
        input = "";
        output = "";
      } else if (sign == 'DEL') {
        equalPressed = 0;
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        equalPressed = 0;
        input += sign;
      }
    });
  }

  // evaluation input
  void evaluate() {
    try {
      Parser p = Parser();
      Expression expression = p.parse(input1);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if (output.endsWith('.0')) {
        output = output.substring(0, output.length - 2);
      }
    } catch (e) {
      output = "Invalid Format";
    }
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
                      isCalculatorSelected = true;
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ConverterPage(),
                        ),
                      );
                    });
                  },
                ),
              ]),
            ),
          ),

          // display screen
          Expanded(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 20.0),
                      child: Text(input,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                              fontSize: 35,
                              letterSpacing: 2.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                      child: Text(output,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 35,
                              letterSpacing: 2.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // number pad
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemCount: numPad.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyButton(
                        sign: numPad[index],
                        onPressed: () => onPressed(numPad[index]),
                      );
                    }),
              )),
        ],
      ),
    );
  }
}
