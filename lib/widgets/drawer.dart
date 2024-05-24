import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/authorizedPersons.dart/authorizedPersons_list.dart';
import 'package:tcc/pages/chat/menu.dart';
import 'package:tcc/pages/report/report_menu.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/pages/correspondence.dart';
import 'package:tcc/pages/home.dart';
import 'package:tcc/pages/Profile/profile.dart';
import 'package:tcc/pages/reservations/reserves_list.dart';
import 'package:tcc/pages/rules.dart';
import 'package:tcc/teste.dart';
import 'package:tcc/widgets/config.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({super.key});

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  final ResidentStore store = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    List<String> aux = Config.resident.name.split(' ');
    String logoName = aux[0][0];
    logoName += aux[aux.length - 1][0];
    return Drawer(
      backgroundColor: Config.backgroundColor,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              Config.resident.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(Config.resident.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Config.backgroundColor,
              child: Text(
                logoName,
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
          ),
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
          ListTile(
            leading: Icon(
              Icons.warning_amber,
              color: Colors.green.shade600,
            ),
            title: Text(
              "*TESTE*",
              style: _textStyle(),
            ),
            onTap: () {
              initializeDateFormatting().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestePageWidget(),
                  ),
                );
              });
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
