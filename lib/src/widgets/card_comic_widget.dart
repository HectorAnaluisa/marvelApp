import 'package:flutter/material.dart';
import 'package:inhered_widget/src/models/comic_model.dart';
import 'package:inhered_widget/src/utils/responsive_utils.dart';
import 'package:inhered_widget/src/widgets/custom_container_widget.dart';

class CardComicWidget extends StatelessWidget {
  final List<ComicModel> comics;
  final Function moreData; 
  const CardComicWidget({Key key, @required this.comics, @required this.moreData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _gridController = new ScrollController();

    _gridController.addListener(() {
      if(_gridController.position.pixels >= _gridController.position.maxScrollExtent - 100){
        moreData(); 
      }
    });


    final responsiveScreen = Responsive();
    return GridView.builder(
      controller: _gridController,
      itemCount: comics.length,
      padding: EdgeInsets.all(30),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 30, mainAxisSpacing: 40), 
      itemBuilder: (BuildContext context, int index){
        return GestureDetector(
          onTap: (){
            // print(comics[index].id);
            Navigator.pushNamed(context, 'details', arguments: comics[index]);
          },
          child: Stack(
            children: [
              CustomContainer(colorContainer: Colors.red[900]),
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
                          image: NetworkImage(comics[index].thumbnail.path + '.' + comics[index].thumbnail.extention, ), 
                          placeholder: AssetImage('assets/img/noimage.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: responsiveScreen.hp(1.5),),
                    Container(
                      width: responsiveScreen.wp(35),
                      child: Text(
                        comics[index].title,
                        overflow: TextOverflow.ellipsis ,
                        style: TextStyle(color: Colors.white,
                        fontFamily: 'MvlRegular',
                        fontSize: responsiveScreen.ip(2)
                      ),
                      textAlign: TextAlign.center,) ,
                    ),
                  ],
                ),
              ), 
              
            ],
          ),
        );
      }
    );
  }
}