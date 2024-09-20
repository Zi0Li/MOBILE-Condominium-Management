import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/repositories/Notification_Repository.dart';
import 'package:tcc/data/stores/Notification_store.dart';
import 'package:tcc/pages/syndicate%20pages/notification/notification_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';

class NotitificationListPage extends StatefulWidget {
  const NotitificationListPage({super.key});

  @override
  State<NotitificationListPage> createState() => _NotitificationListPageState();
}

class _NotitificationListPageState extends State<NotitificationListPage> {
  NotificationStore store = NotificationStore(
    repository: NotificationRepository(
      client: HttpClient(),
    ),
  );

  Condominium _selectCondominium = Config.user.condominiums.first;
  List<Condominium> _condominiums = Config.user.condominiums;

  @override
  void initState() {
    super.initState();
    _getNotification(Config.user.condominiums.first.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      drawer: SyndicateDrawerApp(),
      appBar: AppBarWidget(
        title: "Notificações",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationFormPage(
                    condominium: _selectCondominium,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: Config.orange,
              size: 28,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<Condominium>(
              value: _selectCondominium,
              style: TextStyle(
                color: Config.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              onChanged: (Condominium? newValue) => setState(() {
                _selectCondominium = newValue!;
                _getNotification(_selectCondominium.id!);
              }),
              items: _condominiums
                  .map<DropdownMenuItem<Condominium>>(
                    (Condominium? value) => DropdownMenuItem<Condominium>(
                      value: value,
                      child: Text(value!.name!),
                    ),
                  )
                  .toList(),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 42,
              underline: SizedBox(),
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                store.erro,
                store.isLoading,
                store.state,
              ]),
              builder: (context, child) {
                if (store.isLoading.value) {
                  return Center(
                    child: WidgetLoading.containerLoading(),
                  );
                } else if (store.erro.value.isNotEmpty) {
                  return WidgetError.containerError(
                      store.erro.value, () => store.erro.value = '');
                } else {
                  if (store.state.value.isNotEmpty) {
                    return _body();
                  } else {
                    return Center(
                      child: Text('Nenhuma notificação cadastrada.'),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: store.state.value.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              WidgetShowDialog.DeleteShowDialog(
                context,
                "a notificação? ",
                Icons.delete,
                () => _deleteNotification(store.state.value[index].id!),
              );
            },
            title: Text(
              store.state.value[index].description!,
              style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
            ),
            subtitle: Text(store.state.value[index].category!),
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1, color: Config.grey400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.notifications_outlined,
                  color: Config.orange,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _getNotification(int id) {
    store.findAllByIdCondominium(id);
  }

  void _deleteNotification(int id) {
    store.delete(id).then(
      (value) {
        if (value) {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "Notificação foi deletada com sucesso!",
          );
          _getNotification(_selectCondominium.id!);
        } else {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            backgroundColor: Config.red,
            icon: Icons.close,
            mensage: "Ops! Ocorreu um erro, tente novamente.",
          );
        }
        Navigator.pop(context);
      },
    );
  }
}
