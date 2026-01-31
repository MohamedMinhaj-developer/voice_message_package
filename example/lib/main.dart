import 'dart:developer';
import 'package:voice_note_kit/voice_note_kit.dart';

import 'package:animated_chat_record_button/test.dart';
import 'package:animated_chat_record_button/voice_message_bubble.dart';
import 'package:flutter/material.dart';

import 'package:animated_chat_record_button/animated_chat_record_button.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? filePathW;
  String? message;
  bool isRecording = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffeee5dc),
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              bottom: 70, // Leaves space for the input/record button
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  spacing: 5,
                  children: [
                    VoiceMessageBubble(voiceUrl: filePathW ?? '', isMe: true),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[500],
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            spacing: 5,
                            children: [
                              Text(
                                'message : $message',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                'record path : $filePathW',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
              child: AudioPlayerWidget(
                // key: ValueKey('${widget.message.id}_audio'),
                audioPath: filePathW,
                audioType: AudioType.directFile,
                playerStyle: PlayerStyle.style5,
                textDirection: TextDirection.rtl,
                // backgroundColor: widget.isMe
                //     ? Theme.of(context)
                //         .colorScheme
                //         .primary
                //         .withValues(alpha: 0.1)
                //     : Colors.grey.shade100,
                iconColor: Colors.white,
                // iconColor: widget.isMe
                //     ? Theme.of(context).colorScheme.primary
                //     : Colors.grey.shade700,
                progressBarBackgroundColor: Colors.white,
                // progressBarBackgroundColor: widget.isMe
                //     ? Theme.of(context).colorScheme.primary
                //     : Colors.grey.shade400,
                width: 250,
                size: 40,
                showSpeedControl: true,
                showTimer: true,
                autoLoad: true,
                autoPlay: false,
              ),
            ),
            AnimatedChatRecordButton(
              config: RecordButtonConfig(
                recordButtonSize: 45,
              ),
              onPressEmoji: () {
                log('Emoji button pressed');
              },
              onPressCamera: () {
                log('Camera button pressed');
              },
              onPressAttachment: () {
                log('Attachment button pressed');
              },
              onSend: (text) {
                setState(() {
                  message = text;
                  log('Message sent: $message');
                });
              },
              onLockedRecording: (doesLocked) {
                log('Locked recording: $doesLocked');
                setState(() {
                  isRecording = doesLocked;
                });
              },
              textEditingController: textEditingController,
              onRecordingEnd: (filePath) {
                setState(() {
                  filePathW = filePath?.path;
                  log('from plugin test ${filePathW.toString()}');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
