import 'package:flutter/material.dart';
import 'package:fluttertask/screens/Home.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checklogin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
      {

        Navigator.pop(context);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => Home(),
          ),
        );
      }
    else
      {
        Navigator.pop(context);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login(),
          ),
        );
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checklogin();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Lottie.asset('img/product.json',
          // width: 200,
          // height: 200,
          fit: BoxFit.cover,
          animate: true,
        ),
      ),
    );
  }
}
