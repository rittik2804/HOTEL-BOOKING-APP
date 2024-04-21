
import 'package:flutter/material.dart';
import 'package:najara_stays/screens/Home.dart';
import 'package:najara_stays/screens/profile.dart';
import 'package:najara_stays/screens/tophotel.dart';
import 'mybooking.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index = 0;
  bool isSelect = false;
  List screen=[
    Home(),
    Profile(),
    Mybooking(),
    TopHotel()
  ];
  DateTime lastTimeBackbuttonWasClicked = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if (DateTime.now().difference(lastTimeBackbuttonWasClicked) >= Duration(seconds: 2)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press the back button again to go back"),
              duration: Duration(seconds: 2),
            ),
          );
          lastTimeBackbuttonWasClicked = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body:screen[index],
       bottomNavigationBar:Container(
         width: double.infinity,
         height: 70,
         decoration:  BoxDecoration(
           boxShadow: [
             BoxShadow(
                 color: const Color(0xFF0188E2).withOpacity(0.4), //New
                 blurRadius: 5.6,
                 offset: Offset(0, -2))
           ],
         ),
         child: BottomNavigationBar(
           backgroundColor: Colors.white,
           onTap: (_index) {
             setState(() {
               index = _index;
              if (_index == 3) {
                 isSelect = !isSelect;
               } else if (_index == 1) {
               isSelect = false;
               } else if (_index == 0) {
               isSelect = false;
               } else if (_index == 2) {
               isSelect = false;
               } else if (_index == 3) {
               isSelect = false;
               }
             });
           },
           elevation: 10,
           iconSize: 19,
           selectedFontSize: 12,
           unselectedFontSize: 12,
           showSelectedLabels: true,
           selectedIconTheme: IconThemeData(color:Color(0xFF004AAD),),
           currentIndex: index,
           selectedItemColor: Color(0xFF004AAD),
           unselectedItemColor: Colors.black,
           showUnselectedLabels: true,
           type: BottomNavigationBarType.fixed,
           items: [
             const BottomNavigationBarItem(
               icon: Icon(Icons.home_filled),
               label: 'Home',
             ),
             const BottomNavigationBarItem(
               icon: Icon(Icons.person,size: 22,),
               label: 'My Profile',
             ),
             const BottomNavigationBarItem(
               icon: Icon(Icons.calendar_month_outlined),
               label: 'My Booking',
             ),


             BottomNavigationBarItem(
               icon: Image.asset(
                 'assests/tophotel.png',
                 scale: 4.2,
                 color: isSelect==true ? Color(0xFF004AAD) : Colors.black,
               ),
               label: 'Top Lodges',
             ),
           ],
         ),
       ),
      ),
    );
  }
}
