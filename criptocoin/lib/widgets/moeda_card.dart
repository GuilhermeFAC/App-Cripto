// ignore_for_file: prefer_const_constructors

import 'package:criptocoin/models/moeda.dart';
import 'package:criptocoin/repositories/favoritas_repository.dart';
import 'package:criptocoin/views/moedas_detalhes__page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedaCard extends StatefulWidget {
  Moeda moeda;

  MoedaCard({Key? key, required this.moeda}) : super(key: key);

  @override
  State<MoedaCard> createState() => _MoedaCardState();
}

class _MoedaCardState extends State<MoedaCard> {
  //Biblioteca de conversão de formato de moedas.
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  static Map<String, Color> precoColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.green,
  };

  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: widget.moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20),
      elevation: 2,
      child: InkWell(
        onTap: () => abrirDetalhes(),
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              Image.network(
                widget.moeda.icone,
                height: 40,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.moeda.nome,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.moeda.sigla,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: precoColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: precoColor['down']!.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                    fontSize: 16,
                    color: precoColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),
              PopupMenuButton(
                  icon: Icon(Icons.delete_forever),
                  iconSize: 30,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: ListTile(
                          title: Text('Remover das Favoritas'),
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<FavoritasRepository>(context,
                                    listen: false)
                                .remove(widget.moeda);
                          },
                        ))
                      ])
            ],
          ),
        ),
      ),
    );
  }
}
