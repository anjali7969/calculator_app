import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorApp> {
  final _textController = TextEditingController();
  final _key = GlobalKey<FormState>();
  double first = 0;
  double second = 0;
  String operator = "";

  List<String> lstSymbols = [
    "C",
    "/",
    "*",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "%",
    "0",
    ".",
    "="
  ];

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        first = 0;
        second = 0;
        operator = "";
        _textController.text = "";
      } else if (symbol == "<-") {
        if (_textController.text.isNotEmpty) {
          _textController.text = _textController.text
              .substring(0, _textController.text.length - 1);
        }
      } else if (symbol == "=") {
        if (operator.isNotEmpty && _textController.text.isNotEmpty) {
          second = double.tryParse(_textController.text) ?? 0;
          double result = _calculateResult();

          // Format result to avoid decimal if it's a whole number
          _textController.text =
              result % 1 == 0 ? result.toInt().toString() : result.toString();

          first = result;
          operator = "";
          second = 0;
        }
      } else if (symbol == "+" ||
          symbol == "-" ||
          symbol == "*" ||
          symbol == "/") {
        if (_textController.text.isNotEmpty) {
          first = double.tryParse(_textController.text) ?? 0;
          operator = symbol;
          _textController.text = "";
        }
      } else {
        _textController.text += symbol;
      }
    });
  }

  double _calculateResult() {
    switch (operator) {
      case "+":
        return first + second;
      case "-":
        return first - second;
      case "*":
        return first * second;
      case "/":
        return second != 0 ? first / second : 0; // Division with check for zero
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                readOnly: true,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _onButtonPressed(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
