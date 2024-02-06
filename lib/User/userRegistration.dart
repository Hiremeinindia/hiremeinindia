import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:email_auth/email_auth.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/Providers/session.dart';
import 'package:hiremeinindiaapp/User/userFormState.dart';
import 'package:hiremeinindiaapp/User/userUpload.dart';
import 'package:hiremeinindiaapp/classes/language.dart';
import 'package:hiremeinindiaapp/classes/language_constants.dart';
import 'package:hiremeinindiaapp/gen_l10n/app_localizations.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'package:hiremeinindiaapp/main.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';
import 'package:hiremeinindiaapp/widgets/customtextstyle.dart';
import 'package:hiremeinindiaapp/widgets/hiremeinindia.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server/gmail.dart';
import '../widgets/custombutton.dart';
import 'package:mailer/smtp_server.dart' as smtp;

class Registration extends StatefulWidget {
  const Registration({Key? key, this.candidate, this.selectedOption})
      : super(key: key);
  final String? selectedOption;
  final Candidate? candidate;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late EmailAuth emailAuth;
  late String sessionName = "";
  late String recipientMail = "";
  bool _isVerifiedEmail = false;
  // Define Firebase Config manually

  void initState() {
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
    var remoteServerConfig = {
      "server":
          "https://app-authenticator.herokuapp.com/dart/auth/${recipientMail}?CompanyName=${this.sessionName}",
      "serverKey": "AIzaSyBKUuhUeiA2DpvZD4od15RdHEBZyjsuVlA"
    };

    /// Configuring the remote server
    emailAuth.config(remoteServerConfig);
  }

