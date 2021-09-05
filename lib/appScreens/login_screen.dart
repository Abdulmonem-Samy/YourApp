import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your/Logic/blocs/authentication_logic.dart';
import 'package:your/Logic/events/loginEvent.dart';
import 'package:your/appScreens/main_page.dart';
import 'package:your/routingAndLocalization/applocal.dart';
import 'package:your/widgets/animatedPageView.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  bool secureFlag = true;
  Map<bool, IconData> secureIcons = {
    false: Icons.visibility_off,
    true: Icons.visibility};
  Map<bool, Color?> secureIconsColor = {false: Colors.grey, true: Colors.green};
  var secureIcon = Icons.visibility;

  //flag to check the language to determine the text direction
  bool arabicLanguageFlag(BuildContext context) {
    return getLang(context, 'arabicLanguageFlag') == 'true';}

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        Container(height: h, width: w, color: Colors.green[50]),
        SingleChildScrollView(
          child: BlocProvider<LoginBloc>(
            create: (context)=>LoginBloc(),
            child: Column(
                  children: [
                    Container(
                      child: Center(child: AnimatedPageView()),
                      decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.elliptical(w / 2, 50),
                              bottomLeft: Radius.elliptical(w / 2, 50))),
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 20,),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: TextFormField(
                              validator: (value){if (value!.isEmpty)
                              {return getLang(context,'EmptyEmail').toString();}
                              else{return null;}},
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: arabicLanguageFlag(context)
                                      ? Icon(Icons.email)
                                      : null,
                                  prefixIcon: !arabicLanguageFlag(context)
                                      ? Icon(Icons.email)
                                      : null,
                                  labelText: '${getLang(context, 'emailHint')}'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: TextFormField(
                              validator:(value){if (value!.isEmpty)
                              {return getLang(context,'EmptyPass').toString();}
                              else{return null;}},
                              controller: _passController,
                              obscuringCharacter: '*',
                              obscureText: secureFlag,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: arabicLanguageFlag(context)
                                      ? Icon(Icons.lock)
                                      : TextButton(
                                    child: Icon(
                                      secureIcon,
                                      color: secureIconsColor[secureFlag],
                                    ),
                                    onPressed: () {
                                      this.setState(() {
                                        secureFlag = !secureFlag;
                                        secureIcon = secureIcons[secureFlag]!;
                                      });
                                    },
                                  ),
                                  prefixIcon: !arabicLanguageFlag(context)
                                      ? Icon(Icons.lock)
                                      : TextButton(
                                    child: Icon(
                                      secureIcon,
                                      color: secureIconsColor[secureFlag],
                                    ),
                                    onPressed: () {
                                      this.setState(() {
                                        secureFlag = !secureFlag;
                                        secureIcon = secureIcons[secureFlag]!;
                                      });
                                    },
                                  ),
                                  labelText: '${getLang(context, 'passHint')}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 40,
                      child: BlocConsumer<LoginBloc, String>(
                            listenWhen: (previousState,currentState){return currentState=='done';},
                            listener: (context,state){
                             // Navigator.of(context).pushReplacementNamed('/main',arguments: 0);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainPage(page: 0)));

                            },

                            buildWhen: (previousState,currentState){
                              return currentState !='done';},
                            builder: (context, state) {
                              return Text('$state',
                                style:TextStyle(color: Colors.red,fontSize: 16,fontFamily: getLang(context, 'font')),);},
                                  ),
                    ),
                    Container(
                      width: 200,
                      height: 40,
                      child: Builder(
                        builder:(context)=> ElevatedButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                BlocProvider.of<LoginBloc>(context).add(LoginEvent(email: _emailController.text,
                                    pass: _passController.text));
                                print(_emailController.text+_passController.text);
                              }
                            },
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
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context,'/create');},
                          style: ElevatedButton.styleFrom(primary: Colors.green[600]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/newAcc.png',
                                width: 30,
                                height: 30,
                              ),
                              Text('${getLang(context, 'create')}'),

                            ],
                          )
                      ),
                    ),//create account
                    SizedBox(height: 20,),

                  ],
                ),
            ),
          ),
      ],
    ));
  }
}


