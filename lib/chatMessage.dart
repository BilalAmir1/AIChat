import 'package:chatgpt/model/chatMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  final String boticon = 'assets/boticon.svg';

  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(8),
      color: chatMessageType == ChatMessageType.bot
          ? Color(0xff333333)
          : Colors.black26,
      child: Row(
        children: [
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(16, 163, 127, 1),
                    foregroundColor: Colors.black,
                    child: FaIcon(FontAwesomeIcons.robot),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    child: FaIcon(FontAwesomeIcons.userLarge),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
          Expanded(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  text,
                  textDirection: TextDirection.ltr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget botIcon() {
    return SvgPicture.asset(boticon, color: Colors.white);
  }

  final String lottieIcon = "https://lottiefiles.com/99973-little-power-robot";
}