  void _sendOtp() async {
    final smtpServer =
        smtp.gmail('hiremeinindia@gmail.com', 'jgbh aqnk yxgp qrol');

    String otp = _generateOTP();

    final mailer.Message message = mailer.Message()
      ..from = mailer.Address('hiremeinindia@gmail.com', 'jgbh aqnk yxgp qrol')
      ..recipients.add(controller.email.text)
      ..subject = 'Your OTP for Verification'
      ..text = 'Your OTP is: $otp';

    try {
      final sendReport = await mailer.send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');

      _showOtpDialog(otp);
    } catch (e) {
      print('Error sending OTP: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(
                "Oops, OTP sending failed. Please check your network connection and SMTP server configuration."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  String _generateOTP() {
    Random random = Random();
    String otp = '';
    for (int i = 0; i < 4; i++) {
      otp += random.nextInt(9).toString();
    }
    return otp;
  }

  void _showOtpDialog(String otp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter OTP"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("An OTP has been sent to your email."),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'OTP'),
                onChanged: (value) {
                  if (value.length == 4) {
                    _verifyOtp(value, otp);
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _verifyOtp(String enteredOtp, String actualOtp) {
    if (enteredOtp == actualOtp) {
      setState(() {
        _isVerifiedEmail = true;
      });
      Navigator.of(context).pop(); // Close OTP dialog
      // Proceed with further actions upon successful verification
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid OTP"),
            content: Text("Please enter the correct OTP."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  bool submitValid = false;

  String enteredOTP = '';
  String? gender = "male";
  String smscode = "";
  String phoneNumber = "", data = "", phone = "";
  bool isVerified = false;
  bool isVerifiedEmail = false;
  bool isOtpValid = true; // Replace this line with actual verification logic
  List<String> _values = [];
  List<String> _value = [];
  bool blueChecked = false;
  bool greyChecked = false;
  bool focusTagEnabled = false;
  String password = '';
  late final Candidate? candidate;
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
  // EmailOTP myauth = EmailOTP();
  CandidateFormController controller = CandidateFormController();
  // final TextEditingController _otpController = TextEditingController();

  String? skillvalue;
  String? wokinvalue;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  static const GreySkill = [
    'Plumber',
    'Senior Plumber',
    'Junior Plumber',
    'Skill 1',
    'Electrician',
    'Senior Electrician',
    'Junior Electrician',
    'Skill 2',
  ];
  static const GreyWorkin = [
    'Plumber',
    'Senior Plumber',
    'Junior Plumber',
    'Skill 1',
    'Electrician',
    'Senior Electrician',
    'Junior Electrician',
    'Skill 2',
  ];
  List<String> BlueSkill = [
    'Electrician',
    'Mechanic',
    'Construction Helper ',
    'Meson ',
    'Ac Technician',
    'Telecom Technician',
    'Plumber',
    'Construction Worker',
    'Welder',
    'Fitter',
    'Carpenter',
    'Machine Operators',
    'Operator',
    'Drivers',
    'Painter ',
    'Aircraft mechanic',
    'Security',
    'Logistics Labours',
    'Airport Ground workers',
    'Delivery Workers',
    'Cleaners',
    'Cook',
    'Office Boy',
    'Maid',
    'Collection Staff',
    'Shop Keepers',
    'Electronic repair Technicians ',
    'Barber',
    'Beautician',
    'Catering Workers',
    'Pest Control'
  ];
  List<String> BlueWorkin = [
    'Electrician',
    'Mechanic',
    'Construction Helper ',
    'Meson ',
    'Ac Technician',
    'Telecom Technician',
    'Plumber',
    'Construction Worker',
    'Welder',
    'Fitter',
    'Carpenter',
    'Machine Operators',
    'Operator',
    'Drivers',
    'Painter ',
    'Aircraft mechanic',
    'Security',
    'Logistics Labours',
    'Airport Ground workers',
    'Delivery Workers',
    'Cleaners',
    'Cook',
    'Office Boy',
    'Maid',
    'Collection Staff',
    'Shop Keepers',
    'Electronic repair Technicians ',
    'Barber',
    'Beautician',
    'Catering Workers',
    'Pest Control'
  ];
  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  _onDeletee(indexx) {
    _value.removeAt(indexx);
  }

  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  dispose() {
    controller.name.dispose();
    super.dispose();
  }

  bool isValidName(String name) {
    final RegExp nameRegExp = RegExp(r"^[A-Za-z']+([- ][A-Za-z']+)*$");
    return nameRegExp.hasMatch(name);
  }

  bool isValidWorkexp(String workexp) {
    final RegExp pattern = RegExp(r"^[A-Za-z0-9]+$");
    return pattern.hasMatch(workexp);
  }

  String? workexpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidWorkexp(value)) {
      return 'Invalid format';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidName(value)) {
      return 'Invalid format';
    }
    return null;
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(errorMessage),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  _showAlert(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text("Current Location Not Available"),
        content:
            Text("Your current location cannot be determined at this time."),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  _showVerificationSuccessDialog(BuildContext context) {
    print("verified1");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        print("verified2");
        return AlertDialog(
          title: Text('Verification Successful'),
          content:
              Text('Congratulations! Your mobile number has been verified.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print("verified3");
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _signInWithMobileNumber() async {
    print("register1");
    String mobileNumber = controller.mobile.text;
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      print("register2");
      // Check if the mobile number is already registered in Firebase Realtime Database
      bool isNumberRegistered = await checkIfNumberRegistered(mobileNumber);
      print('Is Number Registered: $isNumberRegistered');

      if (isNumberRegistered) {
        print("register3");
        print("number registered ");
        // Display a popup message if the number is already registered
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Mobile Number Already Registered"),
            content: Text("Try another number for registration"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      } else {
        // If the number is not registered, proceed with phone number verification
        await _auth.verifyPhoneNumber(
          phoneNumber: "+91${controller.mobile.text}",
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              Navigator.pop(context);
              setState(() {
                isVerified = true;
              });
            });
          },
          verificationFailed: (FirebaseAuthException error) {
            print("Verification Failed: ${error.message}");
          },
          codeSent: (String verificationId, [int? forceResendingToken]) {
            // Store the verification ID for later use (e.g., resend OTP)
            // You can use the verificationId in your app to implement features like OTP resend.
            // For simplicity, this example does not include resend functionality.
            String storedVerificationId = verificationId;

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Enter OTP"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller.code,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      String smsCode = controller.code.text;
                      PhoneAuthCredential _credential =
                          PhoneAuthProvider.credential(
                        verificationId: storedVerificationId,
                        smsCode: smsCode,
                      );

                      auth.signInWithCredential(_credential).then((result) {
                        Navigator.pop(context);

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Verified'),
                          ],
                        );
                      }).catchError((e) {
                        print("Error signing in with credential: $e");
                        showErrorDialog(
                            "Invalid verification code. Please enter the correct code.");
                      });
                    },
                    child: Text("Done"),
                  ),
                ],
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
          timeout: Duration(seconds: 45),
        );
      }
    } catch (e) {
      print("Error during phone number verification: $e");
      showErrorDialog(
          "Error during phone number verification. Please try again.");
    }
    return false;
  }

  Future<bool> checkUserInBlocklist(String mobileNumber) async {
    // Implement the logic to check if the user is in the blocklist
    // For example, you can use the DatabaseService class mentioned earlier
    return await DatabaseService().isUserInBlocklist(mobileNumber);
  }

  Future<bool> _verifyOtp1(String otp) async {
    // Implement your OTP verification logic here
    // Return true if OTP is valid, false otherwise
    // For example, you might make an API call to your server for verification
    // Replace the following line with your actual verification logic
    bool isOtpValid = (otp == '1234'); // Replace '1234' with the correct OTP
    return isOtpValid;
  }

  Future<bool> checkIfNumberRegistered(String mobileNumber) async {
    print("check1");
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    String path = 'users';

    try {
      print("check2");
      DatabaseEvent databaseEvent = await databaseReference.child(path).once();
      DataSnapshot dataSnapshot = databaseEvent.snapshot;
      print("DataSnapshot: $dataSnapshot");

      if (dataSnapshot.value == null) {
        print("DataSnapshot is null");
        return false;
      }

      if (dataSnapshot.value != null) {
        print("check3");
        Map<dynamic, dynamic>? usersData =
            dataSnapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          print("check4: usersData: $usersData");
          // Check if the mobile number is already registered
          bool isNumberRegistered = usersData.values.any((userData) {
            // Ensure 'mobileNumber' is not null and not an empty string
            return userData['mobile'].toString() == mobileNumber;
          });

// Return true if the number is registered
          return isNumberRegistered;
        }
      }

      // Explicitly return false if dataSnapshot.value is null or usersData is null
      print("DataSnapshot or usersData is null");
      return false;
    } catch (error) {
      print("check5");
      print('Error checking if number is registered: $error');
      return false;
    }
  }

  Future<void> _showOtpDialog1(
      BuildContext context, String mobileNumber) async {
    print("dialog1");
    String otp = ''; // Use a variable to store the entered OTP

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP for $mobileNumber'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    otp = value;
                  },
                  decoration: InputDecoration(labelText: 'OTP'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                print("phone1");
                // Perform verification logic with entered OTP
                // For example, you can call a function like _verifyOtp(otp)
                // and handle the verification process there.
                bool isOtpValid = await _verifyOtp1(otp);

                if (isOtpValid) {
                  print("otp1");
                  // Update UI after successful verification
                  Navigator.of(context).pop(); // Close the dialog
                  _showVerificationSuccessDialog(context);
                } else {
                  print("otp2");
                  // Handle case where OTP verification fails
                  // You can show an error message or take other actions
                  print('Incorrect OTP');
                  // Optionally, show an error message to the user
                }
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  // Future<void> fetchData() async {
  //   final response = await http.get(Uri.parse('https://example.com/api/data'));
  //   if (response.statusCode == 200) {
  //     // Handle successful response
  //   } else {
  //     // Handle error response
  //     print('Request failed with status: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HireMeInIndia(),
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 50.0, top: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<Language>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  translation(context).english,
                                  style: CustomTextStyle.dropdowntext,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          onChanged: (Language? language) async {
                            if (language != null) {
                              Locale _locale =
                                  await setLocale(language.languageCode);
                              HireApp.setLocale(context, _locale);
                            } else {
                              language;
                            }
                          },
                          items: Language.languageList()
                              .map<DropdownMenuItem<Language>>(
                                (e) => DropdownMenuItem<Language>(
                                  value: e,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        e.flag,
                                        style: CustomTextStyle.dropdowntext,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        e.langname,
                                        style: CustomTextStyle.dropdowntext,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          buttonStyleData: ButtonStyleData(
                            height: 30,
                            width: 200,
                            elevation: 1,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Colors.indigo.shade900,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                            ),
                            iconSize: 25,
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: null,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 210,
                            width: 156,
                            elevation: 0,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black),
                              color: Colors.indigo.shade900,
                            ),
                            scrollPadding: EdgeInsets.all(5),
                            scrollbarTheme: ScrollbarThemeData(
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 25,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  height: 30,
                  width: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Option 1',
                              child: Text('Option 1'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Option 2',
                              child: Text('Option 1'),
                            ),
                            // Add more options as needed
                          ],
                          onChanged: (value) {
                            // Handle option selection
                          },
                          hint: Text(
                            AppLocalizations.of(context)!.findaJob,
                            style: TextStyle(color: Colors.white),
                          ),
                          buttonStyleData: ButtonStyleData(
                            height: 30,
                            width: 200,
                            elevation: 1,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Colors.indigo.shade900,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                            ),
                            iconSize: 25,
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: null,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 210,
                            width: 156,
                            elevation: 0,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black),
                              color: Colors.indigo.shade900,
                            ),
                            scrollPadding: EdgeInsets.all(5),
                            scrollbarTheme: ScrollbarThemeData(
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 25,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                SizedBox(
                  height: 38,
                  width: 38,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline_outlined,
                          size: 35,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'User',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.indigo.shade900,
                            height: 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 160),
                child: Row(
                  children: [
                    if (widget.selectedOption == 'Blue')
                      Row(
                        children: [
                          Radio(
                            value: widget.selectedOption,
                            groupValue: widget.selectedOption,
                            onChanged: (value) {
                              // Handle radio button state change if needed
                              setState(() {
                                controller.selectedOption.text =
                                    value.toString();
                              });
                            },
                          ),
                          Text(
                            'Blue Collar',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          IgnorePointer(
                            child: Radio(
                                value: widget.selectedOption,
                                groupValue: controller.selectedOption.text,
                                onChanged: null),
                          ),
                          IgnorePointer(
                            child: Text(
                              'Grey Collar',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    else if (widget.selectedOption == 'Grey')
                      Row(
                        children: [
                          IgnorePointer(
                            child: Radio(
                                value: widget.selectedOption,
                                groupValue: controller.selectedOption.text,
                                onChanged: null),
                          ),
                          IgnorePointer(
                            child: Text(
                              'Blue Collar',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Radio(
                            value: widget.selectedOption,
                            groupValue: widget.selectedOption,
                            onChanged: (value) {
                              // Handle radio button state change if needed
                              setState(() {
                                controller.selectedOption.text =
                                    value.toString();
                              });
                            },
                          ),
                          Text(
                            'Grey Collar',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              SizedBox(height: 37),
              Padding(
                padding: const EdgeInsets.only(left: 160),
                child: Row(
                  children: [
                    Text(
                      translation(context).registerAsANewUser,
                      style: TextStyle(fontSize: 30, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 170, right: 170),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).name,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 60),
                              Text(
                                translation(context).workTitle,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 60),
                              Text(
                                translation(context).aadhar,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CustomTextfield(
                                  // validator: nameValidator,
                                  controller: controller.name,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  // validator: nameValidator,
                                  controller: controller.worktitle,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return '*Required';
                                  //   } else if (value.length != 12) {
                                  //     return 'Aadhar Number must be of 12 digit';
                                  //   }
                                  //   return null;
                                  // },
                                  controller: controller.aadharno,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 43,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).gender,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 60),
                              Text(
                                translation(context).workExperience,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 60),
                              Text(
                                translation(context).qualification,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 28,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text("Male"),
                                        value: "male",
                                        groupValue: controller.gender.text,
                                        onChanged: (String? value) {
                                          setState(() {
                                            controller.gender.text = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text("Female"),
                                        value: "female",
                                        groupValue: controller.gender.text,
                                        onChanged: (String? value) {
                                          setState(() {
                                            controller.gender.text = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text("Others"),
                                        value: "others",
                                        groupValue: controller.gender.text,
                                        onChanged: (String? value) {
                                          setState(() {
                                            controller.gender.text = value!;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  // validator: workexpValidator,
                                  controller: controller.workexp,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 700,
                                  height: 35,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      value: controller
                                              .qualification.text.isNotEmpty
                                          ? controller.qualification.text
                                          : 'Nill', // Provide a default value if it's empty
                                      items: <String>[
                                        'Nill',
                                        'ITI',
                                        'Diploma',
                                        '10th Pass',
                                        '12th Pass',
                                        'Under Graduate',
                                        'Post Graduate'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          // Step 2: Update controller when dropdown value changes
                                          controller.qualification.text =
                                              newValue!;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 30,
                                        width: 200,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                        ),
                                        iconSize: 25,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: null,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 210,
                                        width: 250,
                                        elevation: 1,
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.white,
                                        ),
                                        scrollPadding: EdgeInsets.all(5),
                                        scrollbarTheme: ScrollbarThemeData(
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 25,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(children: [
                        Text(
                          translation(context).address,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 60),
                        Expanded(
                            child: CustomTextfield(
                          // validator: workexpValidator,
                          controller: controller.address,
                        )),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                          width: 70,
                        ),
                        Text(
                          translation(context).password,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 60),
                        Expanded(
                            child: CustomTextfield(
                          // validator: validatePassword,
                          onsaved: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          controller: controller.password,
                        )),
                      ]),
                      SizedBox(
                        height: 45,
                      ),
                      Row(children: [
                        Text(
                          translation(context).mobile,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 65),
                        Expanded(
                            child: CustomTextfield(
                          controller: controller.mobile,
                          // validator: (value) {
                          //   if (value!.length != 10)
                          //     return 'Mobile Number must be of 10 digit';
                          //   else
                          //     return null;
                          // },
                        )),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigo.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.1),
                              ),
                            ),
                            onPressed: () async {
                              print("phone1");
                              String mobileNumber = controller.mobile.text;
                              print(mobileNumber);

                              // Check if the user is already registered or in the blocklist
                              bool isUserRegistered =
                                  await _signInWithMobileNumber();
                              print('Is User Registered: $isUserRegistered');

                              // Update the button text to "Verified" if isUserRegistered is false
                              setState(() {
                                isVerified = !isUserRegistered;
                              });

                              // If the verification is successful, show the "Verified" button
                              if (!isUserRegistered) {
                                // Proceed with OTP verification logic here...
                                // When OTP is successfully verified, set isVerified to true
                                // Example:
                                // isVerified = true;
                              }
                            },
                            child: isVerified
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text(
                                        translation(context).verified,
                                      ),
                                    ],
                                  )
                                : Text(
                                    translation(context).verify,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                          width: 70,
                        ),
                        Text(
                          translation(context).email,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 55),
                        Expanded(
                            child: CustomTextfield(
                          controller: controller.email,

                          validator: emailValidator,
                          //(val) {
                          //   if (AppSession()
                          //       .candidates
                          //       .where((element) =>
                          //           element.email!.toLowerCase() ==
                          //           val?.toLowerCase())
                          //       .isNotEmpty) {
                          //     return "Already User Exist";
                          //   }
                          //   ;
                          //   MultiValidator([
                          //     RequiredValidator(errorText: "* Required"),
                          //     EmailValidator(
                          //         errorText: "Enter valid email id"),
                          //   ]);
                          //   return null;
                          // }
                        )),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigo.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.1),
                              ),
                            ),
                            onPressed: () async {
                              String otp = "";
                              print("otp1");

                              // Set OTP configuration
                              // myauth.setConfig(
                              //   appEmail: "contact@hdevcoder.com",
                              //   appName: "OTP for Registration",
                              //   userEmail: controller.email.text,
                              //   otpLength: 4,
                              //   otpType: OTPType.digitsOnly,
                              // );

                              _showOtpDialog(otp);

                              // // Send OTP to email
                              // bool otpSent = await myauth.sendOTP();

                              // // Show OTP entry dialog

                              // // Check if OTP sending is successful
                              // if (!otpSent) {
                              //   // Display error pop-up for failed OTP sending
                              //   showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return AlertDialog(
                              //         title: Text("Error"),
                              //         content:
                              //             Text("Oops, OTP sending failed."),
                              //         actions: <Widget>[
                              //           TextButton(
                              //             onPressed: () {
                              //               Navigator.of(context).pop();
                              //             },
                              //             child: Text("OK"),
                              //           ),
                              //         ],
                              //       );
                              //     },
                              //   );
                              // }
                            },
                            child: isVerifiedEmail
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text(
                                        translation(context).verified,
                                      ),
                                    ],
                                  )
                                : Text(
                                    translation(context).verify,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 40,
                      ),
                      widget.selectedOption == 'Blue'
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      translation(context).skills,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: controller.skills
                                          .map(
                                            (value) => Chip(
                                              backgroundColor:
                                                  Colors.indigo.shade900,
                                              label: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onDeleted: () {
                                                setState(() {
                                                  controller.skills
                                                      .remove(value);
                                                });
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              value: skillvalue,
                                              buttonStyleData: ButtonStyleData(
                                                height: 30,
                                                width: 200,
                                                elevation: 1,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: Colors.black26,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                ),
                                                iconSize: 25,
                                                iconEnabledColor: Colors.white,
                                                iconDisabledColor: null,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 210,
                                                width: 300,
                                                elevation: 0,
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.indigo.shade900,
                                                ),
                                                scrollPadding:
                                                    EdgeInsets.all(5),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
                                                ),
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                height: 25,
                                                padding: EdgeInsets.only(
                                                    left: 14, right: 14),
                                              ),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              underline: Container(
                                                height: 0,
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  int selectionLimit = 2;
                                                  if (newValue != null &&
                                                      controller.skills.length <
                                                          selectionLimit) {
                                                    if (!controller.skills
                                                        .contains(newValue)) {
                                                      controller.skills
                                                          .add(newValue);
                                                    }
                                                  }
                                                });
                                              },
                                              items: BlueSkill.map<
                                                  DropdownMenuItem<String>>(
                                                (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      translation(context).lookingWork,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: controller.workins
                                          .map(
                                            (value) => Chip(
                                              backgroundColor:
                                                  Colors.indigo.shade900,
                                              label: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onDeleted: () {
                                                setState(() {
                                                  controller.workins
                                                      .remove(value);
                                                });
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            value: wokinvalue,
                                            buttonStyleData: ButtonStyleData(
                                              height: 30,
                                              width: 200,
                                              elevation: 1,
                                              padding: const EdgeInsets.only(
                                                  left: 14, right: 14),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down_sharp,
                                              ),
                                              iconSize: 25,
                                              iconEnabledColor: Colors.white,
                                              iconDisabledColor: null,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              maxHeight: 210,
                                              width: 300,
                                              elevation: 0,
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black),
                                                color: Colors.indigo.shade900,
                                              ),
                                              scrollPadding: EdgeInsets.all(5),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                thickness: MaterialStateProperty
                                                    .all<double>(6),
                                                thumbVisibility:
                                                    MaterialStateProperty.all<
                                                        bool>(true),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              height: 25,
                                              padding: EdgeInsets.only(
                                                  left: 14, right: 14),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            underline: Container(
                                              height: 0,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                if (newValue != null &&
                                                    !controller.workins
                                                        .contains(newValue)) {
                                                  controller.workins
                                                      .add(newValue);
                                                }
                                              });
                                            },
                                            items: BlueWorkin.map<
                                                    DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      translation(context).skills,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: controller.skills
                                          .map(
                                            (value) => Chip(
                                              backgroundColor:
                                                  Colors.indigo.shade900,
                                              label: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onDeleted: () {
                                                setState(() {
                                                  controller.skills
                                                      .remove(value);
                                                });
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              value: skillvalue,
                                              buttonStyleData: ButtonStyleData(
                                                height: 30,
                                                width: 200,
                                                elevation: 1,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: Colors.black26,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                ),
                                                iconSize: 25,
                                                iconEnabledColor: Colors.white,
                                                iconDisabledColor: null,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 210,
                                                width: 300,
                                                elevation: 0,
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: Colors.indigo.shade900,
                                                ),
                                                scrollPadding:
                                                    EdgeInsets.all(5),
                                                scrollbarTheme:
                                                    ScrollbarThemeData(
                                                  thickness:
                                                      MaterialStateProperty.all<
                                                          double>(6),
                                                  thumbVisibility:
                                                      MaterialStateProperty.all<
                                                          bool>(true),
                                                ),
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                height: 25,
                                                padding: EdgeInsets.only(
                                                    left: 14, right: 14),
                                              ),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              underline: Container(
                                                height: 0,
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  int selectionLimit = 2;
                                                  if (newValue != null &&
                                                      controller.skills.length <
                                                          selectionLimit) {
                                                    if (!controller.skills
                                                        .contains(newValue)) {
                                                      controller.skills
                                                          .add(newValue);
                                                    }
                                                  }
                                                });
                                              },
                                              items: GreySkill.map<
                                                  DropdownMenuItem<String>>(
                                                (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      translation(context).lookingWork,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: controller.workins
                                          .map(
                                            (value) => Chip(
                                              backgroundColor:
                                                  Colors.indigo.shade900,
                                              label: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onDeleted: () {
                                                setState(() {
                                                  controller.workins
                                                      .remove(value);
                                                });
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            value: wokinvalue,
                                            buttonStyleData: ButtonStyleData(
                                              height: 30,
                                              width: 200,
                                              elevation: 1,
                                              padding: const EdgeInsets.only(
                                                  left: 14, right: 14),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.arrow_drop_down_sharp,
                                              ),
                                              iconSize: 25,
                                              iconEnabledColor: Colors.white,
                                              iconDisabledColor: null,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              maxHeight: 210,
                                              width: 300,
                                              elevation: 0,
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black),
                                                color: Colors.indigo.shade900,
                                              ),
                                              scrollPadding: EdgeInsets.all(5),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                thickness: MaterialStateProperty
                                                    .all<double>(6),
                                                thumbVisibility:
                                                    MaterialStateProperty.all<
                                                        bool>(true),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              height: 25,
                                              padding: EdgeInsets.only(
                                                  left: 14, right: 14),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            underline: Container(
                                              height: 0,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                if (newValue != null &&
                                                    !controller.workins
                                                        .contains(newValue)) {
                                                  controller.workins
                                                      .add(newValue);
                                                }
                                              });
                                            },
                                            items: GreyWorkin.map<
                                                    DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            text: translation(context).back,
                            onPressed: () {},
                          ),
                          SizedBox(width: 50),
                          CustomButton(
                            text: translation(context).next,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String name = controller.name.text;
                                String email = controller.email.text.trim();
                                String password = controller.password.text;
                                String mobile = controller.mobile.text;
                                String worktitle = controller.worktitle.text;
                                String adharno = controller.aadharno.text;
                                String gender = controller.gender.text;
                                String workexp = controller.workexp.text;
                                String qualification =
                                    controller.qualification.text;
                                String address = controller.address.text;
                                List<String> workins = controller.workins;
                                List<String> skills = controller.skills;
                                String? selectedOption = widget.selectedOption;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewUserUpload(
                                      name: name,
                                      email: email,
                                      password: password,
                                      mobile: mobile,
                                      workexp: workexp,
                                      workins: workins,
                                      worktitle: worktitle,
                                      skills: skills,
                                      address: address,
                                      aadharno: adharno,
                                      qualification: qualification,
                                      selectedOption: selectedOption,
                                      gender: gender,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  bool isValidEmail(String email) {
    // Regular expression for basic email validation
    // This is a simple example and may not cover all valid email formats
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }
}

class DatabaseService {
  Future<bool> isUserRegistered(String mobileNumber) async {
    bool userExists = await yourDatabaseQueryToCheckUserExists(mobileNumber);
    return userExists;
  }

  Future<bool> isUserInBlocklist(String mobileNumber) async {
    bool userInBlocklist = await yourBlocklistQueryToCheckUser(mobileNumber);
    return userInBlocklist;
  }

  Future<bool> yourDatabaseQueryToCheckUserExists(String mobileNumber) async {
    return false;
  }

  Future<bool> yourBlocklistQueryToCheckUser(String mobileNumber) async {
    return false;
  }
}
