import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Rules.dart';
import 'package:tcc/data/repositories/Rule_Repository.dart';
import 'package:tcc/data/stores/Rule_Store.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/loading.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';

class RulesSyndicatePage extends StatefulWidget {
  const RulesSyndicatePage({super.key});

  @override
  State<RulesSyndicatePage> createState() => _RulesSyndicatePageState();
}

class _RulesSyndicatePageState extends State<RulesSyndicatePage> {
  RuleStore store = RuleStore(
    repository: RuleRepository(
      client: HttpClient(),
    ),
  );

  Condominium _selectCondominium = Config.user.condominiums.first;
  List<Condominium> _condominiums = Config.user.condominiums;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  List<Rules> _rules = [];

  @override
  void initState() {
    super.initState();
    _getRulesByIdCondominium();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SyndicateDrawerApp(),
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: "Regras",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
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
                  _getRulesByIdCondominium();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: _showDialogCategory,
                    style: TextButton.styleFrom(
                      fixedSize: Size.fromHeight(52),
                      backgroundColor: Config.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Config.orange,
                      ),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Config.white,
                    ),
                    label: Text(
                      "Categoria",
                      style: TextStyle(
                        color: Config.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: Listenable.merge([
                  store.erro,
                  store.isLoading,
                  store.state,
                ]),
                builder: (context, child) {
                  if (store.isLoading.value) {
                    return WidgetLoading.containerLoading();
                  } else if (store.erro.value.isNotEmpty) {
                    return WidgetError.containerError(
                      store.erro.value,
                      () => setState(() => store.erro.value = ""),
                    );
                  } else {
                    if (store.state.value.isNotEmpty) {
                      return _body();
                    } else {
                      return Center(
                        child: Text('Nenhuma regra cadastrada'),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [],
        ),
        _rulesPanel(),
      ],
    );
  }

  Widget _rulesPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _rules[index].isExpanded = isExpanded;
        });
      },
      children: _rules.map<ExpansionPanel>((Rules rule) {
        return ExpansionPanel(
          backgroundColor: Config.white,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return GestureDetector(
              onLongPress: () {
                WidgetShowDialog.DeleteShowDialog(
                  context,
                  "a regra: ${rule.title}",
                  Icons.delete_forever_outlined,
                  () {
                    _delete(rule);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  rule.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < rule.content.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: "${i + 1} ",
                              style: TextStyle(
                                color: Config.grey_letter,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              children: [
                                TextSpan(
                                  text: rule.content[i],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            WidgetShowDialog.DeleteShowDialog(
                              context,
                              "a regra?",
                              Icons.delete_forever_outlined,
                              () {
                                rule.content.removeAt(i);

                                _updateContent(rule);
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Icon(
                            Icons.delete_outline,
                            color: Config.orange,
                          ),
                        )
                      ],
                    ),
                  ),
                GestureDetector(
                  onTap: () => _showDialogContent(rule),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Config.orange,
                      ),
                      SizedBox(
                        height: 50,
                        width: 8,
                      ),
                      Text(
                        'Adicionar regra',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isExpanded: rule.isExpanded,
        );
      }).toList(),
    );
  }

  Future<dynamic> _showDialogCategory() async {
    return await WidgetShowDialog.CustomShowDialog(
      context: context,
      text: "Adicionar uma categoria",
      body: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(child: Config.text("Condominio: ", _selectCondominium.name!, 18)),
          ],
        ),
        InputWidget(
          "Categoria",
          _titleController,
          TextInputType.text,
          Icons.title,
        )
      ],
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            fixedSize: Size(130, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Colors.black26),
            ),
          ),
          child: Text(
            'Voltar',
            style: TextStyle(fontSize: 18, color: Config.grey800),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            _createTitle();
            Navigator.pop(context);
            _titleController.clear();
          },
          style: TextButton.styleFrom(
            backgroundColor: Config.orange,
            fixedSize: Size(130, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Config.orange),
            ),
          ),
          child: Text(
            'Salvar',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )
      ],
    );
  }

  Future<dynamic> _showDialogContent(Rules rule) async {
    return await WidgetShowDialog.CustomShowDialog(
      context: context,
      text: "Adicionar uma regra",
      body: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(child: Config.text("Categoria: ", rule.title, 18)),
          ],
        ),
        InputWidget(
          "Regra",
          _contentController,
          TextInputType.text,
          Icons.rule,
          maxLine: 10,
        )
      ],
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            fixedSize: Size(130, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Colors.black26),
            ),
          ),
          child: Text(
            'Voltar',
            style: TextStyle(fontSize: 18, color: Config.grey800),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            rule.content.add(_contentController.text);
            _updateContent(rule);
            Navigator.pop(context);
            _contentController.clear();
          },
          style: TextButton.styleFrom(
            backgroundColor: Config.orange,
            fixedSize: Size(130, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Config.orange),
            ),
          ),
          child: Text(
            'Salvar',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )
      ],
    );
  }

  void _getRulesByIdCondominium() {
    store.findByIdCondominium(_selectCondominium.id!).then(
      (value) {
        setState(() {
          _rules = value;
        });
      },
    );
  }

  void _createTitle() {
    Map<String, dynamic> rule = {
      "title": _titleController.text,
      "content": [],
      "condominium": {"id": _selectCondominium.id}
    };

    store.create(rule);
  }

  void _updateContent(Rules rule) {
    Map<String, dynamic> _rule = {
      "id": rule.id,
      "title": rule.title,
      "content": rule.content,
      "condominium": {"id": _selectCondominium.id}
    };

    store.update(_rule);
  }

  void _delete(Rules rule) {
    store.delete(rule.id).then(
      (value) {
        if (value) {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "Regra(${rule.title}) deletada com sucesso!",
          );
          _getRulesByIdCondominium();
        } else {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "Ops. ocorreu um erro!",
            backgroundColor: Config.red,
            icon: Icons.close,
          );
        }
        Navigator.pop(context);
      },
    );
  }
}
