import 'package:flutter/material.dart';
import 'package:tcc/pages/authorized_persons.dart';
import 'package:tcc/pages/reserves_list.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double contPessoas = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: DrawerApp(),
      appBar: AppBar(
        backgroundColor: Config.dark_purple,
        title: Text(
          'Tela inicial',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
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
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Config.dark_purple),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.markunread_mailbox_outlined,
                          color: Config.orange,
                          size: 36,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            'Atualmente você não tem correspondência',
                            style: TextStyle(
                              color: Config.dark_purple,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Pessoas autorizadas ',
                  style: TextStyle(
                    color: Config.dark_purple,
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
                color: Config.dark_purple,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 90 * contPessoas,
                  child: ListView.builder(
                    itemCount: contPessoas.toInt(),
                    itemBuilder: (context, index) {
                      return _cardAutorizadas();
                    },
                  ),
                ),
              ),
              Divider(
                color: Config.dark_purple,
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

  Widget _cardAutorizadas() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Config.dark_purple,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Config.dark_purple,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline,
                      color: Config.dark_purple,
                      size: 36,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marcelo Zioli',
                      style: TextStyle(
                        color: Config.dark_purple,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Primo',
                      style: TextStyle(
                        color: Config.dark_purple,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardReserva() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
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
                color: Config.dark_purple,
              ),
              Row(
                children: [
                  _text('Local: ', 'Currasqueira'),
                  Spacer(),
                  _text('Bloco: ', 'B'),
                ],
              ),
              Row(
                children: [
                  _text('Início: ', '12/04/2024'),
                  Spacer(),
                  _text('Término: ', '12/04/2024'),
                ],
              ),
              _text('Convidados: ', '25'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(String label1, String label2) {
    return RichText(
      text: TextSpan(
        text: label1,
        style: TextStyle(
          color: Config.dark_purple,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: label2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
