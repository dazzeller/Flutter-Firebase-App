
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SecondPage());
}
String x;
var cmd, webdata;

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
var fsconnect = FirebaseFirestore.instance;

  myget() async {
    var d = await fsconnect.collection("command").get();
    print(d.docs[0].data());
    for (var i in d.docs) {
      print(i.data());
    }
  }

  web(cmd) async {
    print(x);
    var url = 'http://192.168.43.50/cgi-bin/task.py?x=${cmd}';
    var r = await http.get(url);
    webdata = r.body;
    setState(() {
    //  Text(webdata);
      webdata = r.body;
      });
    
   print(webdata);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Firebase integration '),
          ),
          body: 
           Center(
             child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: 300,
                height: 900,
        //      color: Colors.purple[800],
           //      color: Colors.black12,
              decoration: BoxDecoration(
                boxShadow: [
                    BoxShadow(
                  //   color: Colors.black,
                     //  color: Colors.grey.withOpacity(0.5),
                   spreadRadius: 5,
                      blurRadius: 7,
                       offset: Offset(0, 3), 
                  //    spreadRadius: 30,
                //      blurRadius: 20,
                 //     offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                   child: Column(
                    children: <Widget>[
                      Card(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixText: "[root@localhost]",
                            prefixStyle: TextStyle(
                              color: Colors.white,
                            )
                         //   hintText: 'Enter Command',
                         //   hintStyle: TextStyle(
                           //   color: Colors.black38,
                          //  ),
                          ),
                          onChanged: (val) {
                            x = val;
                            fsconnect.collection("command").add({
                              'name': '${webdata}',
                            });
                            // print(val);
                          },
                        ),
                      ),
                      Card(
                        child: FlatButton(
                          onPressed: () {
                            // print(x); // x=date
                            web(x);
                            myget();
                            print("get");
                            setState(() {
                              
                            });
                          },
                          child: Text('submit'),
                        ),
                         
                      ),
                      
                      Text(
                        webdata ?? "output  is comming ...",
                        style: TextStyle(
                          color:Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),

                      ),
                    
                    ],
                  
                  ),
                ),
              ),
           ),
          
        )
    );
  }
}