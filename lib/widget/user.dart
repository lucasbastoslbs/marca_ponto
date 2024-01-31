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
      color: Color.fromARGB(255, 253, 1, 1),
      fontSize: 24,
      fontWeight: FontWeight.bold);

  void adicionar() {
    setState(() {
      widget.pontos += widget.ponto;
    });
    widget.historico.add('${widget.ponto}');
  }

  void subtrair() {
    setState(() {
      widget.pontos -= widget.ponto;
    });
    widget.historico.add("-${widget.ponto}");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4.0,
      shadowColor: Colors.grey,
      color: Colors.cyan,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name,
                style: titleStyle,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: adicionar, icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: subtrair,
                        icon: const Icon(Icons.airplane_ticket)),
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
          Flexible(
            flex: 1,
            child: IconButton(
                onPressed: () {
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
                },
                icon: const Icon(Icons.edit)),
          )
        ],
      ),
    );
  }
}
