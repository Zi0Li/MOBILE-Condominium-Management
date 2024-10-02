import 'package:flutter/material.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class ResidentViewPage extends StatefulWidget {
  final Resident resident;
  const ResidentViewPage({required this.resident, super.key});

  @override
  State<ResidentViewPage> createState() => _ResidentViewPageState();
}

class _ResidentViewPageState extends State<ResidentViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: 'Morador',
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 200,
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
                          widget.resident.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                          ),
                        ),
                        Config.text('Email: ', widget.resident.email!, 18),
                        Config.text('Telefone: ', widget.resident.phone!, 18),
                        Config.text('CPF: ', widget.resident.cpf!, 18),
                        Config.text('RG: ', widget.resident.rg!, 18),
                        Config.text('Bloco: ', widget.resident.block!, 18),
                        Config.text('Aparatamento: ', widget.resident.apt!, 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 28,
                  color: Config.orange,
                ),
                Text(
                  'Pessoas Autorizadas',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.resident.authorizedPersons!.length,
              itemBuilder: (context, index) {
                return _authorizedPersonsCard(index);
              },
            ),
            Divider(),
            Row(
              children: [
                Icon(
                  Icons.drive_eta_outlined,
                  size: 28,
                  color: Config.orange,
                ),
                Text(
                  'Veículos',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.resident.vehicle!.length,
              itemBuilder: (context, index) {
                return _vehicleCard(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _authorizedPersonsCard(int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(5),
      title: Text(widget.resident.authorizedPersons![index].name!),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.resident.authorizedPersons![index].kinship!),
          Text(widget.resident.authorizedPersons![index].phone!),
        ],
      ),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage("img/perfil.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _vehicleCard(int index) {
    IconData iconVehicle = Icons.drive_eta_outlined;
    if (widget.resident.vehicle![index].type! == Config.typeVehicle[1]) {
      iconVehicle = Icons.motorcycle_outlined;
    } else if (widget.resident.vehicle![index].type! == Config.typeVehicle[2]) {
      iconVehicle = Icons.pedal_bike_outlined;
    } else if (widget.resident.vehicle![index].type! == Config.typeVehicle[3]) {
      iconVehicle = Icons.directions_bus_outlined;
    }

    return ListTile(
      contentPadding: EdgeInsets.all(10),
      title: Text(widget.resident.vehicle![index].model!),
      subtitle: Text(widget.resident.vehicle![index].plate!),
      leading: Icon(
        iconVehicle,
        size: 30,
      ),
    );
  }
}
