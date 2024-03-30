import 'package:covid_app/model/counteryslist.dart';
import 'package:covid_app/services/counterstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CounteryList extends StatefulWidget {
  const CounteryList({super.key});

  @override
  State<CounteryList> createState() => _CounteryListState();
}

class _CounteryListState extends State<CounteryList>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
TextEditingController searchtext = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  CounterState counterState = CounterState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8),child: TextField(onChanged: (value) {
              setState(() {
                
              });
            },decoration: InputDecoration(label: Text('Search with countery name'),contentPadding: EdgeInsets.symmetric(horizontal: 20),border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),controller: searchtext,),),

            Expanded(
              child: FutureBuilder(
                  future: counterState.counteryData(),
                  builder: (context, AsyncSnapshot<List<dynamic>>snapshot) 
                  {print(snapshot.data);
                    if (!snapshot.hasData) {
                      return  Shimmer.fromColors(baseColor: Colors.grey.shade700, highlightColor:Colors.grey.shade100, child:ListView.builder(
                          itemCount: 15,
                          itemBuilder: (context, state) {
                        
                            return ListTile(
                              leading:Container(height: 60,width: 60,color: Colors.white,),
                              title:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(height: 28,width: 60,color: Colors.white,),
                              ),
                           subtitle: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(height: 16,width: 60,color: Colors.white,),
                           ),
                            );
                          }));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, state) {
                            String name =snapshot.data![state]['country'];
                            print('>>>>>>>>>>>${snapshot.data}');
                            if(searchtext.text.isEmpty)
                            {   return ListTile(
                              leading:Container(height: 60,width: 60,child: Image.network(snapshot.data![state]['countryInfo']['flag'])),
                              title: Text(snapshot.data![state]['country']),
                           subtitle: Text(snapshot.data![state]['continent']),
                            );

                            }
                            else if(name.toLowerCase().contains(searchtext.text.toLowerCase() ) ){   return ListTile(
                              leading:Container(height: 60,width: 60,child: Image.network(snapshot.data![state]['countryInfo']['flag'])),
                              title: Text(snapshot.data![state]['country']),
                           subtitle: Text(snapshot.data![state]['continent']),
                            );}else{return Container();}
                         
                          });
                    } else {
                      print('>>>>>>>>>>>${snapshot.data}');
                      return Text('no data found');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
