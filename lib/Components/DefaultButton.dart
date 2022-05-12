import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttms_logistic/Utility/Constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
    required this.width,
    required this.height,
  }) : super(key: key);
  final String text;
  final double width, height;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.blue,
        onPressed: press,
        child: Row(
          children: [
            const Icon(
              FontAwesomeIcons.save,
              size: 20,
              color: primaryColor,
            ),
            SizedBox(width: 10,),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
