import 'package:todo_app/ui/views/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StackedView<StartUpViewModel> {
 const StartUpView({Key? key}) : super(key: key);

   @override
   Widget builder(
       BuildContext context,
       StartUpViewModel viewModel,
       Widget? child,
       ) {
     return Scaffold(
         body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Stacked Introduction'),
               TextButton(onPressed: () => viewModel.navigateToSignup(), child: Text('Go to Signup')),
               TextButton(onPressed: () => viewModel.navigateToLogin(), child: Text('Go to Login')),
               TextButton(onPressed: () => viewModel.navigateToHome(), child: Text('Go to Home')),
               TextButton(onPressed: () => viewModel.navigateToAddTodo(), child: Text('Go to Add Todo'))
             ],
           ),
         ),
       );
    }
    @override
    StartUpViewModel viewModelBuilder(BuildContext context,) => StartUpViewModel();
}