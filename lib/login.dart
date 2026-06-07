import 'package:flutter/material.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  @override
  Widget build(BuildContext context) {
    mediaSize=MediaQuery.of(context).size;
    return Container(color: Color(0xff00637c),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top:80,child: _buildTop()),
            Positioned(bottom:0 ,child: _buildBottom()),
          ],
        ),
      ),
    );
  }
    Widget _buildTop(){
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Icons.location_on_sharp,size:100,color:Colors.white),],
      ),
    );

    }
    Widget _buildBottom(){
       return SizedBox(
           width: mediaSize.width,
           child: Card( color: Colors.white, shape: RoundedRectangleBorder( borderRadius:
           BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
           child: Padding(
             padding: const EdgeInsets.all(32),
             child: _buildForm(),
           ),),
       );
       }
       Widget _buildForm() {
         return Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text("Welcome", style: TextStyle(color: Colors.black,
                 fontSize: 32,
                 fontWeight: FontWeight.w500),),
             _buildBlackText("Please login with your information"),
             const SizedBox(height: 60),
             TextFormField(controller: emailcontroller
                 ,onFieldSubmitted: (value){
                   print(value);
                 },onChanged:(value){
                   print(value);
                 } ,keyboardType: TextInputType.emailAddress,decoration: InputDecoration(
                   labelText: "email address"
                  ,prefixIcon:Icon(Icons.email,),)),
             const SizedBox(height: 40),
            TextFormField(controller: passwordcontroller,obscureText: true,onFieldSubmitted:
                (value){print(value);
              },onChanged:(value){
              print(value);} ,keyboardType:
            TextInputType.visiblePassword,decoration: InputDecoration(labelText: " password",
                prefixIcon:Icon(Icons.lock,),suffixIcon: Icon(Icons.remove_red_eye))),
             const SizedBox(height: 20),
             _buildRememberForgot(),
             const SizedBox(height: 20),
             _buildLoginButton(),
           ],
         );
       }

         Widget _buildBlackText(String text) {
           return Text(
             text,
             style: const TextStyle(color: Colors.black),
           );
         }



         Widget _buildRememberForgot() {
           return Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [
                   Checkbox(
                       value: rememberUser,
                       onChanged: (value) {
                         setState(() {
                           rememberUser = value!;
                         });
                       }),
                   _buildBlackText("Remember me"),
                 ],
               ),
               TextButton(
                   onPressed: () {}, child: _buildBlackText("I forgot my password"))
             ],
           );
         }

         Widget _buildLoginButton() {
           return ElevatedButton(
             onPressed: () {

             },
             style: ElevatedButton.styleFrom(
               surfaceTintColor: Colors.white,
               side: BorderSide(color: Colors.black),
               elevation: 20,
               minimumSize: const Size.fromHeight(60),
             ),
             child: const Text("LOGIN", style:TextStyle(color:Colors.black,)),
           );
         }



       }
