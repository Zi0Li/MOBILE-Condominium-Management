import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/resident%20pages/authorizedPersons/authorizedPersons_list.dart';
import 'package:tcc/pages/resident%20pages/chat/menu.dart';
import 'package:tcc/pages/resident%20pages/report/report_menu.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/pages/resident%20pages/correspondence.dart';
import 'package:tcc/pages/resident%20pages/resident_homepage.dart';
import 'package:tcc/pages/resident%20pages/Profile/profile.dart';
import 'package:tcc/pages/resident%20pages/reservations/reserves_list.dart';
import 'package:tcc/pages/resident%20pages/rules.dart';
import 'package:tcc/widgets/config.dart';

class ResidentDrawerApp extends StatefulWidget {
  const ResidentDrawerApp({super.key});

  @override
  State<ResidentDrawerApp> createState() => _ResidentDrawerAppState();
}

class _ResidentDrawerAppState extends State<ResidentDrawerApp> {
  final ResidentStore store = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Config.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              Config.user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(Config.user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Config.white,
              child: Text(
                Config.logoName(Config.user.name),
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
                  builder: (context) => ResidentHomePage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: Config.orange,
            ),
            title: Text(
              "Perfil",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
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
                  builder: (context) => AuthorizedPersonsListPage(),
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
              "Chat",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuChatPage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.mark_as_unread_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Correspondências",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CorrespondencePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.rule_rounded,
              color: Config.orange,
            ),
            title: Text(
              "Regras",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RulesPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.library_books_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Reportar",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportMenuPage(),
                ),
              );
            },
          ),
          Divider(),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ),
              );
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
      fontWeight: FontWeight.w400,
    );
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
