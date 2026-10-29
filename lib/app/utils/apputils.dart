import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils{
 static bool isEmailAddressValid(String email) {

    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

 static String getFormatedDateTime({required String scheduleTime, required String currentFormat, required String newFormat}) {
 try{
   DateTime tempDate = DateFormat(currentFormat).parse(scheduleTime);
   String date = DateFormat(newFormat).format(tempDate);
   return date;
 }catch(e){
   return "";
 }

 }

 // static bool isValidToStartProjectFromTime({required String scheduleTime, required String currentFormat}) {
 //   try{
 //     var schedule = DateFormat(currentFormat).parse(scheduleTime);
 //
 //     DateTime clockInTime = DateTime(
 //         DateTime.now().year,
 //         // The new year you want to set
 //         DateTime.now().month,
 //         DateTime.now().day,
 //         schedule.hour,
 //         schedule.minute,
 //         schedule.second,
 //         schedule.millisecond,
 //         schedule.microsecond);
 //
 //     var now = DateTime.now();
 //     var nowscheduletime;
 //     // if(Platform.isAndroid){
 //     //   nowscheduletime = (schedule.subtract(const Duration(minutes: 5)));
 //     // }else{
 //       nowscheduletime = (clockInTime.subtract(const Duration(minutes: 5)));
 //     // }
 //     if (now.isAfter(nowscheduletime)) {
 //       return true;
 //     }else{
 //       return false;
 //     }
 //   }catch(e){
 //     return false;
 //   }
 //
 //
 //   return false;
 // }

 static bool isValidToStartProjectFromDateTime({
   required String scheduleTime,
   required String currentFormat,
 }) {
   DateTime? schedule;
   try {
     schedule = DateFormat(currentFormat).parse(scheduleTime);
   } catch (e) {
     print(e);
     return false; // Return false if parsing fails
   }

   var now = DateTime.now();
   // Check if the schedule time is at least 5 minutes in the future
   if(now.day==schedule.day&&now.month==schedule.month&&now.year==schedule.year){
     var nowscheduletime;
     // if(Platform.isAndroid){
        nowscheduletime = (schedule.subtract(const Duration(minutes: 5)));
     // }else{
     //    nowscheduletime = (schedule.subtract(const Duration(minutes: 5)));
     // }
     if (now.isAfter(nowscheduletime)) {
       return true;
     }else{
       return false;
     }
   }else{
     return false;
   }
   return false; // Return false if conditions are not met
 }


 Future<void> openMapWithAddress(BuildContext context, String address) async {
   final String googleMapsUrl =
       'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';
   final String appleMapsUrl =
       'https://maps.apple.com/?q=${Uri.encodeComponent(address)}';

   // Check which platform the app is running on
   if (Theme.of(context).platform == TargetPlatform.iOS) {
     if (await canLaunch(appleMapsUrl)) {
       await launch(appleMapsUrl);
     } else {
       throw 'Could not launch $appleMapsUrl';
     }
   } else {
     if (await canLaunch(googleMapsUrl)) {
       await launch(googleMapsUrl);
     } else {
       throw 'Could not launch $googleMapsUrl';
     }
   }
 }
}


