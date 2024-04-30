// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  final dynamic entity;
  HomePage({this.entity, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double contPessoas = 4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.entity);
    print(widget.entity.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white_background,
      drawer: DrawerApp(),
      appBar: AppBar(
        backgroundColor: Config.white_background,
        toolbarHeight: 56,
        title: Text(
          'Tela inicial',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Config.orange,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardNotification(
                'Atualmente você não tem correspondência',
                Icons.markunread_mailbox_outlined,
              ),
              SizedBox(
                height: 10,
              ),
              _cardNotification(
                'Você não tem nenhuma notificação',
                Icons.notifications_none_outlined,
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Pessoas autorizadas ',
                  style: TextStyle(
                    color: Config.grey_letter,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: '${contPessoas.toInt()}/4',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Config.grey400,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contPessoas.toInt(),
                  itemBuilder: (context, index) {
                    return _cardAutorizadas(widget.entity.name, index);
                  },
                ),
              ),
              Divider(
                color: Config.grey400,
              ),
              SizedBox(
                height: 10,
              ),
              _cardReserva(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(IconData icon, String label, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 150,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Config.dark_purple,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: Config.orange,
              ),
              SizedBox(height: 5),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Config.dark_purple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardAutorizadas(String name, int index) {
    List<String> aux = name.split(' ');
    String logoName = aux[0][0];
    logoName += aux[aux.length - 1][0];

    return ListTile(
      onLongPress: () {
        print('Clicou: $index');
      },
      title: Text(
        name,
        style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
      ),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Config.grey400),
        ),
        child: Center(
          child: Text(
            logoName.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
      subtitle: Text('Parentesco'),
    );
  }

  Widget _cardReserva() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Config.grey600,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Próxima reserva',
                style: TextStyle(
                  color: Config.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              Divider(
                color: Config.grey400,
              ),
              Row(
                children: [
                  Config.text('Local: ', 'Currasqueira', 16),
                  Spacer(),
                  Config.text('Bloco: ', 'B', 16),
                ],
              ),
              Row(
                children: [
                  Config.text('Início: ', '12/04/2024', 16),
                  Spacer(),
                  Config.text('Término: ', '12/04/2024', 16),
                ],
              ),
              Config.text('Convidados: ', '25', 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardNotification(String title, IconData icon) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Config.grey600,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                color: Config.orange,
                size: 36,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Config.grey_letter,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
