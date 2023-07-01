import 'package:todo_app/ui/views/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
 final TextEditingController emailController = TextEditingController();
 final TextEditingController passwordController = TextEditingController();
 LoginView({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<LoginViewModel>.reactive(
     builder: (context, model, child) => Scaffold(
       body: SingleChildScrollView(
         child: Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           color: Colors.black,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text(
                   "Login",
                   style: TextStyle(
                       fontSize: 35,
                       color: Colors.white,
                       fontWeight: FontWeight.bold
                   )
               ),
               const SizedBox(
                 height: 20,
               ),
               buttonItem('assets/google.svg', "Continue With Google", 25, context, () => model.signinWithGoogle()),
               const SizedBox(
                 height: 15,
               ),
               buttonItem('assets/phone.svg', "Continue With Phone", 25, context, () => model.moveToPhoneAuth()),
               const SizedBox(
                 height: 15,
               ),
               const Text(
                 "OR",
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: 16
                 ),
               ),
               const SizedBox(
                 height: 15,
               ),
               textItem("Email ...", emailController, context),
               const SizedBox(
                 height: 15,
               ),
               textItem("Password ...", passwordController, context),
               const SizedBox(
                 height: 30,
               ),
               colorButton(context, model),
               const SizedBox(
                 height: 20,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text("If you don't have an Account?",
                     style: TextStyle(
                         color: Colors.white,
                         fontSize: 18
                     ),
                   ),
                   InkWell(
                     onTap: () {
                       model.navigateToSignup();
                     },
                     child: const Text('Signup',
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 18,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(
                 height: 10,
               ),
               Text('Fogot Password?',
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: 18,
                     fontWeight: FontWeight.bold
                 ),
               ),
             ],
           ),
         ),
       ),
     ),
     viewModelBuilder: () => LoginViewModel(),
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

 Widget colorButton(BuildContext context, LoginViewModel model) {
   return InkWell(
     onTap: () {
       model.isLoading ? null : model.login(emailController.text, passwordController.text);
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
         child: model.isLoading? CircularProgressIndicator() : Text("Sign In",
           style: TextStyle(
               color: Colors.white,
               fontSize: 20
           ),),
       ),
     ),
   );
 }
 Widget textItem(String labelText,TextEditingController controller, BuildContext context) {
   return Container(
     width: MediaQuery.of(context).size.width - 70,
     height: 55,
     child: TextFormField(
       controller: controller,
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
                   color: Colors.grey
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