import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc/data/models/Condominium.dart';
import 'package:tcc/data/models/Employee.dart';
import 'package:tcc/data/repositories/Employee_Respository.dart';
import 'package:tcc/data/stores/Employee_Store.dart';
import 'package:tcc/data/http/http_client.dart';
import 'package:tcc/pages/managers%20pages/employee/employee_list.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';
import 'package:tcc/widgets/input.dart';
import 'package:tcc/widgets/mask.dart';
import 'package:tcc/widgets/showDialog.dart';
import 'package:tcc/widgets/snackMessage.dart';

class EmployeeFormPage extends StatefulWidget {
  final Condominium? condominium;
  final Employee? employee;
  const EmployeeFormPage({this.employee, this.condominium, super.key});

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  EmployeeStore store = EmployeeStore(
    repository: EmployeeRepository(
      client: HttpClient(),
    ),
  );

  String _title = "Cadastrar";
  String? _img;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _workloadController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee!.name!;
      _cpfController.text = widget.employee!.cpf!;
      _rgController.text = widget.employee!.rg!;
      _phoneController.text = widget.employee!.phone!;
      _positionController.text = widget.employee!.position!;
      _workloadController.text = widget.employee!.workload!;
      //_photoController.text = widget.employee!.photo!;
      _emailController.text = widget.employee!.email!;
      _passwordController.text =
          Config.passwordEmployee(widget.employee!.cpf!, widget.employee!.rg!);
      _title = "Editar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.white,
      appBar: AppBarWidget(
        title: '$_title funcionário',
        actions: [
          (widget.employee != null)
              ? IconButton(
                  onPressed: () {
                    WidgetShowDialog.DeleteShowDialog(
                      context,
                      _nameController.text,
                      Icons.delete_forever,
                      _deleteEmployee,
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Config.orange,
                    size: 28,
                  ),
                )
              : Container()
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Config.white,
                      border: Border.all(
                        width: 1,
                        color: Config.grey800,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: _img == null
                        ? Icon(
                            Icons.person,
                            size: 60,
                            color: Config.grey800,
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
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
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        ImagePicker()
                            .pickImage(source: ImageSource.camera)
                            .then((file) {
                          if (file == null) {
                            return;
                          } else {
                            setState(() {
                              _img = file.path;
                              _photoController.text = file.path;
                            });
                          }
                        });
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Config.orange, width: 1),
                        ),
                      ),
                      label: Text(
                        'Adicionar foto',
                        style: TextStyle(color: Config.grey800),
                      ),
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Config.orange,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Adicione a foto da pessoa',
                      style: TextStyle(fontSize: 14, color: Config.grey800),
                    )
                  ],
                )
              ],
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
                  'Dados pessoais',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            InputWidget(
              'Nome',
              _nameController,
              TextInputType.text,
              Icons.person_outline_rounded,
            ),
            InputWidget(
              'Rg',
              _rgController,
              TextInputType.text,
              Icons.wallet_rounded,
              textInputFormatter: [CustomInputMask.maskRg],
            ),
            InputWidget(
              'CPF',
              _cpfController,
              TextInputType.text,
              Icons.description_outlined,
              textInputFormatter: [CustomInputMask.maskCpf],
            ),
            InputWidget(
              'Telefone',
              _phoneController,
              TextInputType.phone,
              Icons.phone_android_outlined,
              textInputFormatter: [CustomInputMask.maskPhone],
            ),
            Divider(),
            Row(
              children: [
                Icon(
                  Icons.home_work_outlined,
                  size: 28,
                  color: Config.orange,
                ),
                Text(
                  'Trabalho',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            InputWidget(
              'Cargo',
              _positionController,
              TextInputType.text,
              Icons.construction_outlined,
            ),
            InputWidget(
              'Carga horária',
              _workloadController,
              TextInputType.text,
              Icons.timer_outlined,
              textInputFormatter: [CustomInputMask.maskTime],
            ),
            Divider(),
            Row(
              children: [
                Icon(
                  Icons.login_outlined,
                  size: 28,
                  color: Config.orange,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            InputWidget(
              'Email',
              _emailController,
              TextInputType.text,
              Icons.email_outlined,
              function: () {
                setState(() {
                  _passwordController.text = Config.passwordEmployee(
                    _cpfController.text,
                    _rgController.text,
                  );
                });
              },
            ),
            InputWidget(
              'Senha',
              _passwordController,
              TextInputType.text,
              Icons.lock_outline,
              obscureText: false,
              enabled: false,
            ),
            Text(
              'A senha do funcionario é 4 primeiros digitos do CPF + 4 ultimos do RG',
            ),
            SizedBox(
              height: 20,
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
                        color: Config.grey800,
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Config.grey800,
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
                      setState(() {
                        _passwordController.text = Config.passwordEmployee(
                            _cpfController.text, _rgController.text);
                      });
                      _saveAndUpdate();
                    },
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
                      _title,
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
        ),
      ),
    );
  }

  void _saveAndUpdate() {
    Map<String, dynamic> employee = {
      "id": (widget.employee != null) ? widget.employee!.id : null,
      "cpf": _cpfController.text,
      "name": _nameController.text,
      "phone": _phoneController.text,
      "rg": _rgController.text,
      "position": _positionController.text,
      "workload": _workloadController.text,
      "email": _emailController.text,
      "condominium": {"id": widget.condominium!.id}
    };

    Map<String, dynamic> register = {
      "login": _emailController.text,
      "password": _passwordController.text,
      "role": Config.funcionario,
      "user_id": 0
    };

    if (widget.employee != null) {
      store.putEmployee(employee).then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeListPage(),
            ),
          );
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "${_nameController.text} foi editado com sucesso",
          );
        },
      );
    } else {
      store.postEmployee(employee, register).then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeListPage(),
            ),
          );
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "${_nameController.text} foi criado com sucesso",
          );
        },
      );
    }
  }

  void _deleteEmployee() {
    store.deleteEmployee(widget.employee!.id!).then(
      (value) {
        if (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeListPage(),
            ),
          );
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            mensage: "${_nameController.text} foi deletado com sucesso",
          );
        } else {
          WidgetSnackMessage.notificationSnackMessage(
            context: context,
            backgroundColor: Config.red,
            mensage: "Ocorreu um erro ao deletar ${_nameController.text}",
          );
        }
      },
    );
  }
}
