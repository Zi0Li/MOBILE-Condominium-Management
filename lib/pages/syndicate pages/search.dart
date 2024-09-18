import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/AuthorizedPersons_Repository.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/AuthorizedPersons_Store.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Resident? resident;
  var _searchController = new MaskedTextController(mask: '000.000.000-00');
  bool _search = false;

  ResidentStore residentStore = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  AuthorizedPersonsStore authorizedPersonsStore = AuthorizedPersonsStore(
    repository: AuthorizedPersonsRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _searchController.beforeChange = (String previous, String next) {
      if (next.length > 12) {
        if (_searchController.mask != '000.000.000-00')
          _searchController.updateMask('000.000.000-00');
      } else {
        if (_searchController.mask != '00.000.000-0')
          _searchController.updateMask('00.000.000-0');
      }
      return true;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      drawer: SyndicateDrawerApp(),
      appBar: AppBarWidget(
        title: 'Pesquisar',
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _inputSearch(),
            AnimatedBuilder(
              animation: Listenable.merge([
                residentStore.erro,
                residentStore.isLoading,
                authorizedPersonsStore.erro,
                authorizedPersonsStore.isLoading,
              ]),
              builder: (context, child) {
                if (residentStore.isLoading.value ||
                    authorizedPersonsStore.isLoading.value) {
                  return Center(
                    child: WidgetLoading.containerLoading(),
                  );
                } else if (resident != null) {
                  if (resident!.authorizedPersons!.isEmpty) {
                    return _cardResident(resident!);
                  } else {
                    return _cardAuthorizedPerson(resident!);
                  }
                } else {
                  if (_search) {
                    _search = false;
                    return Column(
                      children: [
                        Divider(),
                        _statusCard(false),
                        Divider(),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Nenhuma pesquisa realizada!',
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
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

  Widget _inputSearch() {
    Color color = Color.fromRGBO(233, 233, 233, 1);
    return Row(
      children: [
        Flexible(
          child: SizedBox(
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: TextFormField(
                controller: _searchController,
                style: TextStyle(fontSize: 14),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Digite cpf ou rg',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () => _getSearch(_searchController.text),
          icon: Icon(
            Icons.search,
            color: Config.white,
          ),
          style: IconButton.styleFrom(
            disabledBackgroundColor: Config.grey400,
            backgroundColor: Config.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardAuthorizedPerson(Resident resident) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        _statusCard(true),
        Divider(),
        Text(
          'Pessoa Autorizada',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("img/perfil.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resident.authorizedPersons!.first.name!,
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Divider(),
                    Config.text(
                        'CPF: ', resident.authorizedPersons!.first.cpf!, 18),
                    Config.text(
                        'RG: ', resident.authorizedPersons!.first.rg!, 18),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          'Referente ao morador',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage("img/perfil.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            resident.name!,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
          subtitle: Text(
            "${resident.block!} - ${resident.apt!}",
            style: TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _cardResident(Resident resident) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        _statusCard(true),
        Divider(),
        Text(
          'MORADOR',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("img/perfil.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resident.name!,
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Divider(),
                    Text(
                      "${resident.block} - ${resident.apt}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Divider(),
                    Config.text('CPF: ', resident.cpf!, 18),
                    Config.text('RG: ', resident.rg!, 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusCard(bool permission) {
    String text = 'Acesso liberado!';
    Color color = Config.green;
    IconData icon = Icons.check;
    if (!permission) {
      text = 'Acesso negado! Pessoa não encontrada.';
      color = Config.red;
      icon = Icons.close;
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Config.white,
            size: 30,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Config.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _getSearch(String? search) {
    resident = null;
    if (search!.isNotEmpty) {
      residentStore.getResidentSearch(search).then(
        (value) {
          if (value != null) {
            setState(() {
              resident = value;
            });
          } else {
            authorizedPersonsStore.getAuthorizedPersonsSearch(search).then(
              (value) {
                if (value != null) {
                  residentStore.erro.value = '';
                  resident = value;
                } else {
                  setState(() {
                    _search = true;
                  });
                }
              },
            );
          }
        },
      );
    } else {
      setState(() {
        resident = null;
      });
    }
    FocusScope.of(context).nextFocus();
    _searchController.clear();
  }
}
