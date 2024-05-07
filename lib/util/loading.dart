import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/globelVariables.dart';

void loadingDialog(){
Get.defaultDialog(
          title: "",
          content: Container(
            height: 130,
            margin: EdgeInsets.only(bottom: 20),
            child: SpinKitCubeGrid(
              size: 80,
              color: prandColor,
            ),
          ));

          
}
