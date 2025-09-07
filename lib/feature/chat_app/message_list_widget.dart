part of 'chat_page.dart';

class MessageListWidget extends StatelessWidget {
  final List<Map<String, String>> messages;
  MessageListWidget({required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isBarbie = msg['sender'] == 'Barbie';

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          alignment: isBarbie ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: isBarbie ? Colors.pink[200] : Colors.blue[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isBarbie ? Radius.circular(12) : Radius.circular(0),
                bottomRight: isBarbie
                    ? Radius.circular(0)
                    : Radius.circular(12),
              ),
            ),
            child: Text(msg['message'] ?? '', style: TextStyle(fontSize: 16)),
          ),
        );
      },
    );
  }
}
