import 'package:bazario/app/app_colors.dart';
import 'package:flutter/Material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.Colors, required this.onchange});

  final List<String> Colors;
  final Function(String) onchange;


  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  String? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.Colors.length,
              itemBuilder: (context,index){
              String color =widget.Colors[index];
          return GestureDetector(
            onTap: (){
              selectedColor=color;
              setState(() {

              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: selectedColor==color?AppColors.themeColor:null,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(color,style: TextStyle(
                color: selectedColor==color?Colors.white:null
              ),),
            ),
          );
          }),
        )
      ],
    );
  }
}
