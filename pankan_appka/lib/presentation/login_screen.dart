import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/containers/app_loading.dart';
import 'package:pankan_appka/models/app_state.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController mailController =
      TextEditingController(text: "Emilia_Kowalska@mail.com");
  TextEditingController passwordController =
      TextEditingController(text: "1345qwe");

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/icon/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: mailController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Haslo',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = MaterialButton(
        minWidth: 200.0,
        height: 42.0,
        onPressed: () => StoreProvider.of<AppState>(context).dispatch(
            WorkerLoggingInAction(
                mailController.text, passwordController.text)),
        color: Theme.of(context).accentColor,
        child:
            Text('Log In', style: Theme.of(context).accentTextTheme.headline));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: AppLoading(builder: (context, isLoading) {
        print("Building login UI $isLoading");
        return isLoading
            ? CircularProgressIndicator()
            : ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  logo,
                  SizedBox(height: 48.0),
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 24.0),
                  loginButton,
                  //SizedBox(height: 24.0),
                  //Text("Bledne dane logowania ");
                ],
              );
      })),
    );
  }
}
