import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/pages/home.dart';
import 'package:tcc/pages/vehicle_form.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/input.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Controller Profile
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _bithController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  String dropdownBlock = 'K';
  String dropdownApartament = Config.Apartment[0];
  String? _img;

  List<IconData> iconListButton = [
    Icons.person_outline,
    Icons.drive_eta_outlined,
    Icons.location_on_outlined,
  ];

  int selectButton = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Perfil',
      ),
      drawer: DrawerApp(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      ImagePicker()
                          .pickImage(source: ImageSource.camera)
                          .then((file) {
                        if (file == null) {
                          return;
                        } else {
                          setState(() {
                            _img = file.path;
                          });
                        }
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Config.grey400,
                        border: Border.all(
                          width: 1,
                          color: Config.grey400,
                        ),
                      ),
                      child: Center(
                        child: _img == null
                            ? Icon(
                                Icons.person,
                                size: 40,
                                color: Config.black,
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(
                                        _img!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marcelo A. Erreiro Zioli',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Config.grey_letter,
                        ),
                      ),
                      Text(
                        "K - 303",
                        style: TextStyle(
                          fontSize: 14,
                          color: Config.grey600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: iconListButton.length,
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    return Center(child: _button(iconListButton[index], index));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _body(selectButton),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(int index) {
    if (index == 0) {
      return _personBody();
    } else if (index == 1) {
      return _vehicleBody();
    } else {
      return _addressBody();
    }
  }

  Widget _vehicleBody() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: Config.typeVehicle.length,
      itemBuilder: (context, index) => _vehicleCard(index),
    );
  }

  Widget _vehicleCard(int index) {
    IconData iconVehicle = Icons.drive_eta_outlined;
    if (Config.typeVehicle[index] == Config.typeVehicle[1]) {
      iconVehicle = Icons.motorcycle_outlined;
    } else if (Config.typeVehicle[index] == Config.typeVehicle[2]) {
      iconVehicle = Icons.pedal_bike_outlined;
    } else if (Config.typeVehicle[index] == Config.typeVehicle[3]) {
      iconVehicle = Icons.directions_bus_outlined;
    }

    return ListTile(
      contentPadding: EdgeInsets.all(10),
      title: Text("Veiculo Name $index"),
      subtitle: Text(Config.typeVehicle[index]),
      leading: Icon(
        iconVehicle,
        size: 30,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VehicleForm(
            typeVehicle: Config.typeVehicle[index],
          ),
        ),
      ),
    );
  }

  Widget _addressBody() {
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
            Config.text('Bloco: ', dropdownBlock, 18),
            Config.text('Apartamento: ', dropdownApartament, 18),
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

  Widget _personBody() {
    return Column(
      children: [
        InputWidget(
          'Nome',
          _nicknameController,
          TextInputType.text,
          Icons.person_outline_rounded,
        ),
        InputWidget("Telefone", _numberController, TextInputType.number,
            Icons.phone_android_outlined),
        InputWidget('E-mail', _bithController, TextInputType.number,
            Icons.email_outlined),
        InputWidget(
          'Rg',
          _rgController,
          TextInputType.number,
          Icons.wallet_rounded,
        ),
        InputWidget(
          'Cpf',
          _cpfController,
          TextInputType.number,
          Icons.description_outlined,
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  fixedSize: Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Config.grey400,
                  ),
                ),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Config.black,
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
                    color: Config.grey400,
                  ),
                ),
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    color: Config.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _button(IconData icon, int index) {
    Color colorButton = Config.white;
    Color colorIcon = Config.black;

    if (selectButton == index) {
      colorButton = Config.orange;
      colorIcon = Config.white;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectButton = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorButton,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Config.grey400,
          ),
        ),
        child: SizedBox(
          width: 50,
          child: Icon(
            icon,
            color: colorIcon,
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Config.grey600,
    );
  }
}
