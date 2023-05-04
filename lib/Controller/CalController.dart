import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/foundation.dart';

class CalController extends GetxController{
  final List<String> buttons = [
    'C', '(', ')', '%',

    '7', '8', '9', '/',

    '4', '5', '6', 'x',

    '1', '2', '3', '-',

    '0', '.', '=', '+',
  ];

  final List<String> operator = ['÷', '×', '-', '+', '%'];
  final List<String> number = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  var userInput = ''.obs;
  var answer = ''.obs;
  bool operatorClicked = false;

  void equal(){
    String finaluserinput = userInput.value;

    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer.value = eval.toString();
    if (answer.endsWith('.0')) {
      answer.value = answer.replaceAll('.0', '');
    }
    update();
  }
  void input(int index){
    String input = buttons[index];
    // userInput.value += buttons[index];
    // Memeriksa apakah input adalah operator
    if (isOperator(input)) {
      // Memeriksa apakah operator sudah diklik sebelumnya
      if (input == '-' && endsWithNumber(userInput.value)) {
        operatorClicked = true;
        userInput.value += input;
        update();
      } else {
          if(!operatorClicked){
            operatorClicked = true;
            userInput.value += input;
            update();
          }
      }
    }
    else {
      // Jika input bukan operator, reset operatorClicked menjadi false
      operatorClicked = false;
      userInput.value += input;
      update();
    }
    // update();
  }
  bool isOperator(String input) {
    return (input == '/' || input == 'x' || input == '-' || input == '+' || input == '=' || input == '%');
  }

  void clear(){
    userInput.value = '';
    answer.value = '';
    update();
  }

  void delete(){
    userInput.value = userInput.substring(0, userInput.value.length-1);
    update();
  }

  void openingBracket(){
    if(endsWithNumber(userInput.value) || userInput.endsWith('%') || userInput.endsWith(')')){
      userInput.value += '×';
    }
    userInput.value += '(';
    answer.value = '';
  }

  void closingBracket(){
    userInput.value += ')';
    CalController();
  }

  bool endsWithNumber(String question){
    for(int i = 0; i < number.length; i++){
      if(question.endsWith(number[i])){
        return true;
      }
    }
    return false;
  }
}