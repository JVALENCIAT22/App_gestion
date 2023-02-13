import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_flutter/Autentication/services.dart';
import 'package:app_flutter/Autentication/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(
      MyApp());
  });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: Firebase.initializeApp(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return ErrorWidget();
        } else if(snapshot.hasData){
          return MultiProvider(
           providers:[
            ChangeNotifierProvider<AuthServices>.value(value: AuthServices()),
            StreamProvider<User?>.value(
              value: AuthServices().user, 
              initialData: null,
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: Colors.grey[300],
                ),
              home: Wrapper(),
            ),
          );
        } else {
           return Loading();
        }
      }
    );
  }
}

class ErrorWidget extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Icon(Icons.error), Text("Something went wrong !")],))
    ) ;
  }
  
}
class Loading extends StatelessWidget {
 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  ) ;
} 
}
