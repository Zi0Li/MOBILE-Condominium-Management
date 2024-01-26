import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Config.dark_purple,
        title: Text(
          'Registrar reserva',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // InputWidget('Local', _nounController, TextInputType.text),
            // InputWidget('Convidados', _guestController, TextInputType.text),
            Row(
              children: [
                // Flexible(
                //   child: InputWidget(
                //       'Data início', _dateStartController, TextInputType.text),
                // ),
                // SizedBox(
                //   width: 20,
                // ),
                // Flexible(
                //   child: InputWidget(
                //       'Data termino', _dateEndController, TextInputType.text),
                // ),
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
