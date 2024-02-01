import 'package:flutter/material.dart';
import 'package:tcc/pages/authorized_persons.dart';
import 'package:tcc/pages/home.dart';
import 'package:tcc/pages/reserves_list.dart';
import 'package:tcc/widgets/config.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({super.key});

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Config.white_background,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Marcelo Zioli', style: TextStyle(fontWeight: FontWeight.bold,),),
            accountEmail: Text('marceloaezioli@hotmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Config.white_background,
              child: Text(
                "MZ",
                style: TextStyle(
                  color: Config.grey_letter,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Config.orange),
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Tela inicial",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),ListTile(
            leading: Icon(
              Icons.person_outline,
              color: Config.orange,
            ),
            title: Text(
              "* Perfil",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              _semPagina(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Pessoas autorizadas",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorizedPersonsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.outdoor_grill_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Areas de lazer/Reservas",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservesList(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.chat_outlined,
              color: Config.orange,
            ),
            title: Text(
              "* Chat",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              _semPagina(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.mark_as_unread_outlined,
              color: Config.orange,
            ),
            title: Text(
              "* Correspondências",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              _semPagina(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.rule_rounded,
              color: Config.orange,
            ),
            title: Text(
              "* Regras",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              _semPagina(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.library_books_outlined,
              color: Config.orange,
            ),
            title: Text(
              "* Ticket/Boletim",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              _semPagina(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.red,
            ),
            title: Text(
              "Sair",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              _semPagina(context);
            },
          ),
        ],
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
        fontSize: 16,
        color: Config.grey_letter,
        fontWeight: FontWeight.w400);
  }

  Future _semPagina(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 36,
        ),
        title: Text(
          'Pagina indisponível!',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
