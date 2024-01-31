import 'package:flutter/material.dart';

// ignore: must_be_immutable
class User extends StatefulWidget {
  final String name;
  int ponto;
  int pontos;
  List<String> historico = <String>[];

  User(this.name, {this.ponto = 0, this.pontos = 0, super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  void _adicionar() {
    setState(() {
      widget.pontos += widget.ponto;
    });
    widget.historico.add('${widget.ponto}');
  }

  void _subtrair() {
    setState(() {
      widget.pontos -= widget.ponto;
    });
    widget.historico.add("-${widget.ponto}");
  }

  void _mostrarHistorico() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Histórico"),
            content: Column(
              children: [
                ...widget.historico.map((e) {
                  return Text(e);
                }).toList(),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Fechar")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4.0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff4f8fc0),
                Color(0xff53d2dc),
              ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: _adicionar,
                          icon: const Icon(Icons.add_circle_rounded)),
                      IconButton(
                          onPressed: _mostrarHistorico,
                          icon: const Icon(Icons.history_rounded)),
                      IconButton(
                          onPressed: _subtrair,
                          icon: const Icon(Icons.do_not_disturb_on_rounded)),
                    ],
                  ),
                  Text(
                    key: widget.key,
                    '${widget.pontos}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 6, 40, 189),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
