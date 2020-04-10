import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '0';
  final _currencies = ['Rupees', 'Dollars', 'Pounds'];
  String _currency = 'Rupees';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final double _formDistance = 5.0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("💰 Trip Cost App 💰"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                      labelText: 'Distance',
                      hintText: 'e.g. 124',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,

                  // We do not need onchenged method as TextEditingController will take care of it
                  // onChanged: (String string) {
                  //   setState(() {
                  //     name = string;
                  //   });
                  // },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  controller: avgController,
                  decoration: InputDecoration(
                      labelText: 'Distance per Unit',
                      hintText: 'e.g. 17',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,

                  // We do not need onchenged method as TextEditingController will take care of it
                  // onChanged: (String string) {
                  //   setState(() {
                  //     name = string;
                  //   });
                  // },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: _formDistance, bottom: _formDistance),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                              labelText: 'Price',
                              hintText: 'e.g. 1.54',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          keyboardType: TextInputType.number,

                          // We do not need onchenged method as TextEditingController will take care of it
                          // onChanged: (String string) {
                          //   setState(() {
                          //     name = string;
                          //   });
                          // },
                        ),
                      ),
                      Container(
                        width: _formDistance * 5,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currency,
                          onChanged: (String value) {
                            _onDropdownChanged(value);
                          },
                        ),
                      ),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        setState(() {
                          result = _calculate();
                        });
                      },
                      child: Text(
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    width: 15.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).primaryColorDark,
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  "🙏 Namaste 🙏",
                  textScaleFactor: 2.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Total Cost of your Trip is",
                  textScaleFactor: 2.0,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.blue),
                // color: Colors.blue,
                margin: EdgeInsets.only(top: 20.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    result + ' ' + _currency,
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onDropdownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(avgController.text);
    double _consumption = double.parse(priceController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = _totalCost.toStringAsFixed(2);
    return _result;
  }

  _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    result = '0';
  }
}
