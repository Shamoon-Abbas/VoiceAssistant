import 'package:flutter/material.dart';
import 'package:voice_assistant/pallete.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allen"),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.assistantCircleColor
                  ),
                ),
              ),
              Container(
                  height: 153,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/va.webp"))
                  ),
                  // child: Image.asset("assets/images/virtualAssistant.png")
                ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Pallete.borderColor,width: 2
                ),borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Good morning, what task can I do for you?",style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 25
                ),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text("Here are a few features",style: TextStyle(
              fontFamily: 'Cera Pro',
              color: Pallete.mainFontColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
          ),
          
        ],
      ),


    );
  }
}