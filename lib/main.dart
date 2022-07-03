// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
    title: 'Simple Interest Calculator App',
    debugShowCheckedModeBanner: false,
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<SIForm> createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];

  final _minimumPadding = 5.0;

  var _currenItemSelected = "Rupees";

  TextEditingController principalController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    // TextStyle textStyle = Theme.of(context).textTheme.headline;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(children: [
          getAssetimage(),
          Padding(
            padding: EdgeInsets.all(_minimumPadding),
            child: TextField(
              // textInputAction: TextInputAction.continueAction,
              textAlign: TextAlign.center,
              controller: principalController,
              autocorrect: false,
              // focusNode: inputOne,

              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefix: Text("\$"),
                  labelText: 'principal',
                  hintText: 'fadlan gali lacagta e.g 200\$',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: TextField(
              // textInputAction: TextInputAction.send,
              textAlign: TextAlign.center,
              controller: interestController,
              // autocorrect: false,
              // focusNode: inputTwo,
              // controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefix: Text("\%"),
                  labelText: 'Rate of Inerest',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // textInputAction: TextInputAction.send,
                  textAlign: TextAlign.center,
                  controller: termController,
                  // autocorrect: false,
                  // focusNode: inputTwo,
                  // controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefix: Text("\%"),
                      labelText: 'Term',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButton<String>(
                  items: _currencies.map((String value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  value: _currenItemSelected,
                  onChanged: (value) {
                    setState(() {
                      _currenItemSelected = value.toString();
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColorDark,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black),
                ),
                splashColor: Color.fromARGB(255, 157, 255, 159),
                onPressed: () {
                  setState(() {
                    this.displayResult = calculateTotalResult();
                  });
                },
                child: Text(
                  "Calculate",
                  textScaleFactor: 1.2,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black),
                ),
                splashColor: Colors.yellow[200],
                onPressed: () => setState(() {
                  reset();
                }),
                child: Text(
                  "Reset",
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: Center(
              child: Text(
                this.displayResult,
                style: (TextStyle(fontSize: 20)),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget getAssetimage() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125,
      height: 125,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  // void _onDropDownItemSelected(String newValueSelected) {
  //   setState(() {
  //     this._currenItemSelected = newValueSelected;
  //   });
  // }
  String calculateTotalResult() {
    var principal = double.parse(principalController.text);
    var interest = double.parse(interestController.text);
    var term = double.parse(termController.text);

    double answer = principal + (principal * interest * term) / 100;

    var result =
        "After $term years, your investment will be worth $answer ,$_currenItemSelected";
    return result;
  }

  void reset() {
    principalController.text = '';
    interestController.text = '';
    termController.text = "";
    displayResult = "";
    _currenItemSelected = _currencies[0];
  }
}
