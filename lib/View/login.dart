import 'package:flutter/material.dart';

import 'package:guidedlayout2_1604/View/home.dart';
import 'package:guidedlayout2_1604/View/register.dart';
import 'package:guidedlayout2_1604/component/form_component.dart';
import 'package:guidedlayout2_1604/utilities/constant.dart';

class LoginView extends StatefulWidget {


  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;
    return Scaffold(
      backgroundColor: const Color.fromARGB(144, 41, 97, 143),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Atma Salon',
                style: kTextStyle1,
                textAlign: TextAlign.center, // Membuat teks di tengah
              ),
              
              inputForm((p0){
                if (p0 == null || p0.isEmpty){
                  return "username tidak boleh kosong";
                }
                return null;
              },
                  controller: usernameController,
                  hintTXt: "Username",
                  helperTxt: "Inputkan User yang telah didaftar",
                  iconData: Icons.person),
              
              inputForm((p0){ //p0 variabel penampung
                if(p0 == null || p0.isEmpty){
                  return "password kosong";
                }
                return null;
              },
                password: true, //sembunyikan karakter
                controller: passwordController,
                hintTXt: "Password",
                helperTxt: "Inputkan Password",
                iconData: Icons.password),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton( //ada background color
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        if(dataForm!['username'] == usernameController.text && dataForm['password'] == passwordController.text )
                        {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeView()));
                        }else{
                          showDialog(context: context, builder: (_)=>AlertDialog(
                            title: const Text('Password Salah'),

                            content: TextButton(
                              onPressed: () =>pushRegister(context),
                              child: const Text('Daftar Disini !!')),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'), 
                                child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'), 
                                  child: const Text('OK'),
                                ),
                              ],
                          ),);
                        }
                      }
                    }, 
                    child: const Text('Login')),
                  TextButton(
                    onPressed: () {
                        Map<String, dynamic> formData = {};
                        formData['username'] = usernameController.text;
                        formData['password'] = passwordController.text;
                        pushRegister(context);
                    },
                    child: const Text('Belum punya akun ?')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void pushRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterView(),),);
  }
}