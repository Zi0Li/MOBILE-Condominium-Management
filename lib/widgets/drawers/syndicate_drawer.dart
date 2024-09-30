import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/pages/syndicate%20pages/notification/notification_list.dart';
import 'package:tcc/pages/syndicate%20pages/condominiums/condominiums_list.dart';
import 'package:tcc/pages/syndicate%20pages/correspondence/correspondence_list.dart';
import 'package:tcc/pages/syndicate%20pages/employee/employee_list.dart';
import 'package:tcc/pages/syndicate%20pages/kiosk/kiosk_list.dart';
import 'package:tcc/pages/syndicate%20pages/report/report_list.dart';
import 'package:tcc/pages/syndicate%20pages/resident/resident_list.dart';
import 'package:tcc/pages/syndicate%20pages/rules/rules.dart';
import 'package:tcc/pages/syndicate%20pages/search.dart';
import 'package:tcc/pages/syndicate%20pages/syndicate_homepage.dart';
import 'package:tcc/widgets/config.dart';

class SyndicateDrawerApp extends StatefulWidget {
  const SyndicateDrawerApp({super.key});

  @override
  State<SyndicateDrawerApp> createState() => _SyndicateDrawerAppState();
}

class _SyndicateDrawerAppState extends State<SyndicateDrawerApp> {
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
                  builder: (context) => SyndicateHomePage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Config.orange,
            ),
            title: Text(
              "Buscar pessoas",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.home_work_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Condomínios",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CondominiumsList(),
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
              "Areas de lazer",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KioskListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_emergency_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Funcionários",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeListPage(),
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
              "Moradores",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResidentListPage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.rule,
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
                  builder: (context) => RulesSyndicatePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notification_important_outlined,
              color: Config.orange,
            ),
            title: Text(
              "Notificações",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotitificationListPage(),
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
              "Reportes/Tickets",
              style: _textStyle(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportListPage(),
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
                  builder: (context) => CorrespondenceListPage(),
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
