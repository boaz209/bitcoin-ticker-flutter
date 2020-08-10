import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getDataCoin('USD', 'BTC');
  }

  String selectedCurrency = 'USD';
  String coinValue;
  String coinType = 'BTC';
  // BTC ETH LTC
  void getDataCoin(String coin, String coinType) async {
    NetworkHelper network = NetworkHelper();
    var dataCoin = await network.getStatus(
        'https://rest.coinapi.io/v1/exchangerate/$coinType/$coin?apikey=$kAPIkey');

    setState(() {
      try {
        coinValue = dataCoin['rate'].toStringAsFixed(0);
        print('coinValue $coinValue');
      } catch (e) {
        coinValue = '0';
      }
    });
  }

  DropdownButton androidDropdwon() {
    List<DropdownMenuItem> dropdownItems = [];

    for (int i = 0; i < currenciesList.length; i++) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currenciesList[i]),
          value: currenciesList[i],
        ),
      );
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getDataCoin(value, coinType);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> dropdownItems = [];
    for (String item in currenciesList) {
      dropdownItems.add(Text(item, style: TextStyle(color: Colors.white)));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          print('selectedIndex ${currenciesList[selectedIndex]}');
          selectedCurrency = currenciesList[selectedIndex];
          getDataCoin(currenciesList[selectedIndex], coinType);
        });
      },
      children: dropdownItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF81269D), const Color(0xFFEE112D)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                // stops: [0.0, 0.1],
              ),
            ),
            height: MediaQuery.of(context).size.height * .40,
            padding: EdgeInsets.only(top: 55, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '\$43,729.00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card_Coin(
            coinValue: coinValue,
            selectedCurrency: selectedCurrency,
            coinTypes: coinType = 'BTC',
          ),
          Card_Coin(
            coinValue: coinValue,
            selectedCurrency: selectedCurrency,
            coinTypes: coinType = 'ETH',
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $coinValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blueGrey,
            child: Platform.isAndroid ? androidDropdwon() : iosPicker(),
          ),
        ],
      ),
    );
  }
}

class Card_Coin extends StatelessWidget {
  const Card_Coin({
    Key key,
    @required this.coinValue,
    @required this.selectedCurrency,
    @required this.coinTypes,
  }) : super(key: key);

  final String coinValue;
  final String selectedCurrency;
  final String coinTypes;

  // BTC ETH LTC

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
          child: Text(
            '1 $coinTypes = $coinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
