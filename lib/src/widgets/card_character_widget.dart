import 'package:flutter/material.dart';
import 'package:inhered_widget/src/models/characters_model.dart';
import 'package:inhered_widget/src/utils/responsive_utils.dart';
import 'package:inhered_widget/src/widgets/custom_container_widget.dart';

class CardWidget extends StatelessWidget {
  final List<CharactersModel> characters;
  final Function moreData;
  const CardWidget({Key key, @required this.characters, @required this.moreData}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    final _gridController = new ScrollController();
    _gridController.addListener(() { 
      if(_gridController.position.pixels >= _gridController.position.maxScrollExtent - 100){
        moreData();
      }
    });
    final responsiveScreen = ResponsiveUtils(context);
    return GridView.builder(
      itemCount: characters.length,
      controller: _gridController,
      padding: EdgeInsets.all(30),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 30, mainAxisSpacing: 40 ),
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            // print(characters[index].id);
            Navigator.pushNamed(context, 'details', arguments: characters[index]);
          },
          child: Stack(
            children: [
              CustomContainer(colorContainer: Color.fromRGBO(41, 41, 41, 1)),
              Container(
                height: responsiveScreen.hp(25),
                width: responsiveScreen.wp(35),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: responsiveScreen.hp(10),
                      width: responsiveScreen.wp(35),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(characters[index].thumbnail.path + '.' + characters[index].thumbnail.extention, ), 
                          placeholder: AssetImage('assets/img/noimage.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: responsiveScreen.hp(1.5),),
                    Container(
                      width: responsiveScreen.wp(35),
                      height: responsiveScreen.hp(5),
                      child: Text(characters[index].name, style: TextStyle(color: Colors.white, fontFamily: 'MvlRegular', fontSize: responsiveScreen.ip(2)), textAlign: TextAlign.center,) ,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    ); 
  }
}