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
  final titleStyle = const TextStyle(
      color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold);

  final pointStyle = const TextStyle(
      color: Color(0xff744a0f), fontSize: 24, fontWeight: FontWeight.bold);

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
      elevation: 4.0,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xffd1a300),
          Color(0xffffec0d),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.name,
                  style: titleStyle,
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
                    style: pointStyle,
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
