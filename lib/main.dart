import 'package:flutter/material.dart';

void main() {
  runApp(const Fibonacci());
}

class Fibonacci extends StatefulWidget {
  const Fibonacci({super.key});

  @override
  State<Fibonacci> createState() => _FibonacciState();
}

class _FibonacciState extends State<Fibonacci> {
  final TextEditingController _controller = TextEditingController();
  int fibonacciValue = 0;
  final _focusNode = FocusNode();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fibonacci'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    onTapOutside: (event) {
                      _focusNode.unfocus();
                    },
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      focusedErrorBorder: _getBorderForTextField(Colors.red),
                      errorText: errorText.trim().isNotEmpty ? errorText : null,
                      errorBorder: _getBorderForTextField(Colors.red),
                      enabledBorder: _getBorderForTextField(Colors.blue),
                      focusedBorder: _getBorderForTextField(Colors.blue),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Heebo',
                          height: 1,
                          fontWeight: FontWeight.w400),
                      labelText:
                          'Enter the position of the fibonacci number you want :',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    if (_controller.text.isNotEmpty) {
                      try {
                        fibonacciValue =
                            fibonacciCalculation(int.parse(_controller.text));
                      } catch (exception) {
                        errorText = 'Please enter a valid input';
                      }
                      setState(() {
                        _controller.clear();
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.blue),
                    child: const Center(
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.32,
                            fontFamily: 'Heebo'),
                      ),
                    ),
                  )),
              if ((errorText).isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                      'Fibonacci Value at ${_controller.text} is : $fibonacciValue'),
                )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _getBorderForTextField(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}

int fibonacciCalculation(int position) {
  if (position <= 1) {
    return position;
  }

  int a = 0;
  int b = 1;
  int? c;
  for (int i = 2; i <= position; i++) {
    c = a + b;
    a = b;
    b = c;
  }
  return c!;
}
