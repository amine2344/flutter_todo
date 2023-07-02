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
         child: SingleChildScrollView(
           child: Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             padding: EdgeInsets.symmetric(
               horizontal: 20,
               vertical: 20
             ),
             child: Column(
               children: [
                 TodoCard("Let's Dance", Icons.audiotrack, '03 AM', true, Colors.white, Colors.black, context),
                 SizedBox(
                   height: 10,
                 ),
                 TodoCard("Let's Dance", Icons.audiotrack, '03 AM', true, Colors.white, Colors.black, context),
               ],
             ),
           ),
         ),
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
             label: "Settings",
             icon: Icon(Icons.settings)
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
               activeColor: Color(0xff6cf8a9),
               checkColor: Color(0xff0e3e26),
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
               color: Color(0xff2a2e3d),
               child: Row(
                 children: [
                   SizedBox(
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
                     style: TextStyle(
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