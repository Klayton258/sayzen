import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gudeza_music/Bottompages/Favourites.dart';
import 'package:gudeza_music/Bottompages/MusicList.dart';
import 'package:gudeza_music/Bottompages/PrincipalPage.dart';
import 'package:gudeza_music/Bottompages/UserPage.dart';
import 'package:gudeza_music/Paginas/splash.dart';

import 'Bottompages/SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 2;

//!   PAGINAS
  final Favourites _favoritos = Favourites();
  final MusicList _listaMusicas = MusicList();
  final PrincipalPage _paginaprincipal = PrincipalPage();
  final SearchPage _paginapesquisas = SearchPage();
  final UserPage _usuario = UserPage();

  Widget _showpage = PrincipalPage();

  Widget _pagechooser(int page) {
    switch (page) {
      case 0:
        return _favoritos;
        break;
      case 1:
        return _paginapesquisas;
        break;
      case 2:
        return _paginaprincipal;
        break;
      case 3:
        return _listaMusicas;
        break;
      case 4:
        return _usuario;
        break;
      default:
        return _paginaprincipal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          _showpage.toString(),
          textScaleFactor: 1.0,
        ),
        leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return Splashscreen();
                }),
              );
            }),
      ),
      //!    BOTTOM  NAVIGATOR  BAR
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.teal[700],
        animationDuration: Duration(milliseconds: 500),
        animationCurve: Curves.fastOutSlowIn,
        height: 70,
        color: Colors.black,
        items: [
          Icon(Icons.favorite_outline_outlined, size: 25, color: Colors.white),
          Icon(Icons.search_outlined, size: 25, color: Colors.white),
          Icon(Icons.home_sharp, size: 25, color: Colors.white),
          Icon(Icons.playlist_add_check_outlined,
              size: 25, color: Colors.white),
          Icon(Icons.person_outline_outlined, size: 25, color: Colors.white),
        ],
        onTap: (int tappedIndex) {
          setState(() {
            _showpage = _pagechooser(tappedIndex);
          });
        },
      ),
      body: Container(
        child: Center(child: _showpage),
      ),
    );
  }
}
