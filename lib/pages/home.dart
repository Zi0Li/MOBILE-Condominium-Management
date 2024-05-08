import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Login_Controller.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/reservation_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ResidentStore store = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  int? contAuthorizedPersons;

  @override
  void initState() {
    super.initState();
    _getResident();
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
      body: Center(
        child: AnimatedBuilder(
          animation:
              Listenable.merge([store.erro, store.isLoading, store.state]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return WidgetLoading.containerLoading();
            } else {
              return _body();
            }
          },
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      text: '${contAuthorizedPersons}/4',
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
                  itemCount: contAuthorizedPersons,
                  itemBuilder: (context, index) {
                    return _cardAutorizadas(
                        store.state.value[0].authorizedPersons![index]);
                  },
                ),
              ),
              Divider(
                color: Config.grey400,
              ),
              SizedBox(
                height: 10,
              ),
              //ReservationCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardAutorizadas(AuthorizedPersons authorizedPerson) {
    List<String> aux = authorizedPerson.name!.split(' ');
    String logoName = aux[0][0];
    logoName += aux[aux.length - 1][0];

    return ListTile(
      onLongPress: () {},
      title: Text(
        authorizedPerson.name!,
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
      subtitle: Text(authorizedPerson.kinship!),
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

  void _getResident() {
    store.isLoading.value = true;
    LoginController.internal().getAllLogins().then((value) {
      if (value.isNotEmpty) {
        store.getResident(value[0].id).then((residents) {
          print(residents);
          contAuthorizedPersons =
              store.state.value[0].authorizedPersons!.length;
          Config.resident = store.state.value[0];
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ),
        );
      }
    });
  }
}
