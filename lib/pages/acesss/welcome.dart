import 'package:flutter/material.dart';
import 'package:tcc/pages/acesss/login.dart';
import 'package:tcc/widgets/appBar.dart';
import 'package:tcc/widgets/config.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        height: 0,
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                width: 250,
                height: 250,
                "img/building.png",
              ),
              SizedBox(
                height: 55,
              ),
              _text("Bem-vindo ao ", "SmartCondo"),
              SizedBox(
                height: 10,
              ),
              Text(
                "Organize e fique por dentro de todas informações do seu condomínio.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.clip,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Começar",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 18,
                      )
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Config.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(String text1, String text2) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: text1,
        style: _style(Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: _style(Config.orange),
          ),
          TextSpan(
            text: "!",
            style: _style(Colors.black),
          ),
        ],
      ),
    );
  }

  TextStyle _style(Color color) {
    return TextStyle(
      fontSize: 24,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }
}
