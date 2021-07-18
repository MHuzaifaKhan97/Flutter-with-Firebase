import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  Color color;
  double width;
  String icon;

  var onClick;

  ButtonWidget({this.btnText, this.onClick, this.color, this.width, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.8,
        height: 55,
        decoration: BoxDecoration(
          color: color ?? Color(0xfffca54e),
          // gradient: LinearGradient(
          //     colors: color ?? [Color(0xffF5591F), Color(0xffF2861E)],
          //     end: Alignment.centerLeft,
          //     begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),

          border: Border.all(
              color: color == Colors.white ? Color(0xfffca54e) : Colors.white,
              width: 2),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Image.asset(
                    icon,
                    scale: 5,
                  )
                : Container(),
            SizedBox(width: 4),
            Text(
              btnText,
              style: TextStyle(
                  fontSize: 20,
                  color:
                      color == Colors.white ? Color(0xfffca54e) : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
