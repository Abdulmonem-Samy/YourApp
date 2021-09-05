import 'package:flutter/material.dart';
import 'package:your/routingAndLocalization/applocal.dart';

class AnimatedPageView extends StatefulWidget {
   AnimatedPageView({Key? key}) : super(key: key);

  @override
  _AnimatedPageViewState createState() => _AnimatedPageViewState();
}

class _AnimatedPageViewState extends State<AnimatedPageView> {
  PageController _cr=PageController(initialPage: 0);
  int index=0;
  final List<Color?> colors=[Colors.white,Colors.green[800]];
  double iconH=10.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 3),(int x){
        if (index < 3)
        {index += 1;
        _cr.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.linear);}
        else
        {index=0;
        _cr.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.bounceOut);}
        setState(() {});
      }),
        builder: (context,snapshot){
          return Column(
            children: [
              Container(
                width: 300,
                height: 200,
                child: PageView.builder(
                    controller:_cr ,
                    itemCount: 4,
                    itemBuilder:(context,r){
                      return MyImage(index: r);
                    }),
              ),
              SizedBox(
                width: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.circle,color:(index==0? colors[0]:colors[1]),size: iconH,),
                      Icon(Icons.circle,color:index==1? colors[0]:colors[1],size: iconH,),
                      Icon(Icons.circle,color:index==2? colors[0]:colors[1],size: iconH,),
                      Icon(Icons.circle,color:index==3? colors[0]:colors[1],size: iconH,)],),
                ),
              ),

            ],
          );
        });
  }

}

class MyImage extends StatelessWidget {
  final int index;
  const MyImage({Key? key,
    required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 45),
          child: Container(
              width: 250,
              height: 90,
              child: Image(image: AssetImage('./assets/images/pic${index+1}.png'))),),

        SizedBox(height: 8,),

        Text('${getLang(context,"welcome${index+1}")}',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily:'${getLang(context,'font')}' )),
      ],
    );
  }
}
