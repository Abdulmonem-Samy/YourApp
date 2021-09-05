import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your/appScreens/main_page.dart';
import 'package:your/routingAndLocalization/applocal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  _LoadingScreenState();
  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
    SharedPreferences.getInstance().then((prf){
      if(prf.get('email')==null || prf.get('pass')==null)
        {Navigator.pushReplacementNamed(context,'/login');}
      else
        {try
        {auth.signInWithEmailAndPassword(email: prf.get('email').toString(), password: prf.get('pass').toString());
        if(auth.currentUser != null)
          {//Navigator.pushReplacementNamed(context,'/main',arguments: 0);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainPage(page: 0)));
            }
        }
       catch(e){Navigator.pushReplacementNamed(context,'/login');}
        }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ك',
              style: TextStyle(
                  fontSize: 100.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily:'Amiri' ),),
            SizedBox(height: 50,),
            Text('${getLang(context,'welcome')}',
                style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily:'Amiri' )),
            SizedBox(height: 100,)
        ],
      ),),
    ));
  }
}
