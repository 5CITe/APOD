import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apod/model.dart';
import 'package:image_ink_well/image_ink_well.dart';


import 'details.dart';
class ApodCard extends StatelessWidget {

  final Apod apod;

  const ApodCard({Key key, this.apod}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      margin: EdgeInsets.all(15.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 400,
                height: 300,
                child:Center(
                  child: CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation(Colors.black)
                  ),
                ),
              ),
              Hero(
                tag: apod.date,
                child: RoundedRectangleImageInkWell(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(apod:apod),
                      )
                    );
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  height: 300,
                  width: 400,
                  fit: BoxFit.cover,
                  backgroundColor: Colors.transparent,
                  image:CachedNetworkImageProvider(apod.url),
                ),
              ),

            ],

          ),
          Text(apod.title.toUpperCase(),style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
