import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/views/addTodo_viewmodel.dart';

class AddTodoView extends StatelessWidget {
 AddTodoView({Key? key}) : super(key: key);
 final _titleController = TextEditingController();
 final _descriptionController = TextEditingController();
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
                     typeChip("Important", 0xffabd433, context, model),
                     const SizedBox(
                       width: 20,
                     ),
                     typeChip("Planned", 0xffff33d4, context, model)
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
                     categoryChip("Food", 0xffff6d6e, context, model),
                     const SizedBox(
                       width: 20,
                     ),
                     categoryChip("Work", 0xfff29732, context, model),
                     const SizedBox(
                       width: 20,
                     ),
                     categoryChip("Work out", 0xff6557ff, context, model),
                     const SizedBox(
                       width: 20,
                     ),
                     categoryChip("Shopping", 0xff2bc8d9, context, model)
                   ],
                 ),
                 const SizedBox(
                   height: 50,
                 ),
                 button(context, model)
               ],
             ),
           ),
         ),
       ),
     ),
     viewModelBuilder: () => AddTodoViewModel(),
   );
 }

 Widget button(BuildContext context, AddTodoViewModel model) {
   return InkWell(
     onTap: () => model.addTodo(_titleController.text, _descriptionController.text),
     child: Container(
       height: 56,
       width: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(15),
         gradient: const LinearGradient(
           colors: [
             Color(0xff8a32f1),
             Color(0xffad32f9)
           ]
         )
       ),
       child: Center(
         child: model.isLoading ? const CircularProgressIndicator(
           color: Colors.white,
         ) : const Text(
           "Add Todo",
           style: TextStyle(
             color: Colors.white,
             fontWeight: FontWeight.w600,
             fontSize: 17
           ),
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
       controller: _descriptionController,
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

 Widget typeChip(String text, int color, BuildContext context, AddTodoViewModel model) {
   return InkWell(
     onTap: () => model.updateType(text),
     child: Chip(
       label: Text(
         text,
         style: TextStyle(
           color: model.type == text ? Colors.black :Colors.white,
           fontWeight: FontWeight.w600,
           fontSize: 17
         ),
       ),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15)
       ),
       backgroundColor: model.type == text ? Colors.white : Color(color),
       labelPadding: const EdgeInsets.symmetric(
         horizontal: 17,
         vertical: 3.8
       ),
     ),
   );
 }

 Widget categoryChip(String text, int color, BuildContext context, AddTodoViewModel model) {
   return InkWell(
     onTap: () => model.updateCategory(text),
     child: Chip(
       label: Text(
         text,
         style: TextStyle(
           color: model.category == text ? Colors.black :Colors.white,
           fontWeight: FontWeight.w600,
           fontSize: 17
         ),
       ),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15)
       ),
       backgroundColor: model.category == text ? Colors.white : Color(color),
       labelPadding: const EdgeInsets.symmetric(
         horizontal: 17,
         vertical: 3.8
       ),
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
       controller: _titleController,
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