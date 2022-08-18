// import 'dart:math';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'ticker_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  Map<String, String> cryptoCoinRate = {};
  String selectedCurrency = 'AUD';
  String coinRate = '?';
  bool isWaiting = true;

  @override
  void initState() {
    super.initState();
    getCoinRate();
  }

  List<Widget> getCryptoCurrency() {
    List<Widget> cryptoCurrency = [];
    for (String crypto in cryptoList) {
      var newCrypto = CurrencyTickerCard(
        coinRate: isWaiting ? '?' : cryptoCoinRate[crypto],
        selectedCurrency: selectedCurrency,
        cryptoCurr: crypto,
      );
      cryptoCurrency.add(newCrypto);
    }
    return cryptoCurrency;
  }

  void getCoinRate() async {
    isWaiting = true;
    try {
      var values = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoCoinRate = values;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getCoinRate();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getCoinRate();
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('🤑 Coin Ticker'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            // mainAxisAlignment: MainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoCurrency(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.deepPurpleAccent,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
