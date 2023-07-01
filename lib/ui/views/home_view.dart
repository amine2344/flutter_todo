import 'package:todo_app/ui/views/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


class HomeView extends StatelessWidget {
 const HomeView({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<HomeViewModel>.reactive(
     builder: (context, model, child) => Scaffold(
       appBar: AppBar(actions: [
         IconButton(onPressed: () => model.logout(), icon: Icon(Icons.logout_rounded))
       ],),
       body: WillPopScope(
         onWillPop: model.onWillPop,
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text('Stacked Introduction'),
               Text("model.myDeclaration"),
             ],
           ),
         ),
       ),
     ),
     viewModelBuilder: () => HomeViewModel(),
   );
 }
}