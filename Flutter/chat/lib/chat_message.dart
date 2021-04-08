import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> data;
  bool mine;
  ChatMessage(this.data, this.mine);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        children: [
          mine
              ? Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['senderPhotoUrl']),
                  ),
                )
              : Container(),
          Expanded(
              child: Column(
            crossAxisAlignment:
                mine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(data['senderName'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              data["texto"] != null
                  ? ListTile(
                      title: Text(
                      data["texto"],
                      textAlign: mine ? TextAlign.start : TextAlign.end,
                    ))
                  : Image.network(
                      data["url"],
                      width: 250.0,
                      height: 300.0,
                    ),
            ],
          )),
          !mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['senderPhotoUrl']),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
