import 'package:flutter/material.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/input.dart';

class ReservesForm extends StatefulWidget {
  const ReservesForm({super.key});

  @override
  State<ReservesForm> createState() => _ReservesFormState();
}

class _ReservesFormState extends State<ReservesForm> {
  TextEditingController _nounController = TextEditingController();
  TextEditingController _dateStartController = TextEditingController();
  TextEditingController _dateEndController = TextEditingController();
  TextEditingController _guestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      drawer: DrawerApp(),
      appBar: AppBarWidget(title: 'Cadastrar reserva',),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            InputWidget(
              'Local',
              _nounController,
              TextInputType.text,
              Icons.location_on_outlined,
            ),
            InputWidget(
              'Convidados',
              _guestController,
              TextInputType.text,
              Icons.format_list_numbered_rounded,
            ),
            Row(
              children: [
                Flexible(
                  child: InputWidget(
                    'Data início',
                    _dateStartController,
                    TextInputType.text,
                    Icons.date_range_outlined,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: InputWidget(
                    'Data termino',
                    _dateEndController,
                    TextInputType.text,
                    Icons.date_range_outlined,
                  ),
                ),
              ],
            ),
            Divider(
              color: Config.dark_purple,
              height: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      fixedSize: Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Config.dark_purple,
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Config.dark_purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
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
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        color: Config.backgroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
