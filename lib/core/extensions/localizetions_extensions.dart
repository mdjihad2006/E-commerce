import 'package:bazario/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';


extension LocalizetionsExtensions on BuildContext{
  AppLocalizations get localization{
    return AppLocalizations.of(this);
  }
}