import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsoctask/get_data.dart';
import 'package:gsoctask/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient client = await initializeClient();

  runApp(
    ProviderScope(
      child: MaterialApp(
        home: InitialScreen(client: client),
      ),
    ),
  );
}
