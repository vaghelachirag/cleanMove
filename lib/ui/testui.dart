
import 'package:flutter/material.dart';


class TestUi extends StatefulWidget {
   const TestUi({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestUiState();

}


class _TestUiState extends State<TestUi> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:   Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Center(
                child:Text("Data",style: TextStyle(color: Colors.red,fontSize: 20),),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Text("data")
              )
            ],
          )
      ),
    );
  }

}