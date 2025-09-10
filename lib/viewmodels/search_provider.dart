import 'dart:async';

import 'package:flutter/foundation.dart';
import '../models/address.dart';
import '../services/provider/api_services.dart';

class SearchProvider with ChangeNotifier {
  final ApiServices apiServices;

  List<Address> addresses = [];
  bool isLoading = false;
  String error = '';
  Timer? _timer;

  SearchProvider({required this.apiServices});

  Future<void> search(String query) async {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(const Duration(seconds: 1), () async {
      if (query.isEmpty) {
        addresses = [];
        notifyListeners();
        return;
      }
      isLoading = true;
      error = '';
      notifyListeners();
      try {
        addresses = await apiServices.search(query);
      } catch (e) {
        error = e.toString();
      }
      isLoading = false;
      notifyListeners();
    });
  }
}
