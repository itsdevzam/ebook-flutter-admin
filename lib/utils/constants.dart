
import 'package:flutter/cupertino.dart';

class Constants{
   static const String appName = "Ebook Admin Panel";
   //don't put slash at end
   static const String baseURL = "http://192.168.0.101:3000";

   static bool isMobile(context) => MediaQuery.of(context).size.width < 600;
   static bool isTablet(context) => MediaQuery.of(context).size.width >= 600
       && MediaQuery.of(context).size.width < 1024;
   static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1024;

   static double getScreenWidth(context) => MediaQuery.of(context).size.width;
}
