import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/views/phoneAuth_viewmodel.dart';

class PhoneAuthView extends StatelessWidget {
 PhoneAuthView({Key? key}) : super(key: key);
 final OtpFieldController otpController = OtpFieldController();
 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<PhoneAuthViewModel>.reactive(
     builder: (context, model, child) => Scaffold(
       backgroundColor: Colors.black,
       appBar: AppBar(
         backgroundColor: Colors.black,
         title: Text(
             "Signup",
           style: TextStyle(
             color: Colors.white,
             fontSize: 24
           ),
         ),
         centerTitle: true,
       ),
       body: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         child: SingleChildScrollView(
           child: Column(
             children: [
               SizedBox(
                 height: 120,
               ),
               textField(context, model),
               SizedBox(
                 height: 20,
               ),
               Container(
                 width: MediaQuery.of(context).size.width - 30,
                 child: Row(
                   children: [
                     Expanded(
                       child: Container(
                         height: 1,
                         color: Colors.grey,
                         margin: const EdgeInsets.symmetric(horizontal: 12),
                       ),
                     ),
                     Text(
                         "Enter 6 Digit OTP",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 17
                       ),
                     ),
                     Expanded(
                       child: Container(
                         height: 1,
                         color: Colors.grey,
                         margin: const EdgeInsets.symmetric(horizontal: 12),
                       ),
                     )
                   ],
                 ),
               ),
               SizedBox(
                 height: 30,
               ),
               otpField(context),
               SizedBox(
                 height: 40,
               ),
               RichText(
                 text: TextSpan(
                   children: [
                     TextSpan(
                       text: "Send Otp again in ",
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.yellowAccent
                       )
                     ),
                     TextSpan(
                         text: "00:${model.start}",
                         style: TextStyle(
                             fontSize: 16,
                             color: Colors.pinkAccent
                         )
                     ),
                     TextSpan(
                         text: " sec ",
                         style: TextStyle(
                             fontSize: 16,
                             color: Colors.yellowAccent
                         )
                     )
                   ]
                 ),
               ),
               SizedBox(
                 height: 150,
               ),
               Container(
                 height: 60,
                 width: MediaQuery.of(context).size.width - 60,
                 decoration: BoxDecoration(
                   color: Color(0xffff9601),
                   borderRadius: BorderRadius.circular(15)
                 ),
                 child: Center(
                   child: Text(
                     "Login / Signup",
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.white,
                       fontSize: 19
                     ),
                   ),
                 ),
               )
             ],
           ),
         ),
       ),
     ),
     viewModelBuilder: () => PhoneAuthViewModel(),
   );
 }

 Widget otpField(BuildContext context) {
   return Container(
     child: OTPTextField(
         controller: otpController,
         length: 6,
         width: MediaQuery.of(context).size.width - 34,
         textFieldAlignment: MainAxisAlignment.spaceAround,
         fieldWidth: 58,
         fieldStyle: FieldStyle.box,
         outlineBorderRadius: 15,
         otpFieldStyle: OtpFieldStyle(
           backgroundColor: Color(0xff1d1d1d),
           borderColor: Colors.white
         ),
         style: TextStyle(
             fontSize: 17,
           color: Colors.white
         ),
         onChanged: (pin) {
           print("Changed: " + pin);
         },
         onCompleted: (pin) {
           print("Completed: " + pin);
         }),
   );
 }

 Widget textField(BuildContext context, PhoneAuthViewModel model) {
   return Container(
     width: MediaQuery.of(context).size.width - 40,
     height: 60,
     decoration: BoxDecoration(
       color: Color(0xff1d1d1d),
       borderRadius: BorderRadius.circular(15)
     ),
     child: TextFormField(
       decoration: InputDecoration(
         border: InputBorder.none,
         hintText: "Enter your phone number...",
         hintStyle: TextStyle(
           color: Colors.white54,
           fontSize: 17
         ),
         contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
         prefixIcon: Padding(
           padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
           child: Text(
             " (+91) ",
             style: TextStyle(
                 color: Colors.white,
                 fontSize: 17
             )
           ),
         ),
         suffixIcon: InkWell(
           onTap: () {
             model.otpSent ? null : model.startTimer();
           },
           child: Padding(
             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
             child: Text(
                 model.sendButtonName,
                 style: TextStyle(
                     color: model.otpSent ? Colors.grey : Colors.white,
                     fontSize: 17
                 )
             ),
           ),
         ),
       ),
     ),
   );
}
}