
import 'package:flutter/cupertino.dart';

class Post{
   String? uid='منعم.';
   String? uName='Mon3m';
   int postId=0;
   String? postTime='${DateTime.now().year}'+' ${DateTime.now().month}'+' ${DateTime.now().day}';
   String? content=''' دعك من البرمجة و تعال لفاصل طريف صغير حتى لا تمل. ''';
   String? postState='';
   List? sharesUid=['1','2'];
   List? specialsList=[];//peoples to share with only or excepted.
   bool? specialFlag=true;//flag =true if share with special people and false if blocked
   List? comments=[Comment(),Comment()];
   List? likesUid=[];
   List? disLikesUid=[];
   List? files=[];
   List? sharedPostsId=[''];

   Post();

   double rate(){
     return (likesUid!.length/(disLikesUid!.length+likesUid!.length))*5;
   }

   ImageProvider pic(){
     return AssetImage('assets/images/back4.png');
   }

  void set(Map<String,dynamic>? data){
    uid=data!['uid'];
    uName=data['uName'];
    postId=data['postId'];
    postTime=data['postTime'];
    content=data['content'];
    postState=data['postState'];
    sharesUid=data['sharesUid'];
    specialsList=data['specialsList'];
    specialFlag=data['specialFlag'];
    comments=data['comments'];
    likesUid=data['likesUid'];
    disLikesUid=data['disLikesUid'];
    files=data['files'];
    sharedPostsId=data['sharedPostsId'];
  }

   Map<String,dynamic> get(){
    Map<String,dynamic> data={};
     data['uid']=uid;
     data['uName']=uName;
     data['postId']=postId;
     data['postTime']=postTime;
     data['content']=content;
     data['postState']=postState;
     data['sharesUid']=sharesUid;
     data['specialsList']=specialsList;
     data['specialFlag']=specialFlag;
     data['comments']=comments;
     data['likesUid']=likesUid;
     data['disLikesUid']=disLikesUid;
     data['files']=files;
     data['sharedPostsId']=sharedPostsId;
     return data;
   }
}

class Comment{
  String textComment='this is comment';
  String uid='Abdo Samy';
  String commentTime='';
  List<Comment> replay=[];
  List<String> reactionsUid=[];

  Comment();

  void set(Map<String,dynamic> data){
    uid=data['uid'];
    textComment=data['textComment'];
    replay=data['replay'];
    reactionsUid=data['reactionsUid'];
  }

  Map<String,dynamic> get(){
    Map<String,dynamic> data={};
    data['uid']=uid;
    data['textComment']=textComment;
    data['replay']=replay;
    data['reactionsUid']=reactionsUid;
    return data;
  }

}
