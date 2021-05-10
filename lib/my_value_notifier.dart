import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyValueNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  MyValueNotifier(this._value);
  @override
  T get value => _value;
  T _value;
  set value(T newValue) {
    // if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
