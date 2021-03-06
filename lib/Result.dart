import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'resultList.dart';

class Result extends StatefulWidget {

  String? hap, typeText = "Running";
  dynamic sec;
  dynamic minute;
  dynamic weight = "70";
  Result({this.sec, this.minute ,this.hap, this.weight, this.typeText});

  @override
  State<Result> createState() => _Result();
  List<resultList>? list;

}

class _Result extends State<Result> {


  void initState(){
    super.initState();
    calorie(widget.typeText);
  }

  dynamic data;
  dynamic resultData;
  String formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  String formatDate = DateFormat('yy-MM-dd').format(DateTime.now());


  void calorie(type){
    if(type == "Walking"){
      data.toString =  (0.9/15/60) * double.parse(widget.weight) * (60 *widget.minute + widget.sec);

    }if(type == "Running"){
      data = (1.2/15/60) * double.parse(widget.weight) * (60 *widget.minute + widget.sec);

    }else{
      data = (2/15/60) * double.parse(widget.weight) * (60 *widget.minute + widget.sec);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('뛰어라, Running Mate'),
        backgroundColor: Colors.orange,
        titleTextStyle: const TextStyle(
            fontFamily: 'BinggraeⅡ-Bold',
            color: Colors.white,
            letterSpacing: 2.0,
            fontSize: 22.0,
            fontWeight: FontWeight.bold),
      ),
      body: Container(
        color: Colors.amber[50],
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    formattedDate,
                    style: const TextStyle(
                        fontFamily: 'BinggraeⅡ-Bold',
                        fontSize: 15,
                        color: Colors.amber),
                  ),
                  Text(
                    '${widget.typeText}',
                    style: TextStyle(
                        fontFamily: 'BinggraeⅡ-Bold',
                        fontSize: 20,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),
            SizedBox(width: 500, child: Divider(thickness: 2.0)),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        "${widget.hap}",
                        style: const TextStyle(
                            fontFamily: 'BinggraeⅡ-Bold',
                            fontSize: 50,
                            color: Colors.amber),
                      ),
                      const Text(
                        'm',
                        style: TextStyle(
                            fontFamily: 'BinggraeⅡ-Bold',
                            fontSize: 20,
                            color: Colors.orange),
                      )
                    ],
                  ),
                  Row(
                    children: const <Widget>[
                      Icon(Icons.directions_run),
                      Text(
                        '총 달린 거리',
                        style: TextStyle(
                            fontFamily: 'BinggraeⅡ-Bold',
                            fontSize: 20,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "${widget.minute}분 ${widget.sec}초",
                        style: TextStyle(
                            fontFamily: 'BinggraeⅡ-Bold',
                            fontSize: 30,
                            color: Colors.amber),
                      ),
                      Row(children: const <Widget>[
                        Icon(
                          Icons.timer,
                          color: Colors.black,
                        ),
                        Text(
                          '시간',
                          style: TextStyle(
                              fontFamily: 'BinggraeⅡ-Bold',
                              fontSize: 20,
                              color: Colors.orange),
                        ),
                      ])
                    ],
                  ),
                  Column(//calorie(widget.typeText)
                    children: <Widget>[
                      Text("${data.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontFamily: 'BinggraeⅡ-Bold',
                            fontSize: 30,
                            color: Colors.amber),
                      ),
                      Row(
                        children: const <Widget>[
                          Icon(
                            Icons.fastfood,
                            color: Colors.black,
                          ),
                          Text(
                            '칼로리',
                            style: TextStyle(
                                fontFamily: 'BinggraeⅡ-Bold',
                                fontSize: 20,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.blue),
                        Text('뒤로 가기', style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      calorie(widget.typeText);
                      var result = resultList(
                          type: widget.typeText,
                          distance: widget.hap,
                          secTime: widget.sec,
                          minuteTime: widget.minute,
                          calorie: data.toStringAsFixed(1),
                          date: formattedDate,
                          todayTime: formatDate);
                      widget.list?.add(result);
                      Navigator.pop(context, result);
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book, color: Colors.blue),
                        Text('결과 저장', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
