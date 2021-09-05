import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
    TabNavigator({Key? key,required this.index,required this.tabController}) : super(key: key);
    final int index;
    final TabController tabController;
   final List<Color> colors=const [Color(0xFF1B5E20),Colors.black];
   final List<double> sizes= const<double>[20.0,40.0];
   @override
   Widget build(BuildContext context) {
     return Container(
       color: null,
       width: MediaQuery.of(context).size.width,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.end,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Expanded(
             flex: 1,
             child: TextButton(child: Icon(Icons.home,size:index==0? sizes[1]:sizes[0],color:index==0? colors[0]:colors[1],)
               ,onPressed: (){
                 tabController.animateTo(0,duration: Duration(milliseconds: 50));
                 },),
           ),
           Expanded(
             flex: 1,
             child: TextButton(
               child: Icon(Icons.account_circle,
                 size:index==1? sizes[1]:sizes[0],color:index==1? colors[0]:colors[1],),
               onPressed: (){
                 tabController.animateTo(1,duration: Duration(milliseconds: 50));
                },),
           ),
           Expanded(
             flex: 1,
             child: TextButton(
               child: Icon(Icons.chat_bubble,size:index==2? sizes[1]:sizes[0],color:index==2? colors[0]:colors[1],),
               onPressed: (){
                 tabController.animateTo(2,duration: Duration(milliseconds: 50));
                },),
           ),
           Expanded(
             flex: 1,
             child: TextButton(
               child: Icon(Icons.public,size:index==3? sizes[1]:sizes[0],color:index==3? colors[0]:colors[1],)
               , onPressed: (){
               tabController.animateTo(3,duration: Duration(milliseconds: 50));
               },),
           ),
         ],),
     );
   }
}



