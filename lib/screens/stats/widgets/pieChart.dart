import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class PieChart extends StatefulWidget {
  //  final String title;

  @override
  _PieChart createState() => _PieChart();
}

  class _PieChart extends State<PieChart> {
  late List<MOCKData> _chartData;


  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCircularChart(
        title: ChartTitle(text: 'Your Personal Chart'),
        legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        series: <CircularSeries>[
        DoughnutSeries<MOCKData, String>(
          dataSource: _chartData,
          xValueMapper: (MOCKData data,_) => data.field,
          yValueMapper: (MOCKData data,_) => data.number,
          dataLabelSettings: DataLabelSettings(isVisible: true))
      ]),
    );
    }

  List<MOCKData> getChartData() {
    final List<MOCKData> chartData = [
        MOCKData('Personal', 47),
        MOCKData('Work',     42),
        MOCKData('Health',   11)
      ];

      return chartData;
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
}

// class _PieChartState extends State<PieChart> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SfCircularChart(series: <CircularSeries>[
//         PieSeries<MOCKData, String>(dataSource: _chartData)
//       ]),
//     );

    // List<MOCKData> getChartData() {
    //   final List<MOCKData> chartData = [
    //     MOCKData('Personal', 47),
    //     MOCKData('Work',     42),
    //     MOCKData('Health',   11)
    //   ];

    //   return chartData;
    // }
//   }
// }

class MOCKData {
  MOCKData(this.field, this.number);
  final String field;
  final int number;
}