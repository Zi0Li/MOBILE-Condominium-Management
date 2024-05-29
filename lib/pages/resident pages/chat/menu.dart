import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/resident%20pages/chat/chat.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class MenuChatPage extends StatefulWidget {
  const MenuChatPage({super.key});

  @override
  State<MenuChatPage> createState() => _MenuChatPageState();
}

class _MenuChatPageState extends State<MenuChatPage> {
  @override
  void initState() {
    super.initState();
    _getAllNeighbors();
  }

  ResidentStore store = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  int contNeighbors = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Chat',
      ),
      body: AnimatedBuilder(
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
            return _body();
          }
        },
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: contNeighbors,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  name:  store.state.value[index].name!,
                  apto: "${store.state.value[index].block!}-${store.state.value[index].apt!}",
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
                  store.state.value[index].name!,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("${store.state.value[index].block!}-${store.state.value[index].apt!}")
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
      },
    );
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
          Text(
            'Ausente',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
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
          Text(
            'Online',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      );
    }
  }

  List<int> teste = [1, 0, 2, 0, 1];

  void _getAllNeighbors() {
    store
        .getAllNeighbors(Config.resident.id)
        .then((value){
          setState(() {
            contNeighbors = store.state.value.length;
          }); 
        });
  }
}
