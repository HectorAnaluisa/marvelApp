import 'package:flutter/material.dart';

import 'package:inhered_widget/src/providers/info/type_info.dart';
import 'package:inhered_widget/src/providers/services/characters_service.dart';
import 'package:inhered_widget/src/providers/services/comics_service.dart';
import 'package:inhered_widget/src/utils/responsive_utils.dart';
import 'package:inhered_widget/src/widgets/card_character_widget.dart';
import 'package:inhered_widget/src/widgets/card_comic_widget.dart';
import 'package:inhered_widget/src/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;

  final charactersService = new CharactersService();
  final comicService = new ComicService();
    
  @override
  Widget build(BuildContext context) {

    final typeInfo = Provider.of<TypeInfo>(context);

    if(typeInfo.getTypeCharacter == "characters") {
      charactersService.getCharacters();
    }else if ( typeInfo.getTypeCharacter == 'comics' ){
      comicService.getComics();
    }
 
    setState(() {
      loading = false;
    });
    final responsiveScreen = Responsive();
    return Scaffold(
      body: loading? LoadingWidget() : SafeArea(child: _scrollPage(responsiveScreen, typeInfo)) //_scrollPage(context)  // 
    );
  }

  Widget _scrollPage(Responsive responsiveScreen, TypeInfo typeInfo) {
    return Column(
      children: [
        Container(
          height: responsiveScreen.hp(20),
          width: responsiveScreen.wp(100),
          decoration: BoxDecoration(
           gradient: LinearGradient( colors: typeInfo.getHeaderColors ),
           borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
           border: Border.all(width: responsiveScreen.ip(0.2)),
          ),
          child: Stack(
            children: [
              Positioned(top: responsiveScreen.hp(2),
                child: Image(image: AssetImage('assets/img/aven.png'), height: responsiveScreen.ip(12),)
              ), 
              Positioned(
                right: responsiveScreen.wp(5),
                top: responsiveScreen.hp(2),
                child: Column(
                  children: [
                    Image(image: typeInfo.getTypeCharacter == 'characters' ? AssetImage('assets/img/marvel.png'): AssetImage('assets/img/rojomarvel.png') , height: responsiveScreen.ip(6),), 
                    Text( typeInfo.getTypeCharacter == 'characters' ? 'PERSONAJES': 'COMICS' , style: TextStyle(color: Colors.white, fontFamily: 'MvlRegular', fontSize: responsiveScreen.ip(2)), textAlign: TextAlign.center,)
                  ],
                ), 
              )
            ],
          ),
        ),
        typeInfo.getTypeCharacter == "characters" ?  Flexible(
          child: StreamBuilder(
            stream: charactersService.charactersSteam,
            builder: (_ , AsyncSnapshot<List> snapshot){
              if(snapshot.hasData){
                return CardWidget(characters: snapshot.data, moreData: charactersService.getCharacters,);
              }else{
                return Center(child: LoadingWidget()); 
              }
            }, 
          )
        ): Flexible(
          child: StreamBuilder(
            stream: comicService.comicStream,
            builder: (_ , AsyncSnapshot<List> snapshot){
              if(snapshot.hasData){
                return CardComicWidget(comics: snapshot.data, moreData: comicService.getComics);
              }else{
                return Center(child: LoadingWidget(),);
              }
            }
          )
        )
      ],
    );
  }

  _data(){
    final comicService = new ComicService();
    comicService.getComics();
  }
}