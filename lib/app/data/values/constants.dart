import 'package:flutter/material.dart';

class Timeouts {
  Timeouts._();

  static const CONNECT_TIMEOUT = 10000;
  static const RECEIVE_TIMEOUT = 10000;
}

class GlobalKeys {
  GlobalKeys._();

  static final navigationKey = GlobalKey<NavigatorState>();
}
