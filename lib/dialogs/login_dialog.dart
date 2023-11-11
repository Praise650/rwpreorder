import 'package:flutter/material.dart';
import 'package:rwk20/core/app_const.dart';
import 'package:rwk20/ui/views/payment_list.dart';
import 'package:rwk20/widgets/input_field.dart';

class LoginDialogWidget extends StatefulWidget {
  const LoginDialogWidget({Key key}) : super(key: key);

  @override
  State<LoginDialogWidget> createState() => _LoginDialogWidgetState();
}

class _LoginDialogWidgetState extends State<LoginDialogWidget> {

  bool loading = false;

  final TextEditingController email = TextEditingController();
  final TextEditingController passwords = TextEditingController();
  final key = GlobalKey<FormState>();

  String wrongDetails = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Login"),
      content: Container(
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.width * .4,
        child: Form(
          key: key,
          child: Column(
            children: [
              InputField(
                controller: email,
                label: "Email",
                lines: 1,
                validator: (val) {
                  if (val.isEmpty)
                    return "This field cannot be empty!";
                  else
                    return null;
                },
              ),
              InputField(
                controller: passwords,
                label: "Password",
                lines: 1,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                validator: (val) {
                  if (val.isEmpty)
                    return "This field cannot be empty!";
                  else
                    return null;
                },
              ),
              SizedBox(height: 10),
              Text(
                wrongDetails,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                  loading == true
                      ? CircularProgressIndicator()
                      : TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                          onPressed: () {
                            setState(() => loading = true);

                            if (key.currentState.validate()) {
                              key.currentState.save();
                              if (email.text == AppConst.username &&
                                  passwords.text == AppConst.password) {
                                setState(() => wrongDetails = '');
                                Future.delayed(Duration(seconds: 4), () {
                                  setState(() => loading = false);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentListView(),
                                    ),
                                  );
                                });
                              } else {
                                setState(() => loading = false);
                                setState(
                                    () => wrongDetails = 'Wrong Input details');
                              }
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
