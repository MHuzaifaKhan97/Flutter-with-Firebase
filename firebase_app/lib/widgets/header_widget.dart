import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  var text = "Login";

  HeaderContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffF5591F), Color(0xfffca54e)],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              )),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3, style: BorderStyle.solid, color: Colors.white),
                  borderRadius: BorderRadius.circular(100)),
              child: Image.asset(
                "assets/todo2.png",
                scale: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
