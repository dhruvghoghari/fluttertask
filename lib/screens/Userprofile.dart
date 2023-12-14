import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({Key? key}) : super(key: key);

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {

  var name = "";
  var email ="";
  var photo ="";
  var googleid ="";

  getdata() async
  {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name").toString();
      email= prefs.getString("email").toString();
      photo= prefs.getString("photo").toString();
      googleid= prefs.getString("googleid").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(photo),
            Text("Name : "+ name),
            Text("Email : "+ email),
            ElevatedButton(onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              final GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.signOut();
              Navigator.pop(context);
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Login(),
                ),
              );
            }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
