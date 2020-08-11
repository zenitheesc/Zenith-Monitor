import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmaster/addLaunch.dart';

const int _blackPrimaryValue = 0xFF000000;

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}


class Home extends StatefulWidget {
  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //CRUD start
  Map data;
  Map dataHistory;
  
  CollectionReference collectionReference = Firestore.instance.collection('launches');
  CollectionReference subCollectionReference = Firestore.instance.collection("launches").document("setembro-2020").collection("LogAcumulator");
  DocumentReference documentReference = Firestore.instance.collection("launches").document("setembro-2020");
  
  addData(){
    Map<String,dynamic> demoData = { };

    CollectionReference collectionReference = Firestore.instance.collection('launches');
    collectionReference.add(demoData); 

    }

  fetchData(){
    //listens to change
    documentReference.snapshots().listen((snapshot) {
      //List documents;
      setState(() {
        data = snapshot.data;
      });
      
     });
     
  }

  deleteData() async{
    CollectionReference collectionReference = Firestore.instance.collection('launches');
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    querySnapshot.documents[0].reference.delete();
  }


//CRUD finish
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: primaryBlack,
        elevation: 0.0,
        title: Image.asset('assets/zenith-faixa.png',
        )
      ),
      
      body: SizedBox.expand(
              child: Container(
          color: primaryBlack,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: <Widget>[
              Text("ZENITH'S FIREBASE TEST",
              style: TextStyle(color: Colors.white, fontSize: 20), ),

              SizedBox(height: 50,),          
              
              Container(
                //TO-DO: fzr um widget pros botões ao invés de ficar reescrevendo q nem um troxa;
                decoration: BoxDecoration(
                  color: primaryBlack,
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(onPressed: (){
                        Navigator.push(context,
                         MaterialPageRoute(builder: (context) => NewLaunch()));
                      }, child: Text("Modificar dados!", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
                      )
                      ),
                  ],
                )
              ),

SizedBox(height: 20,),

                            Container(
                //TO-DO: fzr um widget pros botões ao invés de ficar reescrevendo q nem um troxa;
                decoration: BoxDecoration(
                  color: primaryBlack,
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(onPressed: (){fetchData();}, child: Text("Fetch Data", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
                      )
                      ),
                  ],
                )
              ),

SizedBox(height: 20,),

                            Container(
                //TO-DO: fzr um widget pros botões ao invés de ficar reescrevendo q nem um troxa;
                decoration: BoxDecoration(
                  color: primaryBlack,
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(onPressed: (){deleteData();}, child: Text("💀 Deletar Lançamento 💀 ", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
                      )
                      ),
                  ],
                )
              ),

SizedBox(height: 20,),
              Container(
                color: Colors.grey[800],
                child:
                Text(data.toString(), style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}



const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);