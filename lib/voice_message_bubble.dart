import 'package:animated_chat_record_button/test.dart';
import 'package:flutter/material.dart';
import 'package:voice_note_kit/voice_note_kit.dart';
// import 'package:voice_note_kit/voice_note_kit.dart';

/// Widget for displaying a voice message bubble using voice_note_kit
/// Wrapper prevents setState after dispose crash from voice_note_kit package bug
class VoiceMessageBubble extends StatefulWidget {
  final bool isMe;
  final String voiceUrl;

  const VoiceMessageBubble({
    super.key,
    required this.voiceUrl,
    required this.isMe,
  });

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  @override
  Widget build(BuildContext context) {
    // debugPrint('VoiceMessageBubble built ${widget.message.voiceUrl!}');

    // final voiceUrl = widget.message.voiceUrl;
    // if (voiceUrl == null) {
    //   return const SizedBox.shrink();
    // }

    // Detect if it's a local file or a URL
    // final isLocal = !voiceUrl.startsWith('http') && !voiceUrl.startsWith('https');

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      // child: player(
      //   audioSrc: widget.voiceUrl,
      // ),
      child: AudioPlayerWidget(
        // key: ValueKey('${widget.message.id}_audio'),
        audioPath: widget.voiceUrl,
        // audioType: AudioType.directFile,
        // playerStyle: PlayerStyle.style5,
        textDirection: TextDirection.rtl,
        backgroundColor: widget.isMe
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
            : Colors.grey.shade100,
        iconColor: Colors.white,
        // iconColor: widget.isMe
        //     ? Theme.of(context).colorScheme.primary
        //     : Colors.grey.shade700,
        progressBarBackgroundColor: Colors.white,
        // progressBarBackgroundColor: widget.isMe
        //     ? Theme.of(context).colorScheme.s
        //     : Colors.grey.shade400,
        width: 250,
        size: 40,
        showSpeedControl: true,
        showTimer: true,
        autoLoad: true,
        autoPlay: false,
      ),
    );
  }
}
