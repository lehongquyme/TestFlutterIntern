import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:testflutterintern/viewmodels/search_provider.dart';
import 'services/provider/api_services.dart';
import 'ui/screens/search_Screen.dart';

void main() {
  runApp(MyApp(service: ApiServices()));
}

class MyApp extends StatelessWidget {
  final ApiServices service;

  const MyApp({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchProvider(apiServices: service),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  SearchScreen(),
      ),
    );
  }
}
