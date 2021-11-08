import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() => runApp(MyWebServ());

class MyWebServ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Previsão do Tempo",
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.teal,
          scaffoldBackgroundColor: Color(0xFF353535),
        ),
        home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String _date = "";
  int _temp = 0;
  String _description = "";
  int _humidity = 0;
  String _windSpeedy = "";
  String _time = "";

  String _forecastDate1 = "";
  String _forecastWeekday1 = "";
  int _forecastMax1 = 0;
  int _forecastMin1 = 0;
  String _forecastDesc1 = "";
  String _previsao1 = "";

  String _forecastDate2 = "";
  String _forecastWeekday2 = "";
  int _forecastMax2 = 0;
  int _forecastMin2 = 0;
  String _forecastDesc2 = "";
  String _previsao2 = "";

  _recuperar() async {
    var url =
        'https://api.hgbrasil.com/weather?woeid=455991&format=json-cors&key=114a4966';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = convert.jsonDecode(response.body);
    setState(() {
      _date = retorno["results"]["date"];
      _temp = retorno["results"]["temp"];
      _description = retorno["results"]["description"];
      _humidity = retorno["results"]["humidity"];
      _windSpeedy = retorno["results"]["wind_speedy"];
      _time = retorno["results"]["time"];

      _forecastDate1 = retorno["results"]["forecast"][1]["date"];
      _forecastWeekday1 = retorno["results"]["forecast"][1]["weekday"];
      _forecastMax1 = retorno["results"]["forecast"][1]["max"];
      _forecastMin1 = retorno["results"]["forecast"][1]["min"];
      _forecastDesc1 = retorno["results"]["forecast"][1]["description"];
      _previsao1 =
          "\nData: $_forecastDate1 \nMáxima: $_forecastMax1°C \nMínima: $_forecastMin1 °C \nPrevisão: $_forecastDesc1";

      _forecastDate2 = retorno["results"]["forecast"][2]["date"];
      _forecastWeekday2 = retorno["results"]["forecast"][2]["weekday"];
      _forecastMax2 = retorno["results"]["forecast"][2]["max"];
      _forecastMin2 = retorno["results"]["forecast"][2]["min"];
      _forecastDesc2 = retorno["results"]["forecast"][2]["description"];
      _previsao2 =
          "\nData: $_forecastDate2 \nMáxima: $_forecastMax2°C \nMínima: $_forecastMin2 °C \nPrevisão: $_forecastDesc2";
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Previsão do Tempo"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Hoje',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0, color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "Data: $_date",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Temperatura: $_temp °C",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Descrição: $_description",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Humidade: $_humidity",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Velocidade do vento: $_windSpeedy",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      "Última atualização às: $_time",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  TextButton(
                      onPressed: _recuperar,
                      child: Text("Atualizar",
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.teal))),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    child: Text(
                      "$_forecastWeekday1 $_previsao1",
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Courier New',
                          color: Color(0xFF29C5B7)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    child: Text(
                      "$_forecastWeekday2 $_previsao2",
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Courier New',
                          color: Color(0xFF29C5B7)),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
