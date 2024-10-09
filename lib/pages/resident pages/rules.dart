import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/models/Rules.dart';
import 'package:tcc/data/repositories/Rule_Repository.dart';
import 'package:tcc/data/stores/Rule_Store.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/error.dart';
import 'package:tcc/widgets/loading.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  RuleStore store = RuleStore(
    repository: RuleRepository(
      client: HttpClient(),
    ),
  );

  bool expanded = true;

  List<Rules> _rules = [];

  @override
  void initState() {
    super.initState();
    _getRulesByIdCondominium();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: 'Regras',
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([store.erro, store.isLoading, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (store.erro.value.isNotEmpty) {
            return Center(
              child: WidgetError.containerError(
                store.erro.value,
                () => setState(() {
                  store.erro.value = '';
                }),
              ),
            );
          } else {
            if (_rules.isNotEmpty) {
              return _rulesPanel();
            } else {
              return Center(
                child: Text('Sem nenhuma regra cadastrada!'),
              );
            }
          }
        },
      ),
    );
  }

  Widget _rulesPanel() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _rules[index].isExpanded = isExpanded;
              });
            },
            children: _rules.map<ExpansionPanel>((Rules rules) {
              return ExpansionPanel(
                backgroundColor: Config.white,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      rules.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
                      for (int i = 0; i < rules.content.length; i++)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: null,
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    text: "${rules.id}.${i + 1} ",
                                    style: TextStyle(
                                      color: Config.grey_letter,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: rules.content[i],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                isExpanded: rules.isExpanded,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _getRulesByIdCondominium() {
    store.findByIdCondominium(Config.user.condominium.id!).then(
      (value) {
        setState(() {
          _rules = value;
        });
      },
    );
  }
}
