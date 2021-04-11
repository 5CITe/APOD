import 'dart:convert';

import 'package:flutter/material.dart';
import 'apodCard.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'package:apod/error.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

DateTime selectedDate = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(selectedDate);

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Apod>> apod;
  final String uri = "https://count=5apodapi.herokuapp.com/api/?";
   String uri2;

  Future<List<Apod>> fetchApod() async {

    var response = await http.get(uri);

    if(response.statusCode==200){ //200 is all - ok for http
      //jsonDecode returns json object after parsing string
      final jsonList = jsonDecode(response.body);

      if(jsonList is List){//if it retrieves a list successfully, map it
        //fromJson --> models so json object mapped to apod object
        return jsonList.map((json) => Apod.fromJson(json)).toList();
      }
    }
    throw Exception("HTTP CALL ERROR");
  }

  @override
  void initState() {
    //on start
    super.initState();
    //getter
    apod=fetchApod();
  }





  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text("NASA APOD",style:TextStyle(fontSize: 30.0,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
            //..color = Colors.blue[700],
              ..shader = ui.Gradient.linear(
                const Offset(0, 20),
                const Offset(150, 20),
                <Color>[
                  Colors.red,
                  Colors.amber,
                ],)),),
        elevation: 16.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        actions:<Widget>[
          IconButton(icon: Icon(Icons.autorenew),
            onPressed: (){
              setState(() {
                apod=fetchApod();
              });
            },
          )
        ],
    ),

      body:Container(
   // constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/bg2.jpg"),
    fit: BoxFit.cover)),
     child:FutureBuilder(
       future: apod,
       builder: (BuildContext context,AsyncSnapshot<List<Apod>> snapshot){
         if(snapshot.hasData){
           return ListView(
             padding: EdgeInsets.all(16.0),
             children: snapshot.data.map((apod) => ApodCard(apod:apod)).toList(),
           );
         }
         else if(snapshot.hasError){
           return Error(error:snapshot.error);
         }
         else {
           return Center (
             child: CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation(Colors.white),
             ),
           );
         }
       },
     ),
      ),
      //TODO
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.calendar_today),
        backgroundColor: Colors.amber,
        onPressed: ()=> _selectDate(context),
      ),

    );
  }
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2022),
      builder: (context,child){
        return Theme(
          data: ThemeData(primarySwatch: Colors.amber),
          child: child,
        );
      }
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        uri2="https://apodapi.herokuapp.com/api/?date="+formatted;
        print(uri2);
      });
  }

}


