import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'routingAndLocalization/applocal.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routingAndLocalization/ongenerateRouting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: routeFunction,
      supportedLocales: [Locale('en'), Locale('ar'),],
      localizationsDelegates: [AppLocale.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
      localeResolutionCallback: (systemLanguage,ourLocalLanguages){if (systemLanguage != null) {
          for (Locale locale in ourLocalLanguages) {
            if (locale.languageCode == systemLanguage.languageCode) {
              // mySharedPreferences.setString("lang",currentLang.languageCode) ;
              return systemLanguage;
            }
          }
        }return ourLocalLanguages.first;},
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passController=TextEditingController();
  bool secureFlag=true;
  Map<bool,IconData> secureIcons={false:Icons.visibility_off,true:Icons.visibility};
  Map<bool,Color?> secureIconsColor={false:Colors.grey,true:Colors.green};
  var secureIcon=Icons.visibility;
  bool arabicLanguageFlag(BuildContext context){
    return  getLang(context, 'arabicLanguageFlag')=='true';
  }



  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
      body:Stack(
        children: [
          Container(
              height: h,
              width: w,
              color: Colors.green[50]
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: Center(child: AnimatedPageView()),
                    decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.only(
                        bottomRight: Radius.elliptical(w/2,50),
                        bottomLeft: Radius.elliptical(w/2,50))
                    ),
                    height: MediaQuery.of(context).size.height/3.5,
                    width: MediaQuery.of(context).size.width,
                    ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    keyboardType:TextInputType.emailAddress ,
                    controller:_emailController,
                    textDirection:TextDirection.ltr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                        suffixIcon:arabicLanguageFlag(context)? Icon(Icons.email):null,
                        prefixIcon:!arabicLanguageFlag(context)? Icon(Icons.email):null,
                        labelText: '${getLang(context, 'emailHint')}'
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller:_passController,
                    obscuringCharacter: '*',
                    obscureText: secureFlag,
                    textDirection:TextDirection.ltr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                        suffixIcon:arabicLanguageFlag(context)? Icon(Icons.lock): TextButton(child:Icon(secureIcon,
                          color:secureIconsColor[secureFlag],),
                          onPressed: (){this.setState(() {
                            secureFlag= !secureFlag;
                            secureIcon=secureIcons[secureFlag]!;});},),
                        prefixIcon:!arabicLanguageFlag(context)? Icon(Icons.lock): TextButton(child:Icon(secureIcon
                        ,color:secureIconsColor[secureFlag],),
                          onPressed: (){this.setState(() {
                            secureFlag= !secureFlag;
                          secureIcon=secureIcons[secureFlag]!;});},),
                        labelText: '${getLang(context, 'passHint')}'
                    ),
                  ),
                ),
                SizedBox(height:20),
                Container(
                  width:200,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(primary: Colors.green[600]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login),
                          Text('${getLang(context, 'login')}'),
                        ],
                      )
                  ),
                  
                ),
                SizedBox(height: 20,),
                Container(
                  width:200,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(primary: Colors.green[600]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google.png',width: 30,height: 30,),
                          Text('${getLang(context, 'googleLogin')}'),
                        ],)
                  ),

                ),
                SizedBox(height: 20,),
                Container(
                  width:200,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(primary: Colors.green[600]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/newAcc.png',width: 30,height: 30,),
                          Text('${getLang(context, 'create')}'),
                        ],)
                  ),

                )

              ],),
          ),
        ],)
    );
  }
}
*/