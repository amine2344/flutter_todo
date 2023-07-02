import 'package:todo_app/datamodels/todo.dart';
import 'package:todo_app/ui/views/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
 const HomeView({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<HomeViewModel>.reactive(
     builder: (context, model, child) => Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
         backgroundColor: Colors.pinkAccent,
         iconTheme: const IconThemeData(
           color: Colors.white
         ),
         centerTitle: true,
         title: const Text(
           "All Todos",
           style: TextStyle(
             color: Colors.white,
             fontSize: 21,
             fontWeight: FontWeight.w600
           ),
         ),
         actions: [
         IconButton(
             onPressed: () => model.logout(),
             icon: const Icon(
                 Icons.logout_rounded
             )
         )
       ],),
       body: WillPopScope(
         onWillPop: model.onWillPop,
         child: RefreshIndicator(
           onRefresh: () => model.refreshTodos(),
           child: ListView.builder(
             padding: const EdgeInsets.all(8),
             itemCount: model.todos.length + 1,
             itemBuilder: (context, index) {
               if(index < model.todos.length) {
                 Todo todo = model.todos[index];
                 return InkWell(
                   onTap: () => model.navigateToEditTodo(todo),
                   child: TodoCard(
                       todo.title,
                       Icons.audiotrack,
                       '03 AM',
                       todo.completedStatus,
                       Colors.white,
                       Colors.black,
                       context
                   ),
                 );
               }
               else {
                 if(model.moreTodosAvailable) {
                   model.getTodos();
                   return const Padding(
                     padding: EdgeInsets.symmetric(vertical: 32),
                     child: Center(
                       child: CircularProgressIndicator(
                         color: Colors.green,
                       ),
                     ),
                   );
                 }
                 else {
                   return null;
                 }
               }
                 },
               ),
         )
           ),
       bottomNavigationBar: BottomNavigationBar(
         items: [
           const BottomNavigationBarItem(
             label: "Home",
             icon: Icon(Icons.home_filled)
           ),
           BottomNavigationBarItem(
             label: "Add Todo",
             icon: InkWell(
               onTap: () {model.navigateToAddTodo();},
               child: Container(
                 height: 52,
                 width: 52,
                 decoration: const BoxDecoration(
                   shape: BoxShape.circle,
                   gradient: LinearGradient(
                     colors: [
                       Colors.indigoAccent,
                       Colors.purple
                     ]
                   )
                 ),
                 child: const Icon(
                   Icons.add,
                   color: Colors.white,
                   size: 32,
                 ),
               ),
             )
           ),
           const BottomNavigationBarItem(
             label: "Profile",
             icon: Icon(Icons.person)
           )
         ],
       ),
     ),
     viewModelBuilder: () => HomeViewModel(),
   );
 }

 Widget TodoCard(String title, IconData iconData, String time, bool check, Color iconBgColor, Color iconColor, BuildContext context) {
   return Container(
     width: MediaQuery.of(context).size.width,
     child: Row(
       children: [
         Theme(
           data: ThemeData(
             primarySwatch: Colors.blue,
             unselectedWidgetColor: const Color(0xff5e616a)
           ),
           child: Transform.scale(
             scale: 1.5,
             child: Checkbox(
               activeColor: const Color(0xff6cf8a9),
               checkColor: const Color(0xff0e3e26),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
               value: check,
               onChanged: (bool? value) {},
             ),
           ),
         ),
         Expanded(
           child: Container(
             height: 75,
             child: Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12)
               ),
               color: const Color(0xff2a2e3d),
               child: Row(
                 children: [
                   const SizedBox(
                     width: 15,
                   ),
                   Container(
                     height: 33,
                     width: 36,
                     decoration: BoxDecoration(
                       color: iconBgColor,
                       borderRadius: BorderRadius.circular(8)
                     ),
                     child: Icon(
                       iconData,
                       color: iconColor,
                     ),
                   ),
                   SizedBox(
                     width: 20,
                   ),
                   Expanded(
                     child: Text(
                       title,
                       style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.w500,
                         fontSize: 18,
                         letterSpacing: 1
                       ),
                     ),
                   ),
                   Text(
                     time,
                     style: const TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.w500,
                         fontSize: 18,
                         letterSpacing: 1
                     ),
                   ),
                   SizedBox(
                     width: 20,
                   )
                 ],
               ),
             ),
           ),
         )
       ],
     ),
   );
 }
}