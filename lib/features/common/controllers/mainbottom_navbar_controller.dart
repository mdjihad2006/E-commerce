import "package:get/get.dart";
class MainBottomVavBarController extends GetxController{
 int _selectedIndex =0;

 int get selectedIndex => _selectedIndex;

 void changeIndex(int index){
   _selectedIndex =index;
   update();
 }
 void moveToCategory(){
   changeIndex(1);
 }
 void backToHome(){
   changeIndex(0);
 }
}