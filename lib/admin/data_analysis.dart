import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proj_nine/provider/average.dart';
import 'package:provider/provider.dart';

class DataAnalysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final agesProvider = Provider.of<AverageProvider>(context).ages;
    final gendersProvider = Provider.of<AverageProvider>(context).gender;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          PieChart(
            dataMap: {
              '-18': agesProvider['-18'].length.toDouble(),
              '+18 & -30': agesProvider['+18 & -30'].length.toDouble(),
              '+30 & -40': agesProvider['+30 & -40'].length.toDouble(),
              '+40': agesProvider['+40'].length.toDouble()
            },
          ),
          PieChart(
            dataMap: {
              'male': gendersProvider['male'].length.toDouble(),
              'female': gendersProvider['female'].length.toDouble(),
            },
            chartType: ChartType.ring,
            colorList: [
              Colors.black,
              Colors.amber,
            ],
          ),
        ],
      ),
    );
  }
}
