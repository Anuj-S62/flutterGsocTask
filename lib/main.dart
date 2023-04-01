import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text("Test App"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0,0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40.0,
                backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/67/67902.png"),
              ),
            ),
            const Divider(
              height: 60.0,
              color: Colors.grey,
            ),
            const Text(
              'Name',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 15.0
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Anuj Solanki',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold

              ),
            ),
            SizedBox(height: 30.0),
            const Text(
              'College',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 15.0
              ),
            ),
            SizedBox(height: 10.0),
            const Text(
              'IIT Mandi',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold

              ),
            ),
            SizedBox(height: 30,),
            const Text(
              'Branch',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 15.0
              ),
            ),
            SizedBox(height: 10.0),
            const Text(
              'CSE',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold

              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: const <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(width: 10.0,),
                Text(
                  "b21151@students.iitmandi.ac.in",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: const <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(width: 10.0,),
                Text(
                  "anuj603362@gmail.com",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
