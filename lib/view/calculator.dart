import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorApp> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
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
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _key = GlobalKey<FormState>();
  int first = 0; // First operand
  int second = 0; // Second operand
  String operator = ""; // Store the operator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        String symbol = lstSymbols[index];
                        if (symbol == "C") {
                          _textController.clear();
                          first = second = 0;
                          operator = "";
                        } else if (symbol == "<-") {
                          _textController.text = _textController.text.isNotEmpty
                              ? _textController.text
                                  .substring(0, _textController.text.length - 1)
                              : "";
                        } else if (symbol == "=") {
                          second = int.parse(_textController.text);
                          switch (operator) {
                            case "+":
                              _textController.text =
                                  (first + second).toString();
                              break;
                            case "-":
                              _textController.text =
                                  (first - second).toString();
                              break;
                            case "*":
                              _textController.text =
                                  (first * second).toString();
                              break;
                            case "/":
                              _textController.text = second != 0
                                  ? (first / second).toString()
                                  : "Error";
                              break;
                            default:
                              _textController.text = "Error";
                          }
                          operator = ""; // Reset operator after calculation
                          first = second = 0;
                        } else if (symbol == "+" ||
                            symbol == "-" ||
                            symbol == "*" ||
                            symbol == "/") {
                          first = int.parse(_textController.text);
                          operator = symbol; // Set the operator
                          _textController.clear();
                        } else {
                          _textController.text += symbol;
                        }
                      },
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
