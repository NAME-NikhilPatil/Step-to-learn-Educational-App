import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("hi", LocaleData.HI),
  MapLocale("ur", LocaleData.UR),
];

mixin LocaleData {
  static const String title = 'title';
  // static const String body = 'body';
  static const String courses = 'courses';
  static const String hindi = 'hindi';
  static const String maths = 'maths';
  static const String science = 'science';
  static const String english = 'english';
  static const String history = 'history';
  static const String standard1 = 'standard1';
  static const String standard2 = 'standard2';
  static const String standard3 = 'standard3';
  static const String standard4 = 'standard4';
  static const String courseVideo = 'courseVideo';
  static const String nextVideos = 'nextVideos';
  static const String volume = 'volume';
  static const String profile = 'profile';
  static const String materials = 'materials';
  static const String events = 'events';
  static const String quiz = 'quiz';
  static const String mentors = 'mentors';
  static const String contact = 'contact';
  static const String logout = 'logout';
  static const String contactus = 'contactus';
  static const String feedback = 'feedback';
  static const String Study_Center = 'Study_Center';
//  Have an issue  or query? \nFeel free to contact us

  static const Map<String, dynamic> EN = {
    title: 'Learn With AI',
    courses: 'Home',
    hindi: 'Hindi',
    maths: 'Maths',
    science: 'Science',
    english: 'English',
    history: 'History',
    standard1: '1st Standard:Start Learning Now',
    standard2: '2nd Standard:Start Learning Now',
    standard3: '3rd Standard:Start Learning Now',
    standard4: '4th Standard:Start Learning Now',
    courseVideo: 'Course Video',
    nextVideos: 'Next Videos',
    volume: 'Volume',
    profile: 'Profile',
    materials: 'Materials',
    events: 'Events',
    quiz: 'Quiz',
    mentors: 'Mentors',
    contact: 'Contact',
    logout: 'LogOut',
    contactus: 'Contact Us',
    feedback: 'Have an issue  or query? \nFeel free to contact us',
    Study_Center: 'Study Center',
  };

  static const Map<String, dynamic> HI = {
    'title': 'AI के साथ सीखें', // Learn With AI
    'courses': 'होम स्क्रीन', // Courses
    'hindi': 'हिंदी', // Hindi
    'maths': 'गणित', // Maths
    'science': 'विज्ञान', // Science
    'english': 'अंग्रेज़ी', // English
    'history': 'इतिहास', // History
    'standard1':
        'पहली कक्षा: अभी सीखना शुरू करें', // 1st Standard:Start Learning Now
    'standard2':
        'दूसरी कक्षा: अभी सीखना शुरू करें', // 2nd Standard:Start Learning Now
    'standard3':
        'तीसरी कक्षा: अभी सीखना शुरू करें', // 3rd Standard:Start Learning Now
    'standard4':
        'चौथी कक्षा: अभी सीखना शुरू करें', // 4th Standard:Start Learning Now
    'courseVideo': 'पाठ्यक्रम वीडियो', // Course Video
    'nextVideos': 'अगला वीडियो', // Next Videos
    'volume': 'आवाज', // Volume
    'profile': 'प्रोफ़ाइल', // Profile
    'materials': 'सामग्री', // Materials
    'events': 'आयोजन', // Events
    'quiz': 'क्विज', // Quiz
    'mentors': 'निरीक्षक', // Mentors
    'contact': 'संपर्क', // Contact
    'logout': 'लॉग आउट करें', // LogOut
    'contactus': 'हमसे संपर्क करें', // Contact Us
    'feedback':
        'कोई समस्या या प्रश्न है? \nहमसे संपर्क करने में संकोच न करें', // Have an issue  or query? \nFeel free to contact us
    'Study_Center': 'अध्ययन केंद्र'
  };

  static const Map<String, dynamic> UR = {
    'title': 'عنوان', // Learn With AI
    'courses': 'گھر کی سکرین', // Courses
    'hindi': 'اردو', // Hindi
    'maths': 'ریاضی', // Maths
    'science': 'سائنس', // Science
    'english': 'انگریزی',
    // English
    'history': ' اریخ', // History
    'standard1':
        'پہلی جماعت: ابھی سیکھنا شروع کریں', // 1st Standard:Start Learning Now
    'standard2':
        'دوسری جماعت: ابھی سیکھنا شروع کریں', // 2nd Standard:Start Learning Now
    'standard3':
        'تیسری جماعت: ابھی سیکھنا شروع کریں', // 3rd Standard:Start Learning Now
    'standard4':
        'چوتھی جماعت: ابھی سیکھنا شروع کریں', // 4th Standard:Start Learning Now
    'courseVideo': 'کورس ویڈیو', // Course Video
    'nextVideos': 'اگلی ویڈیوز', // Next Videos
    'volume': 'آواز', // Volume
    'profile': 'پروفائل', // Profile
    'materials': 'مواد', // Materials
    'events': 'تقریبات', // Events
    'quiz': 'کوئز', // Quiz
    'mentors': 'رپرست', // Mentors
    'contact': 'رابطہ', // Contact
    'logout': 'لاگ آؤٹ کریں', // LogOut
    'contactus': 'ہمارے سے رابطہ کریں', // Contact Us
    'feedback':
        'کیا کوئی مسئلہ یا سوال ہے؟ \nہمارے سے رابطہ کرنے میں ہچکچائیں نہیں', // Have an issue  or query? \nFeel free to contact us
    'Study_Center': 'اسٹڈی سینٹر'
  };
}
