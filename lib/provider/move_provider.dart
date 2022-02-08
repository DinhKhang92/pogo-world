import 'dart:convert';

import 'package:flutter/services.dart';

class MoveProvider {
  Future<List> fetchQuickMoves() async {
    final String response = await rootBundle.loadString('assets/mocks/fast_moves.json');
    final List data = await json.decode(response);
    return data;
  }
}
