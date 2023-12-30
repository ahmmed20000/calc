import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calc extends StatefulWidget {
  @override
  State<calc> createState() => _calcState();
}

class _calcState extends State<calc> {
  String output = "";
  String input = "";
  List sympol = [
    "c",
    "/",
    "*",
    "",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "ans",
    "%",
    "0",
    ".",
    "="
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("calculator"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 228, 212, 68),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 70, left: 20),
              child: Text(
                input,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              child: Text(
                output,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.yellow),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: sympol.length,
              itemBuilder: (BuildContext context, int index) {
                return generate(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget generate(int index) {
    if (index == 3) {
      return GestureDetector(
        onTap: () {
          setState(() {
            input = input.substring(0, input.length - 1);
          });
        },
        child: Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: colors(index), borderRadius: BorderRadius.circular(100)),
            alignment: Alignment.center,
            child: const Icon(Icons.backspace_sharp)),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (index == 0) {
              input = "";
              output = "";
            } else if (index == 15) {
              input = output;
              output = "";
            } else if (index == 1 ||
                index == 2 ||
                index == 7 ||
                index == 11 ||
                index == 16||
                index==18) {
              if (input.endsWith("*") ||
                  input.endsWith("-") ||
                  input.endsWith("/") ||
                  input.endsWith("+") ||
                  input.endsWith("%") ||
                  input.endsWith(".")) {
                null;
              } else if (index == 19) {
                Expression e = Parser().parse(input);
                double result = e.evaluate(EvaluationType.REAL, ContextModel());
                setState(() {
                  output = result.toString();
                });
              } else {
                input += sympol[index];
              }
            } else {
              input += sympol[index];
            }
          });
        },
        child: Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: colors(index), borderRadius: BorderRadius.circular(100)),
          alignment: Alignment.center,
          child: Text(
            "${sympol[index]}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
      );
    }
  }

  Color colors(int index) {
    if (index == 0) {
      return Colors.red;
    } else if (index == 1 ||
        index == 2 ||
        index == 3 ||
        index == 7 ||
        index == 11 ||
        index == 15 ||
        index == 19) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }
}
