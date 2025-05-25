import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String header;
  final String description;

  const FeatureBox({super.key, required this.color, required this.header, required this.description});



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:20,left: 30,right: 30),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15)
      ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(header,style: TextStyle(fontSize: 20,fontFamily:"Cera Pro",
              fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(description,style: TextStyle(fontSize: 15,fontFamily: "Cera Pro",
              fontWeight: FontWeight.w400,),)
            ],
          ),
        ),
      );
  }
}
