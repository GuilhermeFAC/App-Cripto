import 'package:criptocoin/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meu_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => FavoritasRepository(), child: MeuAplicativo()),
  );
}
