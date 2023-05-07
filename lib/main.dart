import 'dart:io';

import 'package:core_ui/core_ui.dart';
import 'package:data/data.dart';
import 'package:data/src/model/user.dart' as data;
import 'package:di/di.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_data_accounting_system/src/landing.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCpCbmnwc6OaoAIKifKrwzS5E729I1TDRI',
        appId: '1:841114373753:android:ddc56df076749ff18c0ea8',
        messagingSenderId: '841114373753',
        projectId: 'medical-data-accounting-system',
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD7RmIAlFOO455EfhseI65IrA27Br8fkjo',
        appId: '1:841114373753:ios:d8be70d462013baf8c0ea8',
        messagingSenderId: '841114373753',
        projectId: 'medical-data-accounting-system',
      ),
    );
  }

  final DataDi dataDi = DataDi(serviceLocator: appDependencies);
  await dataDi.init();
  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: const _MedicalDataAccountingSystem(),
    ),
  );
}

class _MedicalDataAccountingSystem extends StatelessWidget {
  const _MedicalDataAccountingSystem();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<data.User?>.value(
      value: AuthProvider().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'Medical data accounting system',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const LandingPage(),
      ),
    );
  }
}
