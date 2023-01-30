import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/screens/signin_screen.dart';

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late String weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your weight',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _database.ref().child('weights').push().set({
                  'weight': weight,
                  'uid': _auth.currentUser!.uid,
                });
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
