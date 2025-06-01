import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
=======
>>>>>>> parent of 435a15c (chatGPT or Dall-E decision by chatGPT)
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
<<<<<<< HEAD
  final OpenAIService openAIService=OpenAIService();
  final flutterTts=FlutterTts();
  String? generatedContent;
  String? generatedImageUrl;
=======
>>>>>>> parent of 435a15c (chatGPT or Dall-E decision by chatGPT)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

<<<<<<< HEAD


  Future<void> initSpeechToText() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      await speechToText.initialize(onStatus: (status) {
        print('Speech status: $status');
        if (status == 'notListening') {
          setState(() {}); // update the mic icon
        }
      },
      );
      setState(() {});
    } else {
      // Show a dialog or message indicating the user must allow the mic permission
      print('Microphone permission not granted');
    }
  }


  Future<void> initTextToSpeech() async {
    await flutterTts.awaitSpeakCompletion(true);
    setState(() {
    });
  }




=======
  Future<void> initSpeechToText() async{
    await speechToText.initialize();
    setState(() {});
  }


>>>>>>> parent of 435a15c (chatGPT or Dall-E decision by chatGPT)
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    if (lastWords.isNotEmpty) {
      final speech = await openAIService.isArtPromptAPI(lastWords);
      if (speech.contains('https')) {
        generatedImageUrl = speech;
        generatedContent = null;
      } else {
        generatedImageUrl = null;
        generatedContent = speech;
        await systemSpeak(speech);
      }
      setState(() {});
    }
  }


  // Future<void> stopListening() async {
  //   await speechToText.stop();
  //   setState(() {});
  // }

  void onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      lastWords = result.recognizedWords;
    });

    if (result.finalResult) {
      final speech = await openAIService.isArtPromptAPI(lastWords);
      if (speech.contains('https')) {
        generatedImageUrl = speech;
        generatedContent = null;
      } else {
        generatedImageUrl = null;
        generatedContent = speech;
        await systemSpeak(speech);
      }

      await stopListening();
      setState(() {});
    }
  }


  // void onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     lastWords = result.recognizedWords;
  //   });
  // }


  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(
          child: Text("Azkaban 1.0",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'Cera Pro'
          ),),
        ),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
<<<<<<< HEAD
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            ZoomIn(
              child: Stack(
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
            ),
            FadeInLeft(
              child: Visibility(
                visible: generatedImageUrl==null,
                child: Container(
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
                      child: Text(generatedContent==null ? "Good morning, what task can I do for you?" : generatedContent!,style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Pallete.mainFontColor,
                        fontSize: generatedContent==null ? 25 : 18,
                      ),),
                    ),
                  ),
                ),
              ),
            ),

            if(generatedImageUrl!=null) Padding(
              padding: const EdgeInsets.all(10),
              child: SlideInLeft(child: ClipRRect(borderRadius: BorderRadius.circular(20) ,child: Image.network(generatedImageUrl!))),
            ),

            Visibility(
              visible: generatedImageUrl==null && generatedContent==null,
              child: Column(
                children: [
                  Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SlideInLeft(
                  delay: Duration(milliseconds: 200),
                  child: Text("Here are a few features",style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),

                  SlideInLeft(delay: Duration(milliseconds: 400), child: FeatureBox(color: Pallete.firstSuggestionBoxColor, header: "ChatGPT", description: "A smarter way to stay organized and informed with ChatGPT")),
                  SlideInLeft(delay: Duration(milliseconds: 600), child: FeatureBox(color: Pallete.secondSuggestionBoxColor, header: "Dall-E", description: "Get inspired and stay creative with your personal assistant powered by Dall-E")),
                  SlideInLeft(delay: Duration(milliseconds: 800), child: FeatureBox(color: Pallete.thirdSuggestionBoxColor, header: "Smart Voice Assistant", description: "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT")),
                  SizedBox(height: 50,),
                ],
              ),
            )
        
        
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        child: SlideInLeft(
          delay: Duration(milliseconds: 1000),
          child: FloatingActionButton(
            backgroundColor: Pallete.secondSuggestionBoxColor,
              onPressed: () async {
                if (!speechToText.isListening) {
                  if (await speechToText.hasPermission) {
                    await startListening();
                  } else {
                    await initSpeechToText();
                  }
                } else {
                  await stopListening(); // Stop immediately on tap
                }
              },
            child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
          ),
        ),
      ),
=======
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
>>>>>>> parent of 435a15c (chatGPT or Dall-E decision by chatGPT)


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