

import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../api/speech_api.dart';
import '../main.dart';





class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
  bool isListening = false;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {

    _initSpeech();
    super.initState();
  }
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {
    });
  }
  void _startListening() async {
    print("object");
    await _speechToText.listen(onResult: (v)=> setState(() {
      log(text);
      if (kDebugMode) {
        print(v.recognizedWords);
      }
      text=v.recognizedWords;
    }));
    setState(() {});
  }
  void _stopListening() async {
    await _speechToText.stop();
    _lastWords=text;
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.






  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color.fromARGB(255, 212, 236, 248),
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 212, 236, 248),
      title: Text("speech"),
      centerTitle: true,

    ),
    body: SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.all(30).copyWith(bottom: 150),
      child:        Expanded(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 212, 236, 248),
              padding: EdgeInsets.all(16),
              child: Text(
                // If listening is active show the recognized words
                _speechToText.isListening
                    ? '$text'
                // If listening isn't active but could be tell the user
                // how to start it, otherwise indicate that speech
                // recognition is not yet ready or not supported on
                // the target device
                    : _speechEnabled
                    ? 'Tap the microphone to start listening...'
                    : 'Speech not available',
              ),

            ),
            Text('$_lastWords'),

          ],
        ),
      ),
    ),

    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: AvatarGlow(
      animate: _speechToText.isListening,
      endRadius: 75,
      glowColor: Color(0xfffff),
      child: FloatingActionButton(
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic, size: 36),
        onPressed:  _speechToText.isNotListening ? _startListening : _stopListening,
      ),
    ),

  );

  Future toggleRecording() => SpeechApi.toggleRecording(
    onResult: (text) => setState(() => this.text = text),
    onListening: (isListening) {
      setState(() => this.isListening = isListening);


    },
  );
}