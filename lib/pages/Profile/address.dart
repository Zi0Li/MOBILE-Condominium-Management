import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Config.text('Nome: ', 'Condomínio Terra de Santa Cruz', 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Config.text('Rua: ', 'Rio Claro', 18),
            Config.text('N°: ', '10', 18),
          ],
        ),
        Config.text('Bairro: ', 'Vila Progresso', 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Config.text('Estado: ', 'SP', 18),
            Config.text('Cidade: ', 'Assis', 18),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Config.text('Bloco: ', Config.resident.block, 18),
            Config.text('Apartamento: ', Config.resident.apt, 18),
          ],
        ),
        SizedBox(height: 30),
        Row(
          children: [
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
                    color: Config.grey400,
                  ),
                ),
                child: Text(
                  'Compartilhar localização',
                  style: TextStyle(
                    color: Config.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}