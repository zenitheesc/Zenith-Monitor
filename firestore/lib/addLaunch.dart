import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmaster/main.dart';

class NewLaunch extends StatefulWidget {
  @override
  _NewLaunchState createState() => _NewLaunchState();
}

class _NewLaunchState extends State<NewLaunch> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController launchstartController = TextEditingController();

  Map<String,dynamic> launchToAdd;

  CollectionReference collectionReference = Firestore.instance.collection("launches");

  addLaunch(){
    launchToAdd = {
      "launch-name": nameController.text,
      "launch-description": descriptionController.text,
      "launch-category":  categoryController.text,
      "launch-start": launchstartController.text,
    };

    collectionReference.add(launchToAdd).whenComplete(() => print('Added to the Database'));
  }


    _buildTextField(
      TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: primaryBlack, border: Border.all(color: Colors.white)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryBlack,
        elevation: 0.0,
        title: Image.asset('assets/zenith-faixa.png'),
      ),
      body: SizedBox.expand(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Text("Crie seu lançamento", style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,),
              SizedBox(height: 50,),
              _buildTextField(nameController, "//Nome do Lançamento"),
              SizedBox(height: 20,),
              _buildTextField(descriptionController, "//Descrição breve"),
              SizedBox(height: 20,),
              _buildTextField(categoryController, "//Categoria"),
              SizedBox(height: 20,),
              _buildTextField(launchstartController, "//Horário de Início"),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),decoration: BoxDecoration(border: Border.all(color: Colors.white)) ,
                child: FlatButton(onPressed: (){
                  addLaunch();
                }, child: Text("Salvar no servidor", style: TextStyle(color: Colors.white),)))

            ],
          ),
        ),
      ),
floatingActionButton: FloatingActionButton(backgroundColor: Colors.white,onPressed: (){
  Navigator.pop(context);
}, child: Icon(Icons.home, color: primaryBlack,),),
    );
  }
}