import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your/Logic/blocs/profile_bloc.dart';
import 'package:your/Logic/events/profile_events.dart';
import 'package:your/Logic/states/profile_state.dart';
import 'package:your/appScreens/main_page_tabs/posts_tab.dart';
import 'package:your/data_layer/models/post_model.dart';
import 'package:your/routingAndLocalization/applocal.dart';
//import 'posts_tab.dart';

class Profile extends StatefulWidget {
  final FirebaseAuth auth;
  final String? uid;
  const Profile({Key? key,required this.auth,this.uid}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState(auth:auth,uid:uid);
}


class _ProfileState extends State<Profile> {
  bool postColorsFlag=true;
  int postLineNum=1;
  final String? uid;
  final FirebaseAuth auth;
   _ProfileState({required this.auth,this.uid});
  PageController pageController=PageController(initialPage: 0);
  final List<Color?> colors=[Colors.white,Colors.green];
  TextEditingController jop=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController post=TextEditingController();
  double iconH=10.0;
  double pageIndex=0;
  List<bool> flags=[false,false,false];
  bool myAccFlag=true;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {pageIndex=pageController.page!; setState(() {});});
  if(uid !=null)
    {if(auth.currentUser!.uid !=uid)
    {myAccFlag=false;}}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:postColorsFlag? Colors.grey[100]:Colors.grey,
      body: SingleChildScrollView(
        child: BlocProvider<ProfileBloc>(
          lazy: false,
            create: (context) => ProfileBloc(auth:auth,uid: uid),
            child: BlocConsumer<ProfileBloc,ProfileState>(
              listenWhen: (oldState,nowState){return nowState.states !='done';},
              listener: (context,state){
                showDialog(context: context, builder: (context)=>AlertDialog(content: Text("${state.states}"),
                  actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("ok"))],));
              },
              buildWhen:(oldState,currentState){return true;} ,
              builder:(context,state)=> Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:BorderRadius.only(
                          //bottomRight: Radius.circular(50),
                          //bottomLeft: Radius.circular(30)
                            bottomLeft: Radius.elliptical(MediaQuery.of(context).size.width/2, 40),
                            bottomRight: Radius.elliptical(MediaQuery.of(context).size.width/2, 40)
                        ),
                        child: Container(
                          color: Colors.green,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width*1.2,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: pageController,
                            itemCount: state.profile.picFiles.length,
                            itemBuilder: (context,index){
                              return FadeInImage(image: NetworkImage('${state.profile.picFiles[index]}'),
                                placeholder:AssetImage("assets/images/comingsoon.png"),fit: BoxFit.cover,);
                            },
                          ),
                        ),
                      ),
                      Positioned(
                          top: 40,
                          left: 20,
                          child: TextButton(child: Icon(Icons.add_a_photo,size: 30,color: Colors.green[800],),
                            onPressed: (){

                            },)),
                      Positioned(
                        bottom: 20,
                        left: MediaQuery.of(context).size.width/4 ,
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(state.profile.picFiles.length, (index) =>
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.circle,color:(index==pageIndex.toInt()? colors[0]:colors[1]),size: iconH,),
                                  ],
                                )),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Icon(Icons.person,color: Colors.green[800],),
                      SizedBox(width: 10,),
                      Text(' ${state.profile.name}',style: TextStyle(fontSize: 30),)],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Icon(Icons.work_outline_rounded,color: Colors.green[800],),
                      SizedBox(width: 10,),
                      !flags[0]? Text(' ${state.profile.job}'+''):Container(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: TextField(
                          maxLength: 40,
                          maxLines: 2,
                          style: TextStyle(color: Colors.red,
                              fontSize: 16,
                              fontFamily: getLang(context, 'font')),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller:jop,
                        ),
                      ),
                      Tooltip(
                        message: 'edit job',
                        child: TextButton( child:Icon(Icons.edit_rounded,color: Colors.green[800],),
                            onPressed: (){
                              if(flags[0]==false)
                              {flags[0]=true;setState(() {});}
                              else{flags[0]=false;
                              BlocProvider.of<ProfileBloc>(context).add(ProfileEvent(events: 'job',content: jop.text));}
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width:MediaQuery.of(context).size.width/3,
                            child: Divider(height: 40,endIndent: 10,indent: 10,thickness: 1,color: Colors.green[800],)),
                        Text('${getLang(context,'Description')}',style:
                        TextStyle(color: Colors.green[700],
                            fontSize: 20),),
                        Container(
                            width:MediaQuery.of(context).size.width/3,
                            child: Divider(height: 40,endIndent: 10,indent: 10,thickness: 1,color: Colors.green[800],)),
                      ],
                    ),
                  ),
                  !flags[1]? Text(' ${state.profile.get()['description']}'+''):Container(
                    width:  MediaQuery.of(context).size.width/1.2,
                    child: TextField(
                      maxLength: 200,
                      maxLines: 10,
                      style: TextStyle(color: Colors.red,
                          fontSize: 16,
                          fontFamily: getLang(context, 'font')),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      controller:description,
                    ),
                  ),
                  myAccFlag? Tooltip(
                    message: 'edit description',
                    child: TextButton( child:Icon(Icons.edit_rounded,color: Colors.green[800],),
                        onPressed: (){
                          if(flags[1]==false)
                          {flags[1]=true;setState(() {});}
                          else{flags[1]=false;
                          BlocProvider.of<ProfileBloc>(context).add(ProfileEvent(events: 'description',content: description.text));}
                        }),
                  ):SizedBox(height: 10,),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width:MediaQuery.of(context).size.width/3,
                            child: Divider(height: 40,endIndent: 10,indent: 10,thickness: 1,color: Colors.green[800],)),
                        Text('${getLang(context,'Posts')}',style:
                        TextStyle(color: Colors.green[700],
                            fontSize: 20),),
                        Container(
                            width:MediaQuery.of(context).size.width/3,
                            child: Divider(height: 40,endIndent: 10,indent: 10,thickness: 1,color: Colors.green[800],)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),


                  myAccFlag? Tooltip(
                    message: 'add Post',
                    child: CircleAvatar(
                      radius: 25,
                      child: TextButton( child:Icon(Icons.add,color: Colors.white,size: 30,),
                          onPressed: ()async{
                        postColorsFlag= !postColorsFlag;
                            if(flags[2]==true)
                            {flags[2]=false;}
                            else{flags[2]=true;
                            BlocProvider.of<ProfileBloc>(context).add(ProfileEvent(events: 'post',content: post.text));
                           }
                        BlocProvider.of<ProfileBloc>(context).add(ProfileEvent(events: '',content: ''));
                        setState(() {});
                          }),
                    ),
                  ):SizedBox(height: 10,),//if its my account so i can create post.
                    SizedBox(height: 15,),
                  !flags[2]? SizedBox(height: 20,):PostWidget(post:Post(),postController: post,createFlag: false,),//if creation bottom pressed create post widget



                  ...List.generate(state.profile.posts.length, (indexPost) =>
                     PostWidget(post:state.profile.posts[indexPost],createFlag: true,)).reversed,
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width:MediaQuery.of(context).size.width/3,
                          child: Divider(height: 40,endIndent: 10,indent: 10,thickness: 1,color: Colors.green[800],)),
                      Text('${state.profile.creationTime}',style:
                      TextStyle(color: Colors.green[700],
                          fontSize: 20),),
                      Container(
                          width:MediaQuery.of(context).size.width/3,
                          child: Divider(height: 40,endIndent: 10,indent: 10,thickness: 1,color: Colors.green[800],)),
                    ],
                  ),//creation time
                  SizedBox(height: 70,)

                ],
              )
            ),
),
      )
    );
  }
}
