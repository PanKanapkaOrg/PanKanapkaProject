import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pankan_appka/actions/actions.dart';
import 'package:pankan_appka/api/http_requester.dart';
import 'package:pankan_appka/api/login_provider.dart';
import 'package:pankan_appka/models/app_state.dart';
import 'package:pankan_appka/models/workers_app_state.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState(LoginProvider(ApiHttpRequester()));
}

class _LoginScreenState extends State<LoginScreen> {
  LoginProvider loginProvider;
  _LoginScreenState(this.loginProvider);

  TextEditingController mailController = TextEditingController(text:"Emilia_Kowalska@mail.com");
  TextEditingController passwordController = TextEditingController(text:"1345qwe");

  bool isLoading = false;

  Future _login(BuildContext context) async {
    this.setState(() => isLoading = true);

    loginProvider.processLoginData(mailController.text, passwordController.text)
      .then((values){
        this.setState(() => isLoading = false);
        if(values['error'] != null) {
          
        }
        else {
          var worker = Worker(
              cateringFirmId: values['firmId'] as int,
              id: values['id'] as int,
              name: values['name'] as String,
              surname: values['surname'] as String);

          StoreProvider.of<AppState>(context).dispatch(WorkerLoggedInAction(worker));
        }
      });
    

  }

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
      enabled: !isLoading,
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
      enabled: !isLoading,
      decoration: InputDecoration(
        hintText: 'Haslo',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = 
        MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: //isLoading ? null : 
          () => _login(context),
          color: Theme.of(context).accentColor,
          child: Text('Log In', style: Theme.of(context).accentTextTheme.headline)
        );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading ? CircularProgressIndicator() : ListView(
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
        ),
      ),
    );
  }
}
