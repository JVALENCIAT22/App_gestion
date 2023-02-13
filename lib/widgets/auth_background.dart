import 'package:flutter/material.dart';
class AuthBackground extends StatelessWidget {
final Widget child;
  const AuthBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          this.child,
      ],),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        child: ImageIcon(
          AssetImage('img/logo.png'),
          color: Colors.white,
          size: 300,
        ),
      )
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration: _purplebackground(),
      child: Stack(children: [
          Positioned(child: _Buble(),top: 90, left: 2 ,),
          Positioned(child: _Buble(),top:-40, left: -30 ,),
          Positioned(child: _Buble(),top: -50, right: -50 ,),
          Positioned(child: _Buble(),bottom: -50, left: -10 ,),
          Positioned(child: _Buble(), top: 130, right: -20 ,),
      ],),
    );
  }
  
  BoxDecoration _purplebackground()=> BoxDecoration(
    gradient: LinearGradient(colors: [
     Color.fromRGBO(38, 50, 56, 1),
    Color.fromRGBO(38, 50, 56, 1),
    ]
    ),
  );
}
class _Buble extends StatelessWidget{
const _Buble({Key? key}): super(key: key); 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      color: Color.fromRGBO(254, 255, 255, 0.31)
      ),
      );
  }
}