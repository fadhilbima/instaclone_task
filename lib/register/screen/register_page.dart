import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/login/login.dart';
import 'package:instaclone/register/bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context,state) {
        if(state is RegisterFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMess),
              backgroundColor: Colors.red,
            ),
          );
        }
        if(state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Register Success, please login.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return const LoginScreen();
          }));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: context.read<RegisterBloc>().formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text('Register Page',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.person_add_alt_1_rounded, size: 80,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: 'Email'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Blank email';
                      }
                    },
                    onSaved: (v) {
                      context.read<RegisterBloc>().email = v ?? '';
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        hintText: 'Password'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Blank password';
                      }
                    },
                    onSaved: (v) {
                      context.read<RegisterBloc>().password = v ?? '';
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                            double.infinity, 50
                        )
                    ),
                    onPressed: () {
                      context.read<RegisterBloc>().add(CreateAccount());
                    },
                    child: Text('Register'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
