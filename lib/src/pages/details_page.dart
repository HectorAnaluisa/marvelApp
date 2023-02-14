import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inhered_widget/src/models/characters_model.dart';
import 'package:inhered_widget/src/models/comic_model.dart';
import 'package:inhered_widget/src/providers/info/type_info.dart';
import 'package:inhered_widget/src/utils/responsive_utils.dart';
import 'package:inhered_widget/src/widgets/loading_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<PaletteColor> bgColors = new List();
  int _currentIndex;
  bool loadingW = false;
  String _pothoUrl = ''; 
  @override
  void initState() { 
    super.initState();
    _currentIndex = 0; 
    _updatePaletteColor(_pothoUrl);
  }

  _updatePaletteColor(String url) async {
    if ( url == '' ) return;
    final PaletteGenerator colorGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(url),
      size: Size(200, 100), 
    );
    colorGenerator.darkMutedColor != null ? bgColors.add(colorGenerator.darkMutedColor) : bgColors.add(PaletteColor(Colors.black,3));
  }


  @override
  Widget build(BuildContext context) {
    final typeInfo = Provider.of<TypeInfo>(context);
    CharactersModel characterModel;
    ComicModel comicModel;

    if(typeInfo.getTypeCharacter == "characters"){
      characterModel = ModalRoute.of(context).settings.arguments;
      _pothoUrl = '${characterModel.thumbnail.path}.${characterModel.thumbnail.extention}';
    }else if (typeInfo.getTypeCharacter == "comics") {
      comicModel = ModalRoute.of(context).settings.arguments;
      _pothoUrl = '${comicModel.thumbnail.path}.${comicModel.thumbnail.extention}';
    }


    
    final responsiveScreen = Responsive();
    return Scaffold(
      body: loadingW ? LoadingWidget() : SingleChildScrollView(
        child: Column(
          children: [
             Stack(
              children: [
                _backGround(responsiveScreen),
                Positioned(
                  top: responsiveScreen.hp(20) - responsiveScreen.ip(10),
                  left: responsiveScreen.wp(50) - responsiveScreen.ip(10),
                  child: _avatar(responsiveScreen,_pothoUrl),
                ),
                Positioned(
                  left: 10.0,
                  top: 10.0,
                  child: SafeArea(
                    child: CupertinoButton(
                      padding: EdgeInsets.all(10.0),
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.black26,
                      child: Icon(Icons.arrow_back, color: Colors.white,), 
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ),

              ],
            ),
            _infoData(responsiveScreen, typeInfo ,typeInfo.getTypeCharacter == 'characters' ? characterModel : comicModel) 
          ],
        ),
      )
    );
  }

  Widget _infoData(Responsive responsiveScreen, TypeInfo typeInfo ,dynamic data) {
    return Column(
      children: [
        SizedBox(height: responsiveScreen.hp(5),),
        Text(typeInfo.getTypeCharacter == "characters" ? data.name : data.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'MvlRegular',
            fontSize: responsiveScreen.ip(5)
          ),
        ),
        Container(
          height: responsiveScreen.hp(5),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text( typeInfo.getTypeCharacter == "characters" ? data.description : data.format,
            textAlign: TextAlign.justify,
            style: TextStyle(
            fontFamily: 'MvlRegular',
            fontSize: responsiveScreen.ip(2)
          ),
          ),
        ), 
      ],
    );
  }

  Widget _backGround(Responsive responsiveScreen) {
    
    return Container(
      height: responsiveScreen.hp(40),
      width: responsiveScreen.wp(100),
      color: bgColors.length > 0 ? bgColors[_currentIndex].color: Colors.black ,
    );
  }

  Widget _avatar(Responsive responsiveScreen, String url) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            maxRadius: responsiveScreen.ip(11),
            backgroundColor: Colors.white,
          ),
        ),
        Positioned(
          top: responsiveScreen.ip(0.2),
          left: responsiveScreen.ip(0.2),
          child: CircleAvatar(
            maxRadius: responsiveScreen.ip(10.8),
            backgroundColor: Colors.black,
          ),
        ),
        Positioned(
          top:responsiveScreen.ip(1),
          left: responsiveScreen.ip(1),
          child: CircleAvatar(
            maxRadius: responsiveScreen.ip(10),
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(url),
          ),
        ),
        
      ],
    );
  }
}
