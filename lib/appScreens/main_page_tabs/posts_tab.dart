import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your/Logic/blocs/profile_bloc.dart';
import 'package:your/Logic/events/profile_events.dart';
import 'package:your/data_layer/models/post_model.dart';
import 'package:your/routingAndLocalization/applocal.dart';
class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        children:[PostWidget(post:Post(),createFlag: true,),
          PostWidget(post:Post(),createFlag: true,),
          PostWidget(post:Post(),createFlag: true,),
          PostWidget(post:Post(),createFlag: true,),
         ]);
  }
}


class PostWidget extends StatefulWidget {
  final TextEditingController? postController;
  final bool createFlag;
  final Post post;
  const PostWidget({Key? key,required this.post,required this.createFlag,
    this.postController,
   }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool hidPostFlag=true;
  final FirebaseAuth auth= FirebaseAuth.instance;
  int postLineNum=1;
  final Map<bool,Color> colors=const {false:Colors.blueGrey,true:Colors.green};
  List<bool> thumbFlags=[false,false];
  bool commentFlag=false;

  @override
  Widget build(BuildContext context) {
    //double width=MediaQuery.of(context).size.width;
    return hidPostFlag? Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        backgroundImage:  widget.post.pic(),radius: 30,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("${widget.post.uName}"),
                          Text('${widget.post.postTime}')],),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          mediumRate(widget.post.rate()),
                          Text('${widget.post.rate()}')
                        ],
                      ),),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: widget.createFlag? TextButton(onPressed: ()async{
                        if(auth.currentUser!.uid==widget.post.uid)
                        {await  showDialog(context:context, builder: (_)=>AlertDialog(content: Text("${getLang(context, 'deletePost')}"),
                          actions: [
                            TextButton(onPressed: (){
                              BlocProvider.of<ProfileBloc>(context).add(ProfileEvent(events: 'deletePost',
                                  content:widget.post.postId.toString()));
                              Navigator.of(context).pop();}, child: Text("${getLang(context, 'yes')}")),
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();}, child: Text("${getLang(context, 'no')}")),],));}
                        else{await  showDialog(context:context, builder: (_)=>AlertDialog(content: Text("${getLang(context, 'deletePost')}"),
                          actions: [
                            TextButton(onPressed: (){
                              hidPostFlag=false;
                              setState(() {});
                              Navigator.of(context).pop();}, child: Text("${getLang(context, 'yes')}")),
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();}, child: Text("${getLang(context, 'no')}")),],));}
                      },
                          child:  Icon(Icons.delete,size: 30,color: Colors.green[900],)):SizedBox(width: 10,))
                  ],
                ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),

                    //////post display or post create.
                    child: widget.createFlag? Text("""${widget.post.content}""",style: TextStyle(),
                      textDirection:getLang(context,'nameHint')=='Name'? TextDirection.ltr:TextDirection.rtl,):
                    TextField(
                      onChanged: (text){postLineNum=(text.length/40).floor()+1;setState(() {});},
                      //maxLength: 6000,
                      maxLines: postLineNum,
                      style: TextStyle(color: Colors.red,
                          fontSize: 16,
                          fontFamily: getLang(context, 'font')),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                       borderRadius: BorderRadius.zero),
                      ),
                      controller:widget.postController,
                    ),

                  )],
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey[400],),
              child: Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${widget.post.likesUid!.length+widget.post.disLikesUid!.length}',style: TextStyle(color: Colors.black),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(child: Icon(Icons.thumb_up_rounded,size: 15,color:colors[thumbFlags[0]] ,),
                              onPressed: (){
                              if(widget.createFlag)
                              {thumbFlags[0]= !thumbFlags[0];
                              if(thumbFlags[0] && thumbFlags[1]){thumbFlags[1]=false;}
                              setState(() {});}
                              },),//likes
                            TextButton(child: Icon(Icons.thumb_down,size: 15,color:colors[thumbFlags[1]]),
                              onPressed: (){
                              if(widget.createFlag)
                              {thumbFlags[1]= !thumbFlags[1];
                              if(thumbFlags[0] && thumbFlags[1]){thumbFlags[0]=false;}
                              setState(() {});}},),//dislike
                          ],
                        ),
                      ],
                    ),flex: 4,),
                    Expanded(child: OutlinedButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${widget.post.comments!.length}',style: TextStyle(color: Colors.black)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.keyboard_arrow_down_outlined,
                                size: 20,color: colors[commentFlag],),
                              SizedBox(width: 5,),
                              Icon(Icons.insert_comment_outlined,size: 20,color: colors[commentFlag]),

                            ],
                          ),
                        ],
                      ),
                      onPressed: (){
                          if(widget.createFlag)
                          {commentFlag = !commentFlag;
                          setState(() {});}
                         },),flex: 3,),//comment button
                    Expanded(child:
                    TextButton(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.post.sharesUid!.length}',style: TextStyle(color: Colors.black)),
                        Icon(Icons.share,size: 20,color: Colors.black,) ,
                      ],
                      ),
                      onPressed: (){
                        if(widget.createFlag){}
                      },
                    ),
                   flex: 3,)],),
              ),
            ),
            commentFlag? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                   decoration: BoxDecoration(color: Colors.grey[300],
                       borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                            autofocus: true,
                            onChanged: (text){postLineNum=(text.length/40).floor()+1;setState(() {});},
                            maxLines: postLineNum,
                            style: TextStyle(color: Colors.black,
                            fontSize: 16,
                            fontFamily: getLang(context, 'font')),
                            decoration: InputDecoration(
                              suffix:TextButton(child: Icon(Icons.send,color: Colors.teal,),onPressed: (){},),
                            border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.zero),
                            ),
                            controller:widget.postController,
                            ),
                ),
                ),...List.generate(widget.post.comments!.length,
                    (commentIndex) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))
                  ,color: Colors.green[100]),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("${widget.post.comments![commentIndex].textComment}"),
                  ),
                ),
              );
                    })],): SizedBox(height: 0,)
          ],
        ),
      ),
    ):TextButton(onPressed: (){hidPostFlag=true;setState(() {});},
        child: Text("${getLang(context, 'showPost')}"));
  }
}

Widget mediumRate(double rate){
  return Row(
    children: List.generate(5, (index) {
      if (index+1<=rate){return Icon(Icons.star_rate_rounded,color: Colors.green[600],size: 18,);}
      else if(0>index-rate && index-rate>-1){return Icon(Icons.star_half,color: Colors.green[600],size: 18,);}
      else{return Icon(Icons.star_border,size: 18,color: Colors.black,);}
    }),
  );
}