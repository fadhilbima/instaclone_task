import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/add_post/add_post.dart';
import 'package:instaclone/display_post/screens/show_post.dart';
import 'package:instaclone/home/home_page.dart';
import 'package:instaclone/login/login.dart';
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
          if(state is AuthFailed) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const LoginScreen();
            }));
          }
          if (state is AuthSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const ShowPost();
            }));
          }
        },
        child: Splash(),
      ),
    );
  }
}
