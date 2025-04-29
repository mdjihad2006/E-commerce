import 'package:bazario/app/assets_path.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_svg/svg.dart';

class appLogo extends StatelessWidget {
  const appLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsPath.logoSvg,width: 200);
  }
}
