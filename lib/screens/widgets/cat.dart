import 'package:flutter/cupertino.dart';

class Cat extends StatelessWidget {
  const Cat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network('https://i.imgur.com/QwhZRyL.png');
  }
}
