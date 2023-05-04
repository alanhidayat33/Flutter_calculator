import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalkulator/Component/button.dart';
import 'package:kalkulator/Controller/CalController.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var calculatorcontroller = Get.put(CalController());
    return Scaffold(//AppBar
      backgroundColor: Color(0xff22252D),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20,top: 50),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: GetBuilder<CalController>(
                              builder: (controller) => Text(
                                controller.userInput.value,
                                style: TextStyle(fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: GetBuilder<CalController>(
                              builder: (controller) => Text(
                                controller.answer.value,
                                style: TextStyle(fontSize: 50, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(3),
                    //   alignment: Alignment.centerRight,
                    //   child: GetBuilder<CalController>(
                    //     builder: (controller) => Text(
                    //       controller.userInput,
                    //       style: TextStyle(fontSize: 18, color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   child: GetBuilder<CalController>(
                    //     builder: (controller) => Text(
                    //       controller.answer,
                    //       style: TextStyle(
                    //           fontSize: 30,
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // )
                  ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: calculatorcontroller.buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          calculatorcontroller.delete();
                        },
                        buttonText: calculatorcontroller.buttons[index],
                        color: Color.fromRGBO(57, 58, 72, 1),
                        textColor: Colors.red,
                      );
                    }
                    else if (index == 1) {
                      return MyButton(
                        buttontapped: () {
                          calculatorcontroller.input(index);
                        },
                        buttonText: calculatorcontroller.buttons[index],
                        color: Color.fromRGBO(57, 58, 72, 1),
                        textColor: Colors.white,
                      );
                    }
                    //Persen
                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          calculatorcontroller.input(index);
                        },
                        buttonText: calculatorcontroller.buttons[index],
                        color: Color.fromRGBO(57, 58, 72, 1),
                        textColor: Colors.white,
                      );
                    }
                    // Delete Button
                    // else if (index == 3) {
                    //   return MyButton(
                    //     buttontapped: () {
                    //       calculatorcontroller.delete();
                    //     },
                    //     buttonText: calculatorcontroller.buttons[index],
                    //     color: Color.fromRGBO(57, 58, 72, 1),
                    //     textColor: Colors.red,
                    //   );
                    // }
                    // Tombol sama dengan
                    else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          calculatorcontroller.equal();
                        },
                        buttonText: calculatorcontroller.buttons[index],
                        color: Color.fromRGBO(150, 127, 235, 1),
                        textColor: Colors.white,
                      );
                    }
                    // Button Lainnya
                    else {
                      return MyButton(
                        buttontapped: () {
                          calculatorcontroller.input(index);
                        },
                        buttonText: calculatorcontroller.buttons[index],
                        textColor: Colors.white,
                        color: isOperator(calculatorcontroller.buttons[index])
                            ? Color.fromRGBO(67, 30, 199, 1)
                            : Color.fromRGBO(23, 28, 34, 1),
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }
}
bool isOperator(String x) {
  if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=' || x == '%') {
    return true;
  }
  return false;
}
