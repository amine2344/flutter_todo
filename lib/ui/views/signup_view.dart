
import 'package:todo_app/ui/views/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SignupView({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {

   return ViewModelBuilder<SignupViewModel>.reactive(
     builder: (context, model, child) => Scaffold(
       body: SingleChildScrollView(
         child: Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           color: Colors.black,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                   "Sign Up",
                   style: TextStyle(
                       fontSize: 35,
                       color: Colors.white,
                       fontWeight: FontWeight.bold
                   )
               ),
               SizedBox(
                 height: 20,
               ),
               buttonItem('assets/google.svg', "Continue With Google", 25, context, () => model.signupWithGoogle()),
               SizedBox(
                 height: 15,
               ),
               buttonItem('assets/phone.svg', "Continue With Phone", 25, context, () => model.moveToPhoneAuth()),
               SizedBox(
                 height: 15,
               ),
               Text(
                 "OR",
                 style: TextStyle(
                 color: Colors.white,
                 fontSize: 16
                ),
               ),
               SizedBox(
                 height: 15,
               ),
               textItem("Email ...", emailController, false, context),
               SizedBox(
                 height: 15,
               ),
               textItem("Password ...", passwordController, true, context),
               SizedBox(
                 height: 30,
               ),
               colorButton(context, model),
               const SizedBox(
                 height: 20,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text('If you already have an Account?',
                     style: TextStyle(
                         color: Colors.white,
                         fontSize: 18
                     ),
                   ),
                   InkWell(
                     onTap: () {
                       model.navigateToLogin();
                     },
                     child: const Text('Login',
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               )
             ],
           ),
         ),
       ),
     ),
     viewModelBuilder: () => SignupViewModel(),
   );
 }
 Widget buttonItem(String imagePath, String buttonName, double size, BuildContext context, Function onTap) {
   return InkWell(
     onTap: () => onTap(),
     child: Container(
       width: MediaQuery.of(context).size.width-60,
       height: 60,
       child: Card(
         color: Colors.black,
         elevation: 8,
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15),
             side: BorderSide(
                 width: 1,
                 color: Colors.grey
             )
         ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SvgPicture.asset(
               imagePath,
               width: size,
               height: size,
             ),
             SizedBox(
               width: 15,
             ),
             Text(
               buttonName,
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 17
               ),)
           ],
         ),
       ),
     ),
   );
 }

 Widget colorButton(BuildContext context, SignupViewModel model) {
   return InkWell(
     onTap: () {
        model.isLoading ? null : model.signup(emailController.text, passwordController.text);
     },
     child: Container(
       width: MediaQuery.of(context).size.width - 90,
       height: 60,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20),
         gradient: LinearGradient(
           colors: [Color(0xfffd746c), Color(0xffff9068), Color(0xfffd746c)]
         )
       ),
       child: Center(
         child: model.isLoading ? CircularProgressIndicator() : Text("Sign Up",
             style: TextStyle(
               color: Colors.white,
               fontSize: 20
             ),),
       ),
     ),
   );
 }

 Widget textItem(String labelText, TextEditingController controller, bool obscureText,  BuildContext context) {
   return Container(
     width: MediaQuery.of(context).size.width - 70,
     height: 55,
     child: TextFormField(
       controller: controller,
       obscureText: obscureText,
       style: TextStyle(
           fontSize: 17,
           color: Colors.white
       ),
       decoration: InputDecoration(
         labelStyle: TextStyle(
           fontSize: 17,
           color: Colors.white
         ),
         focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15),
             borderSide: BorderSide(
                 width: 1,
                 color: Colors.amber
             )
         ),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(15),
           borderSide: BorderSide(
             width: 1,
             color: Colors.grey
           )
         ),
         labelText: labelText
       ),
     ),
   );
 }
}