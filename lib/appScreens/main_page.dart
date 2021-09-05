import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:your/appScreens/main_page_tabs/profile_tab.dart';
import 'package:your/widgets/bottom_navigator.dart';
import 'main_page_tabs/posts_tab.dart';
class MainPage extends StatefulWidget {
  final int page;
  const MainPage({Key? key,required this.page}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(page: page);
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  late TabController _tabController;
  final int page;
   _MainPageState({required this.page});
  @override
  void initState(){
    super.initState();
    _tabController = TabController(initialIndex: page,length: 4,vsync: this);
    _tabController.addListener(() {print('${_tabController.index}');
    setState(() {});});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          TabBarView(
                    controller:_tabController,
                    children:[
                      PostPage(),
                      Profile(auth:auth),
                      Icon(Icons.chat_bubble, size: 25),
                      Icon(Icons.public, size: 25),]),
          Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius:  BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(begin: Alignment.bottomCenter
                      ,end: Alignment.topCenter,
                      colors: [Colors.white.withOpacity(1),
                        Colors.white.withOpacity(.5)],)
                ),
              )),
          Positioned(
              top: 0,
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.bottomCenter
                      ,end: Alignment.topCenter,
                      colors: [Colors.white.withOpacity(0),
                        Colors.white.withOpacity(1)],)
                ),
              )),
          Positioned(
            bottom: 20,
              child:TabNavigator(index: _tabController.index.toInt(),tabController: _tabController,)),
        ],
      ),
    );
  }
}

