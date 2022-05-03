import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<Null> DialogSucessfull(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (Context) => SimpleDialog(
      title: ListTile(
        leading: Image.asset("assets/images/logo.png"),
        title: Text(title),
        subtitle: Text(message),
      ),
      children: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Continue"))
      ],
    ),
  );
}

Future<Null> DialogFail(
    BuildContext context, String title, String message) async {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          width: 300,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          headerAnimationLoop: true,
          animType: AnimType.RIGHSLIDE,
          title: title,
          desc: message,
          btnOkOnPress: () {
            //Navigator.pop(context);
          },
          btnOkColor: Colors.red,
          btnOkText: "Continue")
      .show();
}
