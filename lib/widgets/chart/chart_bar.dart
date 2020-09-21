import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(
    this.label,
    this.spendingAmount,
    this.spendingPctOfTotal,
  );

  double _getResponsiveHeight(double pctOfVview, BoxConstraints constraints) {
    return constraints.maxHeight * (pctOfVview / 100);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: _getResponsiveHeight(14, constraints),
              child: FittedBox(
                child: Text(
                  '${spendingAmount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 12
                  ),
                ),
              ),
            ),
            Container(
              height: _getResponsiveHeight(75, constraints),
              width: 15,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[800],
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: _getResponsiveHeight(11, constraints),
              child: FittedBox(
                child: Text(label),
              ),
            )
          ],
        );
      },
    );
  }
}
