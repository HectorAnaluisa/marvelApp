import 'package:flutter/material.dart';
import 'package:inhered_widget/src/utils/responsive_utils.dart';

class CustomContainer extends StatelessWidget{
  final Color colorContainer;

  const CustomContainer({Key key, @required this.colorContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveScreen = Responsive();
    return Material(
      elevation: 0,
      child: Container(
        height: responsiveScreen.hp(25),
        width: responsiveScreen.wp(35),
        child: CustomPaint(
          painter: _RightDiagonal(colorContainer),
        ),
      ),
    );
  }

}

class _RightDiagonal extends CustomPainter {
  final Color colorContainer;

  _RightDiagonal(this.colorContainer);
  @override
  void paint(Canvas canvas, Size size) {
      final lapiz = Paint();
      lapiz.color = colorContainer;
      lapiz.style = PaintingStyle.fill;
      lapiz.strokeWidth = 5;
      final path = Path();
      path.lineTo(0, size.height);
      path.lineTo(size.width * 0.75 , size.height);
      path.lineTo(size.width, size.height * 0.8);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
      
      canvas.drawPath(path, lapiz);
    } 
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}