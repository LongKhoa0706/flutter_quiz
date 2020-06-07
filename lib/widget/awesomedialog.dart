import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/util/constant.dart';

 buildDialog(BuildContext context,String title,String message, DialogType dialogType,GestureTapCallback onTapOk,GestureTapCallback onTapCancel){
   return AwesomeDialog(context: context,
       dialogType: dialogType,
       animType: AnimType.BOTTOMSLIDE,
       tittle: title,
       btnOkColor: kItemSelectBottomNav,
       desc:  message,
       btnCancelOnPress: onTapCancel,
       btnOkOnPress: onTapOk).show();
 }