import 'package:flutter/material.dart';

class Api {
  String get callApi => 'Already called API';
}

class SomeModel {
  Api api;
  SomeModel(this.api);
}

class CounterProvider with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }

  void clear() {
    value = 0;
    notifyListeners();
  }
}

class PersonalModel {
  String name;
  String surname;

  PersonalModel(this.name, this.surname);
}
