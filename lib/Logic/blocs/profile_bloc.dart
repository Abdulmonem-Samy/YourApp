import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your/Logic/events/profile_events.dart';
import 'package:your/Logic/states/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your/data_layer/models/post_model.dart';
import 'package:your/data_layer/models/profile_model.dart';

///////////////profile Bloc//////////////////

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth auth;
  String? uid;
  CollectionReference reference =
      FirebaseFirestore.instance.collection('users');
  late DocumentReference userDoc;
  ProfileModel prf = ProfileModel();
  bool initialFlg = true;
  int postIndex = 0;

  ProfileBloc({required this.auth, this.uid})
      : super(ProfileState(
          profile: ProfileModel(),
          states: 'done',
        )) {
    initial();
  }

  Future<Map<String, dynamic>> getProfile() async {
    DocumentSnapshot doc = await userDoc.get();
    var data = doc.data()!;
    String dataString = json.encode(data);
    Map<String, dynamic> valueMap = jsonDecode(dataString);
    return valueMap;
  }

  Future setProfile(Map<String, dynamic> data) async {
    await userDoc.update(data);
  }

  //get list of posts in maps form
  Future<List> getPosts() async {
    List valueMaps = [];
    var docs = (await userDoc.collection('posts').get()).docs;
    for (var postDoc in docs) {
      var data = postDoc.data();
      String dataString = json.encode(data);
      Map<String, dynamic> valueMap = jsonDecode(dataString);
      valueMaps.add(valueMap);
    }
    return valueMaps;
  }

  Future<void> initial() async {
    if (initialFlg == true) {
      if (uid == null) {
        if (auth.currentUser == null) {
          var prf = await SharedPreferences.getInstance();
          print(prf.get('email'));
          await auth.signInWithEmailAndPassword(
              email: prf.getString('email')!, password: prf.getString('pass')!);
        }
        uid = auth.currentUser!.uid;
      }
      userDoc = reference.doc('${uid!}');
      initialFlg = false;
      add(ProfileEvent(events: 'initial', content: ''));
    }
  }

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    List postsData = await getPosts();
    if (event.events == 'initial') {
      try {
        Map<String, dynamic> profileData = (await getProfile());
        profileData['posts'] = List.generate(postsData.length, (index) {
          Post pst=Post();
          pst.set(postsData[index]);
          return pst;
        });
        prf.set(profileData);
        yield ProfileState(profile: prf, states: 'done');
      } on FirebaseException catch (e) {
        prf.description = e.code.toString();
        yield ProfileState(profile: prf, states: e.code.toString());
      } catch (e) {
        yield ProfileState(profile: prf, states: e.toString());
      }
    }

    if (event.events == 'job' || event.events == 'description') {
      if (event.content == null) {
        event.content = '';
      }

      await setProfile({event.events: event.content});
      Map<String, dynamic> profileData = (await getProfile());
      profileData['posts'] = List.generate(postsData.length, (index) {
        Post pst=Post();
        pst.set(postsData[index]);
        return pst;
      });
      await prf.set(profileData);
      yield ProfileState(profile: prf, states: 'done');
    }

    if (event.events == 'post' && event.content != '')
    {
      try {
        postIndex = (await reference.doc('${uid!}').collection('posts').orderBy('postId',descending: true).get()).docs[0].data()['postId'] + 1;
      print(postIndex.toString()+"[[[[[[[[");
      }
      on FirebaseException catch (e) {yield ProfileState(profile: prf, states: e.code.toString());}
      catch (e) {
        if (e.toString() == 'RangeError (index): Invalid value: Valid value range is empty: 0') {
          print('not solved');
          postIndex = 0;
        } else {
          yield ProfileState(profile: prf, states: e.toString());}
      }

      try {
        DocumentReference postDoc = reference.doc('${uid!}').collection('posts').doc('$postIndex');
        await postDoc.set({
          'uName': jsonDecode(json.encode((await reference.doc('${uid!}').get()).data()))['name'],
          'uid': jsonDecode(json.encode((await reference.doc('${uid!}').get()).data()))['uid'],
          'postId': postIndex,
          'content': '${event.content}',
          'postTime': DateTime.now().day.toString() +
              ' ' +
              DateTime.now().month.toString() +
              ' ' +
              DateTime.now().year.toString(),
          'likesUid': [],
          'disLikesUid': [],
          'comments': [],
          'sharesUid': []
        }, SetOptions(merge: true));
        Map<String, dynamic> profileData = (await getProfile());
        profileData['posts'] = List.generate(postsData.length, (index) {
          Post pst=Post();
          pst.set(postsData[index]);
          return pst;
        });
        await prf.set(profileData);
        yield ProfileState(profile: prf, states: 'done');
      } on FirebaseException catch (e) {prf.description = e.code.toString();yield ProfileState(profile: prf, states: e.code.toString());}
      catch (e) {yield ProfileState(profile: prf, states: e.toString());}
    }
    if(event.events=='deletePost')
      {try{
        DocumentReference postDoc = reference.doc('${uid!}').collection('posts').doc('${event.content}');
        postDoc.delete();
        Map<String, dynamic> profileData = (await getProfile());
        profileData['posts'] = List.generate(postsData.length, (index) {
          Post pst=Post();
          pst.set(postsData[index]);
          return pst;
        });
        await prf.set(profileData);
        yield ProfileState(profile: prf, states: 'done');
      } on FirebaseException catch (e) {prf.description = e.code.toString();yield ProfileState(profile: prf, states: e.code.toString());}
      catch (e) {yield ProfileState(profile: prf, states: e.toString());}
      yield ProfileState(profile: prf, states: 'done');
      }
  }
}
