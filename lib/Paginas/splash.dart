import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gudeza_music/Paginas/Login.dart';
import 'package:gudeza_music/Paginas/Signup.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  _onPressed() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginPage();
        },
      ),
    );
  }

  Widget _botao() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Color(/*0xFF00cccc*/ 0xBB00cccc).withOpacity(0.5),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () => _onPressed(),
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'BaiJamjuree',
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.8)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _botao2() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xBB00cccc).withOpacity(0.5),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Signup();
                },
              ),
            ),
            child: Text(
              "Sign-up",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'BaiJamjuree',
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.8)),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/Back-1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xBB00cccc), Color(0xAEff00ff)])),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: AlignmentGeometry.lerp(
                      Alignment.center, Alignment.center, 20),
                  children: [
                    Image.asset(
                      "assets/Logo/Logobranco1.png",
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 160.0),
                      child: Text(
                        "S A Y Z E N",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 170),
                _botao2(),
                SizedBox(height: 60),
              ],
            ),
          ),
          _botao(),
        ],
      ),
    );
  }
}
