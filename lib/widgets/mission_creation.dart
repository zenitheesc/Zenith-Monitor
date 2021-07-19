//import 'dart:html';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class MissionCreation extends StatefulWidget {
  const MissionCreation({Key? key}) : super(key: key);

  @override
  _MissionCreationState createState() => _MissionCreationState();
}

/// aqui eu mudei umas coisinhas. Primeiro eu mudei o metodo build pra ele retornar uma column.
/// Assim, eu consigo colocar a minha tabela mais facilmente e o codigo fica mais claro.
/// Depois eu peguei todo o codigo da que voce tinha desenvolvido e coloquei um metodo proprio pra ele chamado "textInputs()"
/// Dentro dele eu reparei que um grande pedaço de codigo estava sendo repetido, a parte do TextField,
/// então eu peguei essa parte e coloquei em outro metodo chamado "textField()" só pra ele. 
/// Ai o texto que ele vai mostrar eu to passando por parametro la no "textInputs()".
/// Depois eu mudei os paddings e a fonte dos textos, achei q ficou mais proximo do figma
/// mas se vc achar q não ficou bom eu volto para o que estava 
class _MissionCreationState extends State<MissionCreation> {
  TextField textField(String hintText) {
    return TextField(
      style: TextStyle(
          color: white, fontWeight: FontWeight.normal, fontFamily: 'DMSans'),
      cursorColor: white,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
          isDense: true,
          hintStyle: TextStyle(color: gray),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hintText),
    );
  }

  Widget textInputs() {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          1: FractionColumnWidth(0.03),
          2: FractionColumnWidth(0.25),
          3: FractionColumnWidth(0.15)
        },
        children: [
          TableRow(children: [
            textField('Inserir novo campo'),
            SizedBox(width: 10),
            textField('Tipo'),
            SizedBox(
                height: 30,
                width: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    // onPressed code
                  },
                  child: const Icon(
                    Icons.add,
                    color: eerieBlack,
                  ),
                  backgroundColor: gray,
                ))
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.90, /// eu coloquei ele aqui pois ele tem um deslocamento com as caixas de texto
            child: Text(
              'Criação de Missão',
              style: const TextStyle(color: gray, fontSize: 12.0),
            )),
        Container(
          width: MediaQuery.of(context).size.width * 0.83,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              textInputs(),
            ],
          ),
        ),
      ],
    );
  }
}
