import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/login_bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isNotEmpty) {
                          if (value.length < 4) {
                            return 'Username is too short';
                          } else {
                            return null;
                          }
                        } else {
                          return 'Please enter Username';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'username',
                        icon: Icon(Icons.person),
                      ),
                      controller: _usernameController,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isNotEmpty) {
                          if (value.length < 8) {
                            return 'Password is too short';
                          } else {
                            return null;
                          }
                        } else {
                          return 'Please enter password';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'password',
                        icon: Icon(Icons.security),
                      ),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed:
                            //state is! LoginLoading ? _onLoginButtonPressed : null,
                            () {
                          if (_formKey.currentState.validate()) {
                            if (state is! LoginLoading) {
                              return _onLoginButtonPressed();
                            } else {
                              return null;
                            }
                          } else {
                            print('Something went wrong...');
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                    Container(
                      child: state is LoginLoading
                          ? CircularProgressIndicator()
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
