import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Unit Converter',
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xff5882E3).withOpacity(0.63),
            title: const Text('Unit Converter'),
          ),
          body: const HomeScreen(),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextStyle labelStyle =
      const TextStyle(fontSize: 16.0, color: Colors.white);
  final TextStyle resultSyle = const TextStyle(
    color: Colors.black,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Miles',
    'Pounds',
    'Ounces',
    'Centimeters'
  ];

  late double _value;
  String _fromMesaures = 'Meters';
  String _toMesaures = 'Kilometers';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds': 6,
    'Ounces': 7,
    'Centimeters': 8
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0, 100],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0, 100000],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274, 0],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274, 0],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0, 30.48],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0, 160934],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16, 0],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1, 0],
    '8': [0.01, 0.00001, 0, 0, 0.0328084, 0.00000621371, 0, 0, 1],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xff1F253B).withOpacity(0.2),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 350),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              TextField(
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  label: const Text(
                    'Enter your value',
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xff5882E3),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xff5882E3),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) {
                  setState(() {
                    _value = double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'From',
                      ),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromMesaures = value!;
                          });
                        },
                        value: _fromMesaures,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('To', style: TextStyle(fontSize: 16)),
                      DropdownButton(
                        focusColor: Colors.white,
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _toMesaures = value!;
                          });
                        },
                        value: _toMesaures,
                      )
                    ],
                  ),
                ],
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
                color: const Color(0xff5882E3),
                child: const Text(
                  'Convert',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 25.0),
              Text(
                _results,
                style: resultSyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convert() {
    print('Button Clicked');
    print(_value);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int from = _mesauresMap[_fromMesaures]!;
      int to = _mesauresMap[_toMesaures]!;

      var multiplier = _formulas[from.toString()][to];

      setState(() {
        _results =
            "$_value $_fromMesaures = ${_value * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Please enter a non zero value";
      });
    }
  }
}
