
import 'package:flutter/material.dart';

@immutable
class MapKey {

  final Object value;

  const MapKey(this.value);

  @override
  bool operator ==(Object other) =>
      other is MapKey &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => value.hashCode;

  MapKey copyWith({MapKey? value}) 
    => MapKey(value ?? this.value);
}