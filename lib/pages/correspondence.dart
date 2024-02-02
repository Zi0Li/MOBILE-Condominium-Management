import 'package:flutter/material.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';

class CorrespondencePage extends StatefulWidget {
  const CorrespondencePage({super.key});

  @override
  State<CorrespondencePage> createState() => _CorrespondencePageState();
}

class _CorrespondencePageState extends State<CorrespondencePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: DrawerApp(),
        appBar: AppBarWidget(
          title: 'Correspondências',
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => _cardCorrespondence(),
          ),
        ));
  }

  Widget _cardCorrespondence() {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.5,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Config.grey400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                'img/correios.jpg',
                fit: BoxFit.fill,
                height: 130,
                width: 150,
              ),
              VerticalDivider(),
              Container(
                width: screenWidth * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Config.text(
                      'Remetente: ',
                      'Mercado livre',
                      16,
                    ),
                    Config.text(
                      'Local: ',
                      'Portaria',
                      16,
                    ),
                    Config.text(
                      'Entregue: ',
                      '12/04/2002',
                      16,
                    ),
                    Config.text(
                      'Chegou: ',
                      '12:34',
                      16,
                    ),
                    Config.text(
                      'Retirar: ',
                      '5 dias',
                      16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}