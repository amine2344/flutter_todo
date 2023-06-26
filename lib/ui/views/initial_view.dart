import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/views/initial_viewmodel.dart';

class InitialView extends StatelessWidget {
 const InitialView({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<InitialViewModel>.reactive(
        onViewModelReady: (model) => model.handleStartUpLogic(),
        builder: (context, model, child) => Scaffold(
             backgroundColor: Colors.white,
          body: Center(
            child: Image.asset('assets/initial_picture.png',
              width: 800, height: 800, scale: 0.1,),
          ),
        ),
        viewModelBuilder: () => InitialViewModel(),
   );
 }
}