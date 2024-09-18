// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class ChatPage extends StatefulWidget {
  String? name;
  String? apto;
  Widget? status;

  ChatPage(
      {required this.name,
      required this.apto,
      required this.status,
      super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBar(
        toolbarHeight: 56,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.apto!,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
        leadingWidth: 90,
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Config.grey400,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Config.grey400,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person_outline,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.name!,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Config.orange,
                fontSize: 18,
              ),
            ),
            widget.status!
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Mensagem',
                      hintStyle: TextStyle(
                        color: Config.grey600,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Config.grey400,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Config.grey400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_rounded,
                    size: 30,
                    color: Config.orange,
                  ),
                  style: IconButton.styleFrom(
                    fixedSize: Size(55, 55),
                    side: BorderSide(width: 1, color: Config.grey400)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
