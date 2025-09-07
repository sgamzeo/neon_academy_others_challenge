import 'package:flutter/material.dart';
import 'package:neon_others_challenge/core/services/message_service.dart';

part 'message_list_widget.dart';
part 'message_input_widget.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final MessageService _service = MessageService();
  List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  void loadMessages() async {
    final fetched = await _service.fetchMessages();
    setState(() {
      messages = fetched;
    });
  }

  void handleSend(String sender, String message) async {
    final success = await _service.sendMessage(sender, message);
    if (success) {
      setState(() {
        messages.add({'sender': sender, 'message': message});
      });
    } else {
      print('Mesaj gönderilemedi.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barbie & Ken Chat')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: MessageListWidget(messages: messages)),
            MessageInputWidget(onSend: handleSend),
          ],
        ),
      ),
    );
  }
}
