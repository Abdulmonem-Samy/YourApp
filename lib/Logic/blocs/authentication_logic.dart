import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:your/Logic/events/loginEvent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

////////////////////LoginBloc///////////////////////

class LoginBloc extends Bloc<LoginEvent,String>{
   LoginBloc():super('');
   FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Stream<String> mapEventToState(LoginEvent events)async* {
    SharedPreferences prf=await SharedPreferences.getInstance();
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(email: events.email, password: events.pass);
      if(user.user !=null)
      {prf.setString('email', events.email);
      prf.setString('pass', events.pass);
        yield 'done';}
      else{yield 'email not verified';}}

    on FirebaseAuthException catch (e) {yield e.code;}
    catch(e){yield e.toString();}
  }
}


////////////////////CreateAccountBloc///////////////////////

class CreateBloc extends Bloc<CreateEvent,String>{

  CreateBloc():super('');
  FirebaseAuth auth=FirebaseAuth.instance;
  CollectionReference reference=FirebaseFirestore.instance.collection('users');

  @override
  Stream<String> mapEventToState(CreateEvent events)async* {
    SharedPreferences prf=await SharedPreferences.getInstance();
    try{await auth.signOut();} catch(e){}//try to check signing out any exist account first
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(email: events.email, password: events.pass);
      if(user.user !=null)

       {prf.setString('email', events.email);
       prf.setString('pass', events.pass);
       yield 'done';
       Map<String,dynamic> data={
         'name':events.name,
         'uid':user.user!.uid,
         'creationTime':'${user.user!.metadata.creationTime!.year.toString()+"-"+user.user!.metadata.creationTime!.month.toString()
             +'-'+user.user!.metadata.creationTime!.day.toString()}',
         'lastLoginTime':DateTime.now().toString(),
         'description':'',
         'sex':'',
         'birthDay':'',
         'profileState':'',
         'job':'',
         'profileStrength':0,
         'specialsList':[],
         'specialFlag':true,
         'followersUid':[],
         'likedId':[],
         'posts':[],
         'picFiles':[]};
         DocumentReference userDoc=reference.doc('${user.user!.uid}');
        await userDoc.set(data);
        yield 'done';}
      else{yield 'email not verified';}
    }
    on FirebaseAuthException catch (e) {
      yield e.code;}
    catch(e){yield e.toString();}

  }
}



