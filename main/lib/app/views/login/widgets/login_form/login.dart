import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/app/bloc/controllers/login/login_bloc.dart';
import 'package:zenith_monitor/app/models/user.dart';
import 'package:zenith_monitor/app/views/login/animations/FadeAnimation.dart';
import 'package:zenith_monitor/app/views/login/animations/Loader.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  final Function toggleUpdatePassword;
  Login({this.toggleView, this.toggleUpdatePassword});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // BlocProvider.of<LoginBloc>(context).add(LoginStart());
  }

  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String senha = '';
  String error = '';

  bool loading = false;
  bool valida = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSignInSuccesful) {
          Navigator.popAndPushNamed(context, '/map');
        }
      },
      builder: (context, state) {
        // print(state);
        if (state is LoginLoading) {
          return Loader();
        }
        return Scaffold(
          backgroundColor: const Color.fromRGBO(
              30, 28, 27, 0.0), //sla pq mas o Z ficou mais destacado assim
          body: Container(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset("assets/images/Z.png"),
                  ),
                  FadeAnimation(
                    1.5,
                    -50.0,
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(15, 60, 15, 20),
                      height: 508,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(70),
                        ),
                      ),
                      child: ListView(children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          2.5,
                          -25.0,
                          Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Insira um email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "E-mail",
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(30, 28, 27, 1),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2.5,
                          -35.0,
                          Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: TextFormField(
                              validator: (val) => val.length < 6
                                  ? 'Senha deve conter no mínimo 6 digitos'
                                  : null,
                              onChanged: (val) {
                                setState(() => senha = val);
                              },
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: "Senha",
                                labelStyle: TextStyle(
                                  color: Color.fromRGBO(30, 28, 27, 1),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2,
                          0,
                          Container(
                            margin: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                            height: 30,
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              child: Text("Recuperar Senha"),
                              onPressed: () =>
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(ChangeForm(LoginForm.reset)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: valida ? 80 : 48,
                        ),
                        FadeAnimation(
                          2.5,
                          -25.0,
                          Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(30, 28, 27, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: SizedBox.expand(
                              child: FlatButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Sign in",
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Container(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                            'assets/images/Z_icone.png'),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  setState(() => valida =
                                      _formKey.currentState.validate());

                                  if (valida) {
                                    // setState(() => loading = true);
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginSignIn(
                                            SignInPacket(email, senha)));
                                    // dynamic result =
                                    //     await _auth.signIn(email, senha);
                                    // if (result == null) {
                                    //   loading = false;
                                    //   setState(() => error =
                                    //       "email ou senha inválidos");
                                    // }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2.5,
                          -35.0,
                          Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(50, 20, 50, 0),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: SizedBox.expand(
                              child: FlatButton(
                                child: Text(
                                  "Sign Up",
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                onPressed: null, //! DISABLED
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
