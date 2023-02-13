import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
 final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
      
        width: double.infinity,
        height: 430,
    
        decoration: _createCardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    

  );
}