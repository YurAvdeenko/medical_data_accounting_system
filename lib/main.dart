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
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      //todo refactor
      apiKey: 'AIzaSyAiT93RiXxIA_dNWgySy5jaOcAlkuRbWOE',
      appId: '1:616009798129:android:3507f8a0c88648e5abf450',
      messagingSenderId: '616009798129',
      projectId: 'knowyourtime-7c7b0',
    ),
  );
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
