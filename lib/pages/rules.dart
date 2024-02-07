import 'package:flutter/material.dart';
import 'package:tcc/data/models/Rules.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  bool expanded = true;

  List<Rules> _rules = gerarRegras(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Regras',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_buildPanel()],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _rules[index].isExpanded = isExpanded;
        });
      },
      children: _rules.map<ExpansionPanel>((Rules rules) {
        return ExpansionPanel(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
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
                      )
                    ],
                  ),
              ],
            ),
          ),
          isExpanded: rules.isExpanded,
        );
      }).toList(),
    );
  }
}
