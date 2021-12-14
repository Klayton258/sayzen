import 'package:flutter/material.dart';

import '../Home.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFff00ff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF00cccc), Color(0xFFff00ff)]),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 10,
                    child: Image.asset(
                      "assets/Logo/Logobranco1.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Positioned(
                      top: 209,
                      left: 10,
                      right: 205,
                      bottom: 15,
                      child: Text(
                        "Sign-up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Comfortaa',
                        ),
                      ))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(80),
                      topLeft: Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.person,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              hintText: "Nome",
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontFamily: 'BaiJamjuree')),
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                hintText: "Senha",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontFamily: 'BaiJamjuree')),
                            style: TextStyle(color: Colors.white70),
                            // validator: (value) {
                            //   if (senha.isEmpty) {
                            //     return "Porfavor insira a senha";
                            //     else if(value.length < 6 ){
                            //       return "A Senha esta incompleta";
                            //     }
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF00cccc),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HomePage();
                              },
                            ),
                          ),
                          child: Text(
                            "Entrar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'BaiJamjuree',
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "Esqueceu a senha?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
