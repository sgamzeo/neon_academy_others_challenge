part of 'chat_page.dart';

class MessageInputWidget extends StatefulWidget {
  final Function(String sender, String message) onSend;

  const MessageInputWidget({super.key, required this.onSend});

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  final _controller = TextEditingController();
  String sender = 'Barbie';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: sender,
                items: ['Barbie', 'Ken']
                    .map(
                      (name) => DropdownMenuItem(
                        value: name,
                        child: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => sender = val);
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: (msg) {
                final text = msg.trim();
                if (text.isNotEmpty) {
                  widget.onSend(sender, text);
                  _controller.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.pinkAccent,
            shape: const CircleBorder(),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                final msg = _controller.text.trim();
                if (msg.isNotEmpty) {
                  widget.onSend(sender, msg);
                  _controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
