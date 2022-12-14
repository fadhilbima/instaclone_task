import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/login/bloc/login_bloc.dart';
import 'package:instaclone/register/register.dart';

import '../../home/home_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMess),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Success'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return const HomePage();
          }));
        }
        if (state is NoAccount) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Register, please'),
              backgroundColor: Colors.blue,
            )
          );
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const RegisterScreen();
          }));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return loginLoadingState(context);
          }
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: context.read<LoginBloc>().formKey,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text('Login Page',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold
                                  )
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.lock_open_outlined, size: 80,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Email'
                          ),
                          onSaved: (v) {
                            context.read<LoginBloc>().email = v ?? '';
                          },
                          validator: context.read<LoginBloc>().validateEmailLogin,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: context.read<LoginBloc>().obscureLogin,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Password',
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  context.read<LoginBloc>().showPasswordLogin(
                                    context.read<LoginBloc>().obscureLogin,
                                  );
                                });
                              },
                              child: context.read<LoginBloc>().obscureLogin
                                  ? Icon(Icons.remove_red_eye_outlined)
                                  : Icon(Icons.remove_red_eye),
                            )
                          ),
                          onSaved: (v) {
                            context.read<LoginBloc>().password = v ?? '';
                          },
                          validator: context.read<LoginBloc>().validatePasswordLogin,
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  double.infinity, 50
                              )
                          ),
                          onPressed: () {
                            context.read<LoginBloc>().add(SubmitLogin());
                          },
                          child: Text('Log in'),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont have any account? '),
                            InkWell(
                              onTap: () {
                                context.read<LoginBloc>().add(NoAccountEvent());
                              },
                              child: Text('Click here', style: TextStyle(color: Colors.blueAccent),),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget loginLoadingState(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Form(
                  key: context.read<LoginBloc>().formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text('Login Page',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(Icons.lock_open_outlined, size: 80,),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Email'
                            ),
                            onSaved: (v) {
                              context.read<LoginBloc>().email = v ?? '';
                            },
                            validator: (v) {
                              if(v == null || v.isEmpty) {
                                return 'No email?';
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Password'
                            ),
                            onSaved: (v) {
                              context.read<LoginBloc>().password = v ?? '';
                            },
                            validator: (v) {
                              if(v == null || v.isEmpty) {
                                return 'Blank password';
                              }
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
                              context.read<LoginBloc>().add(SubmitLogin());
                            },
                            child: Text('Log in'),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Dont have any account? '),
                              InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().add(NoAccountEvent());
                                },
                                child: Text('Click here', style: TextStyle(color: Colors.blueAccent),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.blueGrey.withOpacity(0.5),
                child: Center(child: CircularProgressIndicator(color: Colors.blue,)),
              )
            ],
          )
      ),
    );
  }
}