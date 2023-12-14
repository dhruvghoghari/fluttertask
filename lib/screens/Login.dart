import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/screens/MainTab.dart';
import 'package:fluttertask/screens/Userprofile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         color: const Color(0xff301547),
         child: SingleChildScrollView(
           child: Column(
             children: [
               SizedBox(height: 50.0,),
               Row(
                 children: [
                   const SizedBox(width: 20.0,),
                   Image.asset("img/Connect friends easily & quickly (1).png",height: 300.0,)
                 ],
               ),
               SizedBox(height: 250.0,),

               Container(
                 width: 320.0,
                 height: 55.0,
                 child: ElevatedButton(onPressed: () async{

                   final GoogleSignIn googleSignIn = GoogleSignIn();
                   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
                   if (googleSignInAccount != null) {
                     final GoogleSignInAuthentication googleSignInAuthentication =
                     await googleSignInAccount.authentication;
                     final AuthCredential authCredential = GoogleAuthProvider.credential(
                         idToken: googleSignInAuthentication.idToken,
                         accessToken: googleSignInAuthentication.accessToken);


                     UserCredential result = await auth.signInWithCredential(authCredential);
                     User user = result.user!;

                     var name = user.displayName.toString();
                     var email = user.email.toString();
                     var photo = user.photoURL.toString();
                     var googleId = user.uid.toString();

                     SharedPreferences prefs = await SharedPreferences.getInstance();
                     prefs.setString("name",name);
                     prefs.setString("isLogin","yes");
                     prefs.setString("email",email);
                     prefs.setString("photo",photo);
                     prefs.setString("googleId",googleId);


                     Navigator.pop(context);
                     Navigator.push(context,
                       MaterialPageRoute(builder: (context) => MainTab(),
                       ),
                     );

                   }
                 }, child: const Text("Login With Google")),
               )
             ],
           ),
         ),
       ),
     ),

    );
  }
}
