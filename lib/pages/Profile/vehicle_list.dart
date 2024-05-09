import 'package:flutter/material.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/data/repositories/Vehicle_Repository.dart';
import 'package:tcc/data/stores/Vehicle_Store.dart';
import 'package:tcc/pages/Profile/vehicle_form.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/loading.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  VehicleStore store = VehicleStore(
    repository: VehicleRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _getVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([store.erro, store.isLoading, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return WidgetLoading.containerLoading();
          } else {
            return _body();
          }
        },
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: store.state.value.length,
          itemBuilder: (context, index) {
            return _vehicleCard(index);
          },
        ),
        (store.state.value.length == 4)
            ? Container()
            : InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VehicleForm(title: 'Cadastrar',),
                  ),
                ),
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
                      'Adicionar um novo veículo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _vehicleCard(int index) {
    IconData iconVehicle = Icons.drive_eta_outlined;
    if (store.state.value[index].type! == Config.typeVehicle[1]) {
      iconVehicle = Icons.motorcycle_outlined;
    } else if (store.state.value[index].type! == Config.typeVehicle[2]) {
      iconVehicle = Icons.pedal_bike_outlined;
    } else if (store.state.value[index].type! == Config.typeVehicle[3]) {
      iconVehicle = Icons.directions_bus_outlined;
    }

    return ListTile(
      contentPadding: EdgeInsets.all(10),
      title: Text(store.state.value[index].model!),
      subtitle: Text(store.state.value[index].plate!),
      leading: Icon(
        iconVehicle,
        size: 30,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VehicleForm(
            title: 'Editar',
            vehicle: store.state.value[index],
          ),
        ),
      ),
    );
  }

  void _getVehicles() {
    store.getVehicleByResident(Config.resident.id);
  }
}
