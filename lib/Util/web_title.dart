import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

void setWebTitle(String title) {
  if (kIsWeb) {
    html.document.title = title;
  }
}
