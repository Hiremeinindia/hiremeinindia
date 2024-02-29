import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_ta.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ml'),
    Locale('ta')
  ];

  /// No description provided for @findaJob.
  ///
  /// In en, this message translates to:
  /// **'Find a Job'**
  String get findaJob;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @malayalam.
  ///
  /// In en, this message translates to:
  /// **'Malayalam'**
  String get malayalam;

  /// No description provided for @tamil.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get tamil;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SignIn'**
  String get signIn;

  /// No description provided for @blueColler.
  ///
  /// In en, this message translates to:
  /// **'Blue Coller'**
  String get blueColler;

  /// No description provided for @greyColler.
  ///
  /// In en, this message translates to:
  /// **'Grey Coller'**
  String get greyColler;

  /// No description provided for @uploadEssentialDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload Essential Document'**
  String get uploadEssentialDocument;

  /// No description provided for @picture.
  ///
  /// In en, this message translates to:
  /// **'Picture'**
  String get picture;

  /// No description provided for @aadhar.
  ///
  /// In en, this message translates to:
  /// **'Aadhar'**
  String get aadhar;

  /// No description provided for @voterId.
  ///
  /// In en, this message translates to:
  /// **'Voter Id'**
  String get voterId;

  /// No description provided for @experienceProof.
  ///
  /// In en, this message translates to:
  /// **'Experience Proof'**
  String get experienceProof;

  /// No description provided for @cv.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get cv;

  /// No description provided for @currentWage.
  ///
  /// In en, this message translates to:
  /// **'Current Wage'**
  String get currentWage;

  /// No description provided for @currentCity.
  ///
  /// In en, this message translates to:
  /// **'Current City'**
  String get currentCity;

  /// No description provided for @expectedWage.
  ///
  /// In en, this message translates to:
  /// **'Expected Wage'**
  String get expectedWage;

  /// No description provided for @currentState.
  ///
  /// In en, this message translates to:
  /// **'Current State'**
  String get currentState;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @registerAsANewUser.
  ///
  /// In en, this message translates to:
  /// **'Register as a New User'**
  String get registerAsANewUser;

  /// No description provided for @workTitle.
  ///
  /// In en, this message translates to:
  /// **'Work Title'**
  String get workTitle;

  /// No description provided for @aadharNo.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Number'**
  String get aadharNo;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @lookingWork.
  ///
  /// In en, this message translates to:
  /// **'Looking for Work in'**
  String get lookingWork;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @workExperience.
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get workExperience;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @jobClassification.
  ///
  /// In en, this message translates to:
  /// **'Job Classification'**
  String get jobClassification;

  /// No description provided for @jobClassifications.
  ///
  /// In en, this message translates to:
  /// **'Job Classifications'**
  String get jobClassifications;

  /// No description provided for @qualificationSet.
  ///
  /// In en, this message translates to:
  /// **'Qualification Set'**
  String get qualificationSet;

  /// No description provided for @qualificationSets.
  ///
  /// In en, this message translates to:
  /// **'Qualification Sets'**
  String get qualificationSets;

  /// No description provided for @query.
  ///
  /// In en, this message translates to:
  /// **'Query'**
  String get query;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @run.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get run;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @candidates.
  ///
  /// In en, this message translates to:
  /// **'Candidates'**
  String get candidates;

  /// No description provided for @qualification.
  ///
  /// In en, this message translates to:
  /// **'Qualification'**
  String get qualification;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @noOfDaysOpen.
  ///
  /// In en, this message translates to:
  /// **'Number Of Days Open'**
  String get noOfDaysOpen;

  /// No description provided for @cvDocs.
  ///
  /// In en, this message translates to:
  /// **'CV Docs'**
  String get cvDocs;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @gpay.
  ///
  /// In en, this message translates to:
  /// **'G pay'**
  String get gpay;

  /// No description provided for @neft.
  ///
  /// In en, this message translates to:
  /// **'NEFT'**
  String get neft;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @paymentGateway.
  ///
  /// In en, this message translates to:
  /// **'Payment Gateway'**
  String get paymentGateway;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @getHiredFromTheBest.
  ///
  /// In en, this message translates to:
  /// **'Get Hired from the best'**
  String get getHiredFromTheBest;

  /// No description provided for @indiasBestPortalforBlue.
  ///
  /// In en, this message translates to:
  /// **'India\'s best Portal for Blue  '**
  String get indiasBestPortalforBlue;

  /// No description provided for @andGreyCollarJob.
  ///
  /// In en, this message translates to:
  /// **'and Grey Collar Job'**
  String get andGreyCollarJob;

  /// No description provided for @hireNow.
  ///
  /// In en, this message translates to:
  /// **'Hire Now'**
  String get hireNow;

  /// No description provided for @getJob.
  ///
  /// In en, this message translates to:
  /// **'Get Job'**
  String get getJob;

  /// No description provided for @noOfOffers.
  ///
  /// In en, this message translates to:
  /// **'Number of Offers'**
  String get noOfOffers;

  /// No description provided for @noOfProfileVisits.
  ///
  /// In en, this message translates to:
  /// **'Number of Profile Visits'**
  String get noOfProfileVisits;

  /// No description provided for @registerforOther.
  ///
  /// In en, this message translates to:
  /// **'Register for Other'**
  String get registerforOther;

  /// No description provided for @noOfCandidates.
  ///
  /// In en, this message translates to:
  /// **'Number of Candidates'**
  String get noOfCandidates;

  /// No description provided for @noOfCompanies.
  ///
  /// In en, this message translates to:
  /// **'Number of Companies'**
  String get noOfCompanies;

  /// No description provided for @candidatesToday.
  ///
  /// In en, this message translates to:
  /// **'Candidates Today'**
  String get candidatesToday;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @curatedCandidates.
  ///
  /// In en, this message translates to:
  /// **'Curated Candidates'**
  String get curatedCandidates;

  /// No description provided for @selectedCandidates.
  ///
  /// In en, this message translates to:
  /// **'Selected Candidates'**
  String get selectedCandidates;

  /// No description provided for @blueCollerJobs.
  ///
  /// In en, this message translates to:
  /// **'Blue Coller Jobs'**
  String get blueCollerJobs;

  /// No description provided for @greyCollerJobs.
  ///
  /// In en, this message translates to:
  /// **'Grey Coller Jobs'**
  String get greyCollerJobs;

  /// No description provided for @hire.
  ///
  /// In en, this message translates to:
  /// **'Hire'**
  String get hire;

  /// No description provided for @meIn.
  ///
  /// In en, this message translates to:
  /// **'mein'**
  String get meIn;

  /// No description provided for @india.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get india;

  /// No description provided for @currentCountry.
  ///
  /// In en, this message translates to:
  /// **'Current Country'**
  String get currentCountry;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// No description provided for @designation.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get designation;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @corporateconsole.
  ///
  /// In en, this message translates to:
  /// **'Corporate Console'**
  String get corporateconsole;

  /// No description provided for @candidate.
  ///
  /// In en, this message translates to:
  /// **'Candidate'**
  String get candidate;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @loginorpleaseregister.
  ///
  /// In en, this message translates to:
  /// **'Login or Please Register'**
  String get loginorpleaseregister;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'SignUp'**
  String get signup;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @certifiedcourses.
  ///
  /// In en, this message translates to:
  /// **'Certified Courses'**
  String get certifiedcourses;

  /// No description provided for @projectworked.
  ///
  /// In en, this message translates to:
  /// **'Project Worked'**
  String get projectworked;

  /// No description provided for @qualificationdescription.
  ///
  /// In en, this message translates to:
  /// **'Qualification Description'**
  String get qualificationdescription;

  /// No description provided for @newuser.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newuser;

  /// No description provided for @columnview.
  ///
  /// In en, this message translates to:
  /// **'Column View'**
  String get columnview;

  /// No description provided for @multiplefilter.
  ///
  /// In en, this message translates to:
  /// **'Multiple Filter'**
  String get multiplefilter;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @describeaboutyourself.
  ///
  /// In en, this message translates to:
  /// **'Describe about yourself'**
  String get describeaboutyourself;

  /// No description provided for @workdescription.
  ///
  /// In en, this message translates to:
  /// **'Work Description'**
  String get workdescription;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @nocandidateswereadded.
  ///
  /// In en, this message translates to:
  /// **'No candidates were added'**
  String get nocandidateswereadded;

  /// No description provided for @notverified.
  ///
  /// In en, this message translates to:
  /// **'Not Verified'**
  String get notverified;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @curated.
  ///
  /// In en, this message translates to:
  /// **'Curated'**
  String get curated;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @scheduleaninterview.
  ///
  /// In en, this message translates to:
  /// **'Schedule an Interview'**
  String get scheduleaninterview;

  /// No description provided for @makeacall.
  ///
  /// In en, this message translates to:
  /// **'Make a call'**
  String get makeacall;

  /// No description provided for @basicdetails.
  ///
  /// In en, this message translates to:
  /// **'Basic Details'**
  String get basicdetails;

  /// No description provided for @contactnumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactnumber;

  /// No description provided for @emailaddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailaddress;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @downloadcv.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadcv;

  /// No description provided for @downloaddoc.
  ///
  /// In en, this message translates to:
  /// **'Download Documents'**
  String get downloaddoc;

  /// No description provided for @educationalqualification.
  ///
  /// In en, this message translates to:
  /// **'Educational Qualification'**
  String get educationalqualification;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi', 'ml', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
    case 'ml': return AppLocalizationsMl();
    case 'ta': return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
