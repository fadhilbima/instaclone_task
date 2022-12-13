import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/login/login.dart';
import 'package:instaclone/routes/blocs/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthLoggedout) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen()
            ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(Logout());
            },
            child: Text('Log out'),
          ),
        ),
      ),
    );
  }
}
