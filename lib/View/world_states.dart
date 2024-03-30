import 'dart:async';
import 'package:covid_app/View/countery_list.dart';
import 'package:covid_app/services/counterstates.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[Colors.red, Colors.blue, Colors.yellow];
  @override
  CounterState counterState = CounterState();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 23,
            ),
            FutureBuilder(
                future: counterState.covidstates(),
                builder: (context, Snapshot) {
                  print(Snapshot.data);
                  if (!Snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitCircle(
                          color: Colors.amberAccent,
                          size: 50,
                          controller: _controller,
                        ));
                  }
                  if (Snapshot.hasData) {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(Snapshot.data!.cases.toString()),
                            "recoderd": double.parse(
                                Snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(Snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: Duration(seconds: 5),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        SizedBox(
                          height: 24,
                        ),

                  
                        SizedBox(height: 400,
                          child: ListView(shrinkWrap: true, children: [
                            Reuserow(
                                title: 'updated',
                                value: Snapshot.data!.updated.toString()),
                            Reuserow(
                                title: 'todayCases',
                                value: Snapshot.data!.todayCases.toString()),
                            Reuserow(
                                title: 'deaths',
                                value: Snapshot.data!.deaths.toString()),
                            Reuserow(
                                title: 'todayDeaths',
                                value: Snapshot.data!.todayDeaths.toString()),
                            Reuserow(
                                title: 'recovered',
                                value: Snapshot.data!.recovered.toString()),
                            Reuserow(
                                title: 'active',
                                value: Snapshot.data!.active.toString()),
                            Reuserow(
                                title: 'critical',
                                value: Snapshot.data!.critical.toString()),
                            Reuserow(
                                title: 'affectedCountries',
                                value: Snapshot.data!.affectedCountries.toString()),
                          
                          ]),
                        ),
                        FilledButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>CounteryList() ));
                            }, child: Text('track more'))
                      ],
                    );
                  } else {
                    return Text('data');
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class Reuserow extends StatelessWidget {
  String title, value;

  Reuserow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        ListTile(
          dense: true,
          title: Text(title),
          subtitle: Text(value),
        )
      ],
    );
  }
}
