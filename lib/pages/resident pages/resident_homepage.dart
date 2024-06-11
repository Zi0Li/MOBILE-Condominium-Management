import 'package:flutter/material.dart';
import 'package:tcc/data/controllers/Login_Controller.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/AuthorizedPersons.dart';
import 'package:tcc/data/repositories/AuthorizedPersons_Repository.dart';
import 'package:tcc/data/repositories/Reservation_Repository.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/AuthorizedPersons_Store.dart';
import 'package:tcc/data/stores/Reservation_Store.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/acesss/welcome.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/resident_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/reservation_card.dart';

class ResidentHomePage extends StatefulWidget {
  const ResidentHomePage({super.key});

  @override
  State<ResidentHomePage> createState() => _ResidentHomePageState();
}

class _ResidentHomePageState extends State<ResidentHomePage> {
  final ResidentStore residentStore = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  final AuthorizedPersonsStore authorizedPersonsStore = AuthorizedPersonsStore(
    repository: AuthorizedPersonsRepository(
      client: HttpClient(),
    ),
  );

  final ReservationStore reservationStore = ReservationStore(
    repository: ReservationRepository(
      client: HttpClient(),
    ),
  );

  int contAuthorizedPersons = 0;

  @override
  void initState() {
    super.initState();
    _getResident();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: ResidentDrawerApp(),
      appBar: AppBar(
        backgroundColor: Config.backgroundColor,
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
          animation: Listenable.merge([
            residentStore.erro,
            residentStore.isLoading,
            residentStore.state,
          ]),
          builder: (context, child) {
            if (residentStore.isLoading.value) {
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
                      text: '${authorizedPersonsStore.state.value.length}/4',
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
              AnimatedBuilder(
                animation: Listenable.merge([
                  authorizedPersonsStore.erro,
                  authorizedPersonsStore.isLoading,
                  authorizedPersonsStore.state,
                ]),
                builder: (context, child) {
                  if (authorizedPersonsStore.isLoading.value) {
                    return Center(
                      child: WidgetLoading.containerLoading(),
                    );
                  } else if (authorizedPersonsStore.erro.value.isNotEmpty) {
                    return WidgetError.containerError(
                        authorizedPersonsStore.erro.value,
                        () => authorizedPersonsStore.erro.value = '');
                  } else {
                    if (authorizedPersonsStore.state.value.isNotEmpty) {
                      return _cardAutorizadas(
                          authorizedPersonsStore.state.value);
                    } else {
                      return _isEmpty('Nenhuma pessoa autorizada cadastra!');
                    }
                  }
                },
              ),
              Divider(
                color: Config.grey400,
              ),
              Text(
                'Próxima reserva',
                style: TextStyle(
                  color: Config.grey_letter,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AnimatedBuilder(
                animation: Listenable.merge([
                  reservationStore.erro,
                  reservationStore.isLoading,
                  reservationStore.stateDTO,
                ]),
                builder: (context, child) {
                  if (reservationStore.isLoading.value) {
                    return Center(
                      child: WidgetLoading.containerLoading(),
                    );
                  } else if (reservationStore.erro.value.isNotEmpty) {
                    return WidgetError.containerError(
                        reservationStore.erro.value,
                        () => reservationStore.erro.value = '');
                  } else {
                    if (reservationStore.stateDTO.value.isNotEmpty) {
                      return ReservationCard(
                          reservationAndKioskDTO:
                              reservationStore.stateDTO.value.first);
                    } else {
                      return _isEmpty('Nenhuma reserva feita!');
                    }
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardAutorizadas(List<AuthorizedPersons> authorizedPersons) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: authorizedPersons.length,
        itemBuilder: (context, index) {
          

          return ListTile(
            onLongPress: () {},
            title: Text(
              authorizedPersons[index].name!,
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
                  Config.logoName(authorizedPersons[index].name!).toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            subtitle: Text(authorizedPersons[index].kinship!),
          );
        },
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

  void _getResident() {
    residentStore.isLoading.value = true;
    LoginController.internal().getAllLogins().then((value) {
      if (value.isNotEmpty) {
        residentStore.getResident(value.first.id).then((residents) {
          Config.user = residentStore.state.value.first;
          _getAuthorizationPerons();
          _getReservation();
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

  void _getAuthorizationPerons() {
    authorizedPersonsStore
        .getAuthorizedPersonsByResident(Config.user.id)
        .then(
          (authorizedPersons) =>
              setState(() => contAuthorizedPersons = authorizedPersons.length),
        );
  }

  void _getReservation() {
    reservationStore.getReservationByResident(Config.user.id);
  }

  Widget _isEmpty(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Config.grey_letter,
          fontSize: 16,
        ),
      ),
    );
  }
}
