import 'package:flutter/material.dart';
import 'package:instaclone/routes/approutes/app_screen_logic.dart';
import 'package:instaclone/routes/blocs/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(Authenticate()),
      child: AppLogic(),
    );
  }
}
