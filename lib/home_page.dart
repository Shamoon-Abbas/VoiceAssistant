import 'package:flutter/material.dart';
import 'package:voice_assistant/feature_box.dart';
import 'package:voice_assistant/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText= SpeechToText();
  String lastWords='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async{
    await speechToText.initialize();
    setState(() {});
  }


  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
  }


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
                  margin: EdgeInsets.only(top: 10),
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
          FeatureBox(color: Pallete.firstSuggestionBoxColor, header: "ChatGPT", description: "A smarter way to stay organized and informed with ChatGPT"),
          FeatureBox(color: Pallete.secondSuggestionBoxColor, header: "Dall-E", description: "Get inspired and stay creative with your personal assistant powered by Dall-E"),
          FeatureBox(color: Pallete.thirdSuggestionBoxColor, header: "Smart Voice Assistant", description: "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT"),


        ],
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Pallete.secondSuggestionBoxColor,onPressed: ()async{
        if(await speechToText.hasPermission && speechToText.isNotListening){
          await startListening();
        } else if(speechToText.isListening){
          await stopListening();
        }else{
          initSpeechToText();
        }
      },child: Icon(Icons.mic),),


    );
  }
}