import 'package:bazario/app/app_colors.dart';
import 'package:flutter/Material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.onchange, required this.Sizes});

  final List<String> Sizes;
  final Function(String) onchange;


  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {

  String? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Size",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.Sizes.length,
              itemBuilder: (context,index){
                String size =widget.Sizes[index];
                return GestureDetector(
                  onTap: (){
                    selectedColor=size;
                    setState(() {

                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: selectedColor==size?AppColors.themeColor:null,
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(size,style: TextStyle(
                        color: selectedColor==size?Colors.white:null
                    ),),
                  ),
                );
              }),
        )
      ],
    );
  }
}
