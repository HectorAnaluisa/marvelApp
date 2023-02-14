import 'package:flutter/material.dart';
import 'package:inhered_widget/src/providers/info/type_info.dart';
import 'package:inhered_widget/src/utils/responsive_utils.dart';
import 'package:inhered_widget/src/widgets/rectangle_widget.dart';
import 'package:provider/provider.dart';

class TypePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _middleScreen(context),
          _middleScreenButtons(context)
        ],
      ),
    );
  }

  Widget _middleScreen( BuildContext context ) {

    Responsive().initResponsive(context);

    final responsiveScreen = Responsive();
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [

          Stack(
            children: [
              Positioned(
                child:  RectangleWidget(height: responsiveScreen.hp(100), width: responsiveScreen.wp(50), colors: [Colors.red, Colors.red[900]]),
              ),
              Positioned(
                right: responsiveScreen.wp(-55),
                top: responsiveScreen.hp(50),
                child: Image(image: AssetImage('assets/img/cap.png'), height: responsiveScreen.ip(50),)
              )
            ],
          ),
          
          Stack(
            children: [
              Positioned(
                left: screenSize.width * 0.5 ,
                child: RectangleWidget(height: responsiveScreen.hp(100), width: responsiveScreen.wp(50), colors: [Colors.grey[500], Colors.white])
              ),
              Positioned(
                top: responsiveScreen.hp(4),
                left: responsiveScreen.wp(35),
                child: Image(image: AssetImage('assets/img/thano.png'), height: responsiveScreen.ip(40),)
              )
            ],
          ),

          Positioned(
            left: screenSize.width * 0.5,
            child: RectangleWidget(height: responsiveScreen.hp(100), width: responsiveScreen.wp(1) , colors: [Colors.black, Colors.black],),
          ),

          Positioned(
            child: RectangleWidget(height: responsiveScreen.hp(50), width: responsiveScreen.wp(50), colors: [Colors.red, Colors.red[900]])
          ),

          Positioned(
            top: responsiveScreen.hp(30),
            left: responsiveScreen.wp(50)/2/3,
            child: Text('PERSONAJES', style: TextStyle(fontSize: responsiveScreen.ip(5.0), color: Colors.white, fontFamily: 'MvlRegular',fontWeight: FontWeight.w500),)
          ),

          Positioned(
            bottom: responsiveScreen.hp(30),
            right: responsiveScreen.wp(50)/2/3,
            child: Text('COMICS', style: TextStyle(fontSize: responsiveScreen.ip(5.0), color: Colors.black, fontFamily: 'MvlRegular'),)
          ),

          Positioned(
            right: responsiveScreen.wp(5),
            top: responsiveScreen.hp(95),
            child: Image(image: AssetImage('assets/img/marvel.png'), height: responsiveScreen.ip(3),)
          ) 
        ],
      ),
    );
  }

  Widget _middleScreenButtons(BuildContext context){
    final typeInfo = Provider.of<TypeInfo>(context);
    final responsiveScreen = Responsive();

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Opacity(
              opacity: 0.1,
              child: Container(
                height: responsiveScreen.hp(100),
                width: responsiveScreen.wp(50),
                child: ElevatedButton(
                  onPressed: (){
                    typeInfo.setLoadingColor = Colors.red[900];
                    typeInfo.setHeaderColor = [Colors.red, Colors.red[900]];
                    typeInfo.setTypeCharacter = 'characters';
                    Navigator.pushNamed(context, 'home');
                  }, child: null,
                ),
              ),
            ),
            Opacity(
              opacity: 0.1,
              child: Container(
                height: responsiveScreen.hp(100),
                width: responsiveScreen.wp(49),
                child: ElevatedButton(
                  child: null,
                  onPressed: (){
                    typeInfo.setLoadingColor = Colors.black;
                    typeInfo.setTypeCharacter = 'comics';
                    typeInfo.setHeaderColor = [Colors.black, Colors.grey[900] ,Colors.grey[800]];
                    Navigator.pushNamed(context, 'home');
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}