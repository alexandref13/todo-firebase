import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_challenger/app/app_firebase.dart';

import 'app/app_module.dart';

void main() => runApp(ModularApp(module: AppModule(), child: AppFirebase()));
