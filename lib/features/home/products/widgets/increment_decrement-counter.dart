import 'package:flutter/material.dart';
import 'package:bazario/app/app_colors.dart';

class IncrementDecrementCounter extends StatefulWidget {
  const IncrementDecrementCounter({super.key, required this.onchange});
  final Function(int) onchange;

  @override
  State<IncrementDecrementCounter> createState() => _IncrementDecrementCounterState();
}

class _IncrementDecrementCounterState extends State<IncrementDecrementCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            count == 20
                ? setState(() {
              count--;
              widget.onchange(count);
            })
                : count <= 1
                ? showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Colors.amber
                  )
                ),

                backgroundColor: AppColors.themeColor,
                title: const Text("Counter limit reached"),
                content: const Text("You've reached the minimum limit of 1"),
              ),
            )
                : setState(() {
              count--;
              widget.onchange(count);
            });
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.remove),
          ),
        ),
        Text(
          "$count",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            count < 20
                ? setState(() {
              count++;
              widget.onchange(count);
            })
                : null;
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
