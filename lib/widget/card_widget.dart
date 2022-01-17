import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;

  const CardWidget({
    @required this.title,
    @required this.description,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        SvgPicture.asset("assets/images/beer.svg",height: 100,width: 100,),
        Positioned(
          right: 90,
          child: Container(
            child: SvgPicture.asset("assets/images/couple.svg",height: 100,width: 100,),
          ),
        ),
        Positioned(
          right: 10,
          child: Container(
            child: SvgPicture.asset("assets/images/snake.svg",height: 100,width: 100,),
          ),
        ),
      ],
    );
  }
}
