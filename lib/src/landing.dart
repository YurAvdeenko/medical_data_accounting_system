import 'package:auth/auth.dart';
import 'package:data/src/model/user.dart' as data;
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data.User? user = Provider.of<data.User?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}
