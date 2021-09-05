import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your/Logic/blocs/authentication_logic.dart';
import 'package:your/Logic/events/loginEvent.dart';
import '../routingAndLocalization/applocal.dart';
import 'main_page.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  RegExp regex=RegExp(r'[\d | \w]{3,20}\@your.com');
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  bool secureFlag = true;
  bool secureFlag2= true;
  Map<bool, IconData> secureIcons = {
    false: Icons.visibility_off,
    true: Icons.visibility};
  Map<bool, Color?> secureIconsColor = {false: Colors.grey, true: Colors.green};
  var secureIcon = Icons.visibility;
  var secureIcon2 = Icons.visibility;

  //flag to check the language to determine the text direction
  bool arabicLanguageFlag(BuildContext context) {
    return getLang(context, 'arabicLanguageFlag') == 'true';}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                    height: MediaQuery.of(context).size.height/5,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('ك',
                    style: TextStyle(
                        fontSize: 100.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily:'Amiri' ),),
                    Text('${getLang(context,'welcome')}',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily:'Amiri' )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 25,),
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);},
                              child: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,)),

                        ],
                      ),],),
                ),),
                Container(
                  decoration: BoxDecoration(color: Colors.green[100],
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50),
                          bottomLeft:Radius.circular(50),bottomRight: Radius.circular(50), )),
                  child: Form(
                    key: formKey,
                    child: BlocProvider<CreateBloc>(
                      create: (context)=>CreateBloc(),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.all(18),
                            child: TextFormField(
                              validator: (value){if (value!.isEmpty)
                              {return getLang(context,'EmptyEmail').toString();}},
                              keyboardType: TextInputType.emailAddress,
                              controller: _nameController,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: arabicLanguageFlag(context)
                                      ? Icon(Icons.person)
                                      : null,
                                  prefixIcon: !arabicLanguageFlag(context)
                                      ? Icon(Icons.person)
                                      : null,
                                  labelText: '${getLang(context, 'nameHint')}'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(18),
                            child: TextFormField(
                              validator: (value){if (value!.isEmpty)
                              {return getLang(context,'EmptyEmail').toString();}
                              else if (!regex.hasMatch(value))
                              {return getLang(context,'yourHint').toString();}},
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
                            padding: EdgeInsets.all(18),
                            child: TextFormField(
                              validator:(value){if (value!.isEmpty)
                              {return getLang(context,'EmptyPass').toString();}},
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
                          Container(
                            padding: EdgeInsets.all(18),
                            child: TextFormField(
                              validator:(value){if (value!.isEmpty)
                              {return getLang(context,'EmptyPass').toString();}
                              else if(value !=_passController.text)
                                {return getLang(context,'diffPass').toString();}},
                              controller: _confirmPassController,
                              obscuringCharacter: '*',
                              obscureText: secureFlag2,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  suffixIcon: arabicLanguageFlag(context)
                                      ? Icon(Icons.lock)
                                      : TextButton(
                                    child: Icon(
                                      secureIcon2,
                                      color: secureIconsColor[secureFlag2],
                                    ),
                                    onPressed: () {
                                      this.setState(() {
                                        secureFlag2 = !secureFlag2;
                                        secureIcon2 = secureIcons[secureFlag2]!;
                                      });
                                    },
                                  ),
                                  prefixIcon: !arabicLanguageFlag(context)
                                      ? Icon(Icons.lock)
                                      : TextButton(
                                    child: Icon(
                                      secureIcon2,
                                      color: secureIconsColor[secureFlag2],
                                    ),
                                    onPressed: () {
                                      this.setState(() {
                                        secureFlag2 = !secureFlag2;
                                        secureIcon2 = secureIcons[secureFlag2]!;
                                      });
                                    },
                                  ),
                                  labelText: '${getLang(context, 'rePassHint')}'),
                            ),
                          ),
                          BlocConsumer<CreateBloc,String>(
                            listenWhen: (previousState,currentState){return currentState=='done';},
                            listener: (context,state){
                            //Navigator.of(context).pushReplacementNamed('/main',arguments: 1);},
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainPage(page: 1)));},
                            buildWhen: (previousState,currentState){
                            return currentState !='done';},
                            builder: (context, state) {
                            return Text('$state',
                            style:TextStyle(color: Colors.red,
                                fontSize: 16,
                                fontFamily: getLang(context, 'font')),);},
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 200,
                            height: 40,
                            child: Builder(
                              builder:(context)=> ElevatedButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      BlocProvider.of<CreateBloc>(context).add(CreateEvent(email: _emailController.text,
                                          pass: _passController.text,name: _nameController.text));
                                    }
                                    else {setState(() {});}
                                  },
                                  style: ElevatedButton.styleFrom(primary: Colors.green[600]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person_add),
                                      // Image.asset('assets/images/newAcc.png', width: 30,height: 30,),
                                      Text(' ${getLang(context, 'create')}'),

                                    ],
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
