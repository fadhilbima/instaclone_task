import 'package:flutter/material.dart';
import 'package:instaclone/home/home_global_bloc/home_bloc.dart';
import 'package:instaclone/routes/approutes/app_screen_logic.dart';
import 'package:instaclone/routes/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(Authenticate()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: AppLogic(),
    );
  }
}
