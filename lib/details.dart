import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'model.dart';
class DetailsPage extends StatelessWidget {
  final Apod apod;

  const DetailsPage({Key key, this.apod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(apod.title),
      backgroundColor: Colors.black),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Hero(
                tag: apod.date,
                child:FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: apod.url,fit: BoxFit.contain,)
              ),
            ],
          ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Text(apod.date,style:TextStyle(fontSize: 12.0,fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),
                    Container(
                      width: 260,
                      child: Text("© ${apod.copyright}",softWrap: true,textAlign: TextAlign.end,style:TextStyle(fontSize: 12.0,fontWeight: FontWeight.normal,fontStyle: FontStyle.italic)),

                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(apod.description,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
              )
            ],


      ),

    );
  }
}
