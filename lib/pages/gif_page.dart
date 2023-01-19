import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  GifPage(this._gifData);

  final Map _gifData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_gifData['title']),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Image.network(_gifData['images']['fixed_height']['url']),
        ),
      ),
    );
  }
}
