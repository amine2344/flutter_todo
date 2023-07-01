import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/views/addTodo_viewmodel.dart';

class AddTodoView extends StatelessWidget {
 const AddTodoView({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<AddTodoViewModel>.reactive(
     builder: (context, model, child) => Scaffold(
       appBar: AppBar(
         iconTheme: const IconThemeData(color: Colors.white, size:30),
         centerTitle: true,
         backgroundColor: Colors.pinkAccent,
         title: const Text(
           "Create Todo",
           style: TextStyle(
             color: Colors.white,
             fontSize: 25,
             fontWeight: FontWeight.bold
           ),
         ),
       ),
       body: SingleChildScrollView(
         child: Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           decoration: const BoxDecoration(
               gradient: LinearGradient(
                   colors: [
                     Color(0xff252041),
                     Color(0xff1d1e26)
                   ]
               )
           ),
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const SizedBox(
                   height: 20,
                 ),
                 label("Task Title",context),
                 const SizedBox(
                   height: 12,
                 ),
                 title(context),
                 const SizedBox(
                   height: 30,
                 ),
                 label("Task Type",context),
                 const SizedBox(
                   height: 12,
                 ),
                 Row(
                   children: [
                     chip("Important", 0xffabd433, context),
                     const SizedBox(
                       width: 20,
                     ),
                     chip("Planned", 0xffff33d4, context)
                   ],
                 ),
                 const SizedBox(
                   height: 25,
                 ),
                 label("Description", context),
                 const SizedBox(
                   height: 12,
                 ),
                 description(context),
                 const SizedBox(
                   height: 25,
                 ),
                 label("Category", context),
                 const SizedBox(
                   height: 12,
                 ),
                 Wrap(
                   runSpacing: 20,
                   children: [
                     chip("Food", 0xffff6d6e, context),
                     const SizedBox(
                       width: 20,
                     ),
                     chip("Work", 0xfff29732, context),
                     const SizedBox(
                       width: 20,
                     ),
                     chip("Work out", 0xff6557ff, context),
                     const SizedBox(
                       width: 20,
                     ),
                     chip("Shopping", 0xff2bc8d9, context)
                   ],
                 ),
                 const SizedBox(
                   height: 50,
                 ),
                 button(context)
               ],
             ),
           ),
         ),
       ),
     ),
     viewModelBuilder: () => AddTodoViewModel(),
   );
 }

 Widget button(BuildContext context) {
   return Container(
     height: 56,
     width: MediaQuery.of(context).size.width,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(15),
       gradient: LinearGradient(
         colors: [
           Color(0xff8a32f1),
           Color(0xffad32f9)
         ]
       )
     ),
     child: Center(
       child: Text(
         "Add Todo",
         style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.w600,
           fontSize: 17
         ),
       ),
     ),
   );
 }

 Widget description(BuildContext context) {
   return Container(
     height: 150,
     width: MediaQuery.of(context).size.width,
     decoration: BoxDecoration(
         color: const Color(0xff2a2e3d),
         borderRadius: BorderRadius.circular(15)
     ),
     child: TextFormField(
       maxLines: null,
       style: const TextStyle(
           color: Colors.grey,
           fontSize: 17
       ),
       decoration: const InputDecoration(
           hintText: "Task Description...",
           hintStyle: TextStyle(
               color: Colors.grey,
               fontSize: 17
           ),
           border: InputBorder.none,
           contentPadding: EdgeInsets.only(
               left: 20,
               right: 20
           )
       ),
     ),
   );
 }

 Widget chip(String text, int color, BuildContext context) {
   return Chip(
     label: Text(
       text,
       style: const TextStyle(
         color: Colors.white,
         fontWeight: FontWeight.w600,
         fontSize: 17
       ),
     ),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15)
     ),
     backgroundColor: Color(color),
     labelPadding: const EdgeInsets.symmetric(
       horizontal: 17,
       vertical: 3.8
     ),
   );
 }

 Widget title(BuildContext context) {
   return Container(
     height: 55,
     width: MediaQuery.of(context).size.width,
     decoration: BoxDecoration(
       color: const Color(0xff2a2e3d),
       borderRadius: BorderRadius.circular(15)
     ),
     child: TextFormField(
       style: const TextStyle(
         color: Colors.grey,
         fontSize: 17
       ),
       decoration: const InputDecoration(
         hintText: "Task Title...",
         hintStyle: TextStyle(
           color: Colors.grey,
           fontSize: 17
         ),
         border: InputBorder.none,
         contentPadding: EdgeInsets.only(
           left: 20,
           right: 20
         )
       ),
     ),
   );
 }

 Widget label(String labelText, BuildContext context) {
   return Text(
     labelText,
     style: const TextStyle(
       fontSize: 17,
       letterSpacing: 0.2,
       fontWeight: FontWeight.w600,
       color: Colors.white
     ),
   );
 }
}