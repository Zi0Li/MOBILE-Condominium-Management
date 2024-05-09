import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/data/models/Resident.dart';
import 'package:tcc/data/repositories/Resident_Repository.dart';
import 'package:tcc/data/stores/Resident_Store.dart';
import 'package:tcc/pages/Profile/address.dart';
import 'package:tcc/pages/Profile/vehicle_list.dart';
import 'package:tcc/pages/home.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/drawer.dart';
import 'package:tcc/widgets/error_message.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/widgets/loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ResidentStore store = ResidentStore(
    repository: ResidentRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = Config.resident.name;
    _emailController.text = Config.resident.email;
    _phoneController.text = Config.resident.phone;
    _rgController.text = Config.resident.rg;
    _cpfController.text = Config.resident.cpf;
  }

  //Controller Profile
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

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
                        _nameController.text,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Config.grey_letter,
                        ),
                      ),
                      Text(
                        "${Config.resident.block} - ${Config.resident.apt}",
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
      return AnimatedBuilder(
        animation: Listenable.merge([store.erro, store.isLoading, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return Center(
              child: WidgetLoading.containerLoading(),
            );
          } else if (store.erro.value.isNotEmpty) {
            return ErrorMessage.containerError(
                store.erro.value, () => store.erro.value = '');
          } else {
            return _personBody();
          }
        },
      );
    } else if (index == 1) {
      return VehiclePage();
    } else {
      return AddressPage();
    }
  }

  Widget _personBody() {
    return Column(
      children: [
        InputWidget(
          'Nome',
          _nameController,
          TextInputType.text,
          Icons.person_outline_rounded,
        ),
        InputWidget("Telefone", _phoneController, TextInputType.number,
            Icons.phone_android_outlined),
        InputWidget('E-mail', _emailController, TextInputType.number,
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
                onPressed: () {
                  _updateResident();
                },
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

  void _updateResident() {
    Resident resident = Resident(
      id: Config.resident.id,
      name: _nameController.text,
      rg: _rgController.text,
      cpf: _cpfController.text,
      block: Config.resident.block,
      apt: Config.resident.apt,
      phone: _phoneController.text,
      email: _emailController.text,
      authorizedPersons: null,
    );
    store.putResident(resident).then((value) {
      setState(() {
        Config.resident = value.first;
      });
    });
  }
}
