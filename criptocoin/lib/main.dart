import 'package:criptocoin/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'configs/hive_config.dart';
import 'meu_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritasRepository())
      ],
      child: MeuAplicativo(),
    ),
  );
}
