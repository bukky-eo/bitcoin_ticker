import 'package:flutter/material.dart';

class CurrencyTickerCard extends StatelessWidget {
  const CurrencyTickerCard({
    Key? key,
    this.coinRate,
    required this.selectedCurrency,
    required this.cryptoCurr,
  }) : super(key: key);

  final String? coinRate;
  final String selectedCurrency;
  final String cryptoCurr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.deepPurpleAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurr = $coinRate $selectedCurrency',
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
