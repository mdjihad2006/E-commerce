import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:flutter/Material.dart';

class CategoryTItle extends StatelessWidget {
  const CategoryTItle({
    super.key, required this.title, required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme =Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title,style: textTheme.titleMedium?.copyWith(fontSize: 24),), Row(children: [
        TextButton(onPressed: onTap, child: Text(context.localization.seeall)),
        Icon(Icons.double_arrow,color: Colors.black,size: 20,)

      ])],
    );
  }
}
