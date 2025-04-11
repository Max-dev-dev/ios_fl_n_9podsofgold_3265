import 'package:flutter/material.dart';

class CloverIcon extends StatelessWidget {
const CloverIcon({ super.key });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 20,
      width: 20,
      child: Image.asset('assets/images/clover.png'),
    );
  }
}