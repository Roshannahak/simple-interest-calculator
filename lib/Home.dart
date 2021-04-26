import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<Home> {
  var minpadding = 5.0;
  var list = ["RS", "USD"];
  var def = "";
  String result = "";

  TextEditingController _principal = TextEditingController();
  TextEditingController _rate = TextEditingController();
  TextEditingController _months = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    def = list[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: minpadding * 2, right: minpadding * 2),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(minpadding * 4),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("images/calculator.png"),
                  height: 150.0,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(minpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _principal,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "please enter the principal amo.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 14.0),
                        labelText: "Principal",
                        hintText: "Enter Amount eg:40000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    style: TextStyle(fontSize: 20.0),
                  )),
              Padding(
                  padding: EdgeInsets.all(minpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _rate,
                    validator: (value) {
                      if(value.isEmpty){
                        return "please enter rate of amo.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter rate of interest eg: 4",
                        errorStyle: TextStyle(fontSize: 14.0),
                        labelText: "Rate",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        suffix: Text("%")),
                    style: TextStyle(fontSize: 20.0),
                  )),
              Padding(
                  padding: EdgeInsets.all(minpadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _months,
                        validator: (value) {
                          if(value.isEmpty){
                            return "please enter month.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 14.0),
                            labelText: "Months",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        style: TextStyle(fontSize: 20.0),
                      )),
                      Container(
                        width: minpadding * 2,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: DropdownButton<String>(
                              items: list.map((String curr) {
                                return DropdownMenuItem<String>(
                                  child: Text(curr),
                                  value: curr,
                                );
                              }).toList(),
                              value: def,
                              onChanged: (String value) {
                                setState(() {
                                  def = value;
                                });
                              }),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(minpadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                            elevation: 5.0,
                            child: Text(
                              "Calculate",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  result = CalculateResult();
                                }
                              });
                            })),
                    Container(
                      width: minpadding,
                    ),
                    Expanded(
                        child: RaisedButton(
                            elevation: 5.0,
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                _principal.text = '';
                                _rate.text = '';
                                _months.text = '';
                                result = '';
                                def = list[0];
                              });
                            }))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(minpadding),
                child: Text(
                  "$result",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String CalculateResult() {
    double p = double.parse(_principal.text);
    double r = double.parse(_rate.text);
    double t = double.parse(_months.text);

    double total = (p * r * t) / 100;
    String finalResult = "the total interest is $total $def";

    return finalResult;
  }
}
