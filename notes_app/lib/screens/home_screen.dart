import 'package:flutter/material.dart';
import 'package:notes_app/screens/addTodoScreen.dart';
import 'package:notes_app/screens/signin_screen.dart';
import 'package:notes_app/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthClass _authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1d1d1d),
        title: Text(
          'Today\'s Schedule',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.png"),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22, bottom: 8),
              child: Text(
                'Monday 21',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        toolbarHeight: 80,
        shadowColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1d1d1d),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
                color: Colors.white,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AddTodoScreen()));
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent, Colors.purple]),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
              title: Container()),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              NoteCard(
                title: "Let\'s Wake up",
                iconData: Icons.alarm,
                check: true,
                iconColor: Colors.red,
                time: '10 AM',
                iconBGColor: Colors.white,
              ),
              SizedBox(height: 10),
              NoteCard(
                title: "Let\'s do gym",
                iconData: Icons.run_circle,
                check: true,
                iconColor: Colors.blue,
                time: '6 AM',
                iconBGColor: Colors.white,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  NoteCard(
      {Key key,
      this.title,
      this.iconData,
      this.iconColor,
      this.time,
      this.check = false,
      this.iconBGColor})
      : super(key: key);

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBGColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: check,
                activeColor: Color(0xff6cf8a9),
                checkColor: Color(0xff0e3e26),
                onChanged: (bool value) {},
              ),
            ),
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff5e616a),
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Container(
                      height: 33,
                      width: 36,
                      decoration: BoxDecoration(
                        color: iconBGColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        iconData,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await _authClass.logout(context);
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (builder) => SignInScreen()),
//                   (route) => false);
//             })
