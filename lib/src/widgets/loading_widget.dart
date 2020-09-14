import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inhered_widget/src/providers/info/type_info.dart';
import 'package:inhered_widget/src/utils/responsive_utils.dart';
import 'package:provider/provider.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final typeInfo = Provider.of<TypeInfo>(context);
    final responsiveScreen = ResponsiveUtils(context);

    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: SpinKitWave(
          color: typeInfo.getLoadingColor ?? Colors.black,
          size: responsiveScreen.ip(5)
        )
      ),
    );
  }
}