import 'dart:convert';

import 'package:chatgpt/model/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'chatMessage.dart';
import 'model/chatMessageModel.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late bool isLoading;
  TextEditingController _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessages> _messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  Future<String> generateResponse(String prompt) async {
    const apiKey = apiSecretKey;

    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $apiKey"
      },
      body: json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    // Do something with the response
    Map<String, dynamic> newresponse = jsonDecode(response.body);

    return newresponse['choices'][0]['text'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Chat AI",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(child: _buildList()),
          Visibility(
            visible: isLoading,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            cursorColor: Colors.white,
            controller: _textController,
            style: GoogleFonts.openSans(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                fillColor: Colors.black26,
                disabledBorder: InputBorder.none,
                filled: true,
                focusedBorder: InputBorder.none,
                hintText: "Type Here...",
                hintStyle: TextStyle(
                  color: Colors.white70,
                ),
                suffixIcon: _submit()),
          )
        ],
      ),
      backgroundColor: Colors.black,
    ));
  }

  Widget _submit() {
    return Visibility(
      visible: !isLoading,
      child: IconButton(
          onPressed: () {
            //display user response
            setState(() {
              _messages.add(ChatMessages(
                  text: _textController.text,
                  chatMessageType: ChatMessageType.user));
              isLoading = true;
            });
            var input = _textController.text;
            _textController.clear();
            Future.delayed(Duration(milliseconds: 50))
                .then((value) => _scrollDown());

            //call chat bot
            generateResponse(input).then((value) => setState(() {
                  isLoading = false;
                  _messages.add(ChatMessages(
                      text: value, chatMessageType: ChatMessageType.bot));
                }));
            _textController.clear();
            Future.delayed(Duration(milliseconds: 50))
                .then((value) => _scrollDown());
          },
          icon: Icon(
            Icons.send,
            color: Colors.white54,
          )),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200), curve: Curves.easeOut);
  }

  ListView _buildList() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          var message = _messages[index];
          return ChatMessageWidget(
              text: message.text, chatMessageType: message.chatMessageType);
        });
  }
}
