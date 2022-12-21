import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/home/camera/camera.dart';
import 'package:instaclone/home/home_global_bloc/home_bloc.dart';
import 'package:instaclone/home/home_main.dart';
import 'package:instaclone/login/screen/login_page.dart';
import 'package:instaclone/routes/approutes/splash.dart';
import 'package:instaclone/routes/blocs/auth/auth_bloc.dart';

class AppLogic extends StatelessWidget {
  const AppLogic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Clone',
      home: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state);
          if(state is AuthFailed) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const LoginScreen();
            }));
          }
          if (state is AuthSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return HomePage();
            }));
          }
        },
        child: Splash(),
      ),
    );
  }
}
