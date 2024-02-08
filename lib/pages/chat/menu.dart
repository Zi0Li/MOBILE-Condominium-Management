import 'package:flutter/material.dart';
import 'package:tcc/pages/chat/chat.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class MenuChatPage extends StatefulWidget {
  const MenuChatPage({super.key});

  @override
  State<MenuChatPage> createState() => _MenuChatPageState();
}

class _MenuChatPageState extends State<MenuChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Chat',
      ),
      body: ListView.builder(
        itemCount: Config.Apartment.length,
        itemBuilder: (context, index) => _card(index),
      ),
    );
  }

  Widget _card(int index) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              name: 'Nome do morador: ${index + 1}',
              apto: "K-${Config.Apartment[index]}",
              status: _status(teste[index]),
            ),
          ),
        );
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Nome do morador: ${index + 1}',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text("K-${Config.Apartment[index]}")
        ],
      ),
      subtitle: _status(teste[index]),
      leading: Container(
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
      ),
    );
  }
}

Widget _status(int status) {
  if (status == 1) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Config.red,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Ocupado',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  } else if (status == 2) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Config.amber,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text('Ausente', style: TextStyle(
            fontSize: 13,
          ),),
      ],
    );
  } else {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Config.green,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text('Online', style: TextStyle(
            fontSize: 13,
          ),),
      ],
    );
  }
}

List<int> teste = [1, 1, 2, 0, 1, 2, 1, 0, 2, 0, 0, 2, 0, 1, 0, 2];
