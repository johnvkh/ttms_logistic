import 'package:flutter/foundation.dart';

class UseModel extends ChangeNotifier{
  late String _fullName;

  String get fullName => _fullName;

  set fullName(String fullName) {
    _fullName = fullName;
  }
  late String _email;

  String get email => _email;

  set email(String email) {
    _email = email;
  }
}