import 'package:flutter/material.dart';

enum DeviceType {
  phone,
  tablet
}

class Helpers {
    static DeviceType getDeviceType(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide < 600 ? DeviceType.phone :DeviceType.tablet;
  }
}