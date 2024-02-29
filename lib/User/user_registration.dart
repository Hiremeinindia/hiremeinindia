import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/User/user_form_state.dart';
import 'package:hiremeinindiaapp/User/user_upload.dart';
import 'package:hiremeinindiaapp/classes/language_constants.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';
import 'package:hiremeinindiaapp/widgets/hiremeinindia.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:sizer/sizer.dart';
import '../loginpage.dart';
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
  bool submitValid = false;
  String enteredOTP = '';
  String? gender = "male";
  String smscode = "";
  String phoneNumber = "";
  String data = "";
  String phone = "";
  String? skillvalue;
  String? wokinvalue;
  bool isVerified = false;
  bool isSkillSelect = false;
  bool isWorkinSelect = false;
  bool isVerifiedEmail = false;
  bool isOtpValid = true;
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

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> GreySkill = [
    'Plumber',
    'Senior Plumber',
    'Junior Plumber',
    'Skill 1',
    'Electrician',
    'Senior Electrician',
    'Junior Electrician',
    'Skill 2',
  ];
  List<String> GreyWorkin = [
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
        isVerifiedEmail = true;
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

  bool isValidName(String name) {
    final RegExp nameRegExp = RegExp(r"^[A-Za-z']+([- ][A-Za-z']+)*$");
    return nameRegExp.hasMatch(name);
  }

  bool isValidWorkexp(String workexp) {
    final RegExp pattern = RegExp(r"^[A-Za-z0-9]+$");
    return pattern.hasMatch(workexp);
  }

  bool isValidEmail(String email) {
    // Regular expression for basic email validation
    // This is a simple example and may not cover all valid email formats
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
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

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidEmail(value)) {
      return 'Invalid email format';
    }
    return null;
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
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
        child: Dialog(
          // The Dialog widget provides a full-page overlay
          child: Material(
            elevation: 4,
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              if (constraints.maxWidth >= 870) {
                return Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: ImageIcon(
                                  NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/cancel.png?alt=media&token=951094e2-a6f9-46a3-96bc-ddbb3362f08c',
                                  ),
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  2.5.w, 2.5.h, 2.5.w, 2.5.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                          );
                                        },
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.indigo.shade900,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.8.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(3.w, 0, 3.w, 0.5.h),
                                    child: Row(
                                      children: [
                                        if (widget.selectedOption == 'Blue')
                                          Row(
                                            children: [
                                              Radio(
                                                value: widget.selectedOption,
                                                groupValue:
                                                    widget.selectedOption,
                                                onChanged: (value) {
                                                  // Handle radio button state change if needed
                                                  setState(() {
                                                    controller.selectedOption
                                                            .text =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                translation(context).blueColler,
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IgnorePointer(
                                                child: Radio(
                                                    value:
                                                        widget.selectedOption,
                                                    groupValue: controller
                                                        .selectedOption.text,
                                                    onChanged: null),
                                              ),
                                              IgnorePointer(
                                                child: Text(
                                                  translation(context)
                                                      .greyColler,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                        else if (widget.selectedOption ==
                                            'Grey')
                                          Row(
                                            children: [
                                              IgnorePointer(
                                                child: Radio(
                                                    value:
                                                        widget.selectedOption,
                                                    groupValue: controller
                                                        .selectedOption.text,
                                                    onChanged: null),
                                              ),
                                              IgnorePointer(
                                                child: Text(
                                                  translation(context)
                                                      .blueColler,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Radio(
                                                value: widget.selectedOption,
                                                groupValue:
                                                    widget.selectedOption,
                                                onChanged: (value) {
                                                  // Handle radio button state change if needed
                                                  setState(() {
                                                    controller.selectedOption
                                                            .text =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                translation(context).greyColler,
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        3.w, 0.6.h, 3.w, 0.5.h),
                                    child: Column(
                                      children: [
                                        Divider(color: Colors.black),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              translation(context)
                                                  .registerAsANewUser,
                                              textScaleFactor:
                                                  ScaleSize.textScaleFactor(
                                                      context),
                                              style: TextStyle(
                                                  fontFamily: 'Colfax',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  translation(context).name,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context).age,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context).email,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context).address,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .workExperience,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .workdescription,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .qualificationdescription,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CustomTextfield(
                                                    text: 'First Name',
                                                    //                 validator: nameValidator,
                                                    controller: controller.name,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Age',
                                                    //                validator: nameValidator,
                                                    controller: controller.age,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Email address',
                                                    controller:
                                                        controller.email,
                                                    //              validator: emailValidator,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Address',
                                                    //                   validator: nameValidator,
                                                    controller:
                                                        controller.address,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton2<String>(
                                                      value: controller
                                                              .workexpcount
                                                              .text
                                                              .isNotEmpty
                                                          ? controller
                                                              .workexpcount.text
                                                          : 'Select', // Provide a default value if it's empty
                                                      items: <String>[
                                                        'Select',
                                                        '1 Month',
                                                        '2 Months',
                                                        '3 Months',
                                                        '4 Months',
                                                        '5 Months',
                                                        '6 Months',
                                                        '1 Year',
                                                        '2 Years',
                                                        'More than 2 Years'
                                                      ].map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      12)),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          // Step 2: Update controller when dropdown value changes
                                                          controller
                                                              .workexpcount
                                                              .text = newValue!;
                                                        });
                                                      },
                                                      buttonStyleData:
                                                          ButtonStyleData(
                                                        height: 45,
                                                        width: 30.w,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 14,
                                                                right: 14),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade500),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      iconStyleData:
                                                          const IconStyleData(
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_drop_down_sharp,
                                                        ),
                                                        iconSize: 25,
                                                        iconEnabledColor:
                                                            Colors.black,
                                                        iconDisabledColor: null,
                                                      ),
                                                      dropdownStyleData:
                                                          DropdownStyleData(
                                                        elevation: 0,
                                                        maxHeight: 200,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 5,
                                                                bottom: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade500),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                        scrollPadding:
                                                            EdgeInsets.all(5),
                                                        scrollbarTheme:
                                                            ScrollbarThemeData(
                                                          thickness:
                                                              MaterialStateProperty
                                                                  .all<double>(
                                                                      6),
                                                          thumbVisibility:
                                                              MaterialStateProperty
                                                                  .all<bool>(
                                                                      true),
                                                        ),
                                                      ),
                                                      menuItemStyleData:
                                                          MenuItemStyleData(
                                                        height: 30,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 14,
                                                                right: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    //       validator: nameValidator,
                                                    controller:
                                                        controller.workexp,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    //     validator: nameValidator,
                                                    controller: controller
                                                        .qualiDescription,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  translation(context).aadhar,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context).mobile,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context).password,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .workTitle,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .projectworked,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .qualification,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .certifiedcourses,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CustomTextfield(
                                                    text: 'Aadhar',
                                                    // validator: (value) {
                                                    //   if (value!.isEmpty) {
                                                    //     return '*Required';
                                                    //   } else if (value.length != 12) {
                                                    //     return 'Aadhar Number must be of 12 digit';
                                                    //   }
                                                    //   return null;
                                                    // },
                                                    controller:
                                                        controller.aadharno,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Phone number',
                                                    controller:
                                                        controller.mobile,
                                                    // validator: (value) {
                                                    //   if (value!.length != 10)
                                                    //     return 'Mobile Number must be of 10 digit';
                                                    //   else
                                                    //     return null;
                                                    // },
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Password',
                                                    //     validator: validatePassword,
                                                    onsaved: (value) {
                                                      setState(() {
                                                        password = value;
                                                      });
                                                    },
                                                    controller:
                                                        controller.password,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Work title',
                                                    //        validator: nameValidator,
                                                    controller:
                                                        controller.worktitle,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Project Worked',
                                                    //       validator: nameValidator,
                                                    controller:
                                                        controller.project,
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton2<String>(
                                                      value: controller
                                                              .qualification
                                                              .text
                                                              .isNotEmpty
                                                          ? controller
                                                              .qualification
                                                              .text
                                                          : 'Select', // Provide a default value if it's empty
                                                      items: <String>[
                                                        'Select',
                                                        'Nill',
                                                        'ITI',
                                                        'Diploma',
                                                        '10th Pass',
                                                        '12th Pass',
                                                        'Under Graduate',
                                                        'Post Graduate'
                                                      ].map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      12)),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          // Step 2: Update controller when dropdown value changes
                                                          controller
                                                              .qualification
                                                              .text = newValue!;
                                                        });
                                                      },
                                                      buttonStyleData:
                                                          ButtonStyleData(
                                                        height: 45,
                                                        width: 30.w,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 14,
                                                                right: 14),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade500),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      iconStyleData:
                                                          const IconStyleData(
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_drop_down_sharp,
                                                        ),
                                                        iconSize: 25,
                                                        iconEnabledColor:
                                                            Colors.black,
                                                        iconDisabledColor: null,
                                                      ),
                                                      dropdownStyleData:
                                                          DropdownStyleData(
                                                        elevation: 0,
                                                        maxHeight: 200,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                top: 5,
                                                                bottom: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade500),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                        scrollPadding:
                                                            EdgeInsets.all(5),
                                                        scrollbarTheme:
                                                            ScrollbarThemeData(
                                                          thickness:
                                                              MaterialStateProperty
                                                                  .all<double>(
                                                                      6),
                                                          thumbVisibility:
                                                              MaterialStateProperty
                                                                  .all<bool>(
                                                                      true),
                                                        ),
                                                      ),
                                                      menuItemStyleData:
                                                          MenuItemStyleData(
                                                        height: 30,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 14,
                                                                right: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  CustomTextfield(
                                                    text: 'Certified Courses',
                                                    //      validator: nameValidator,
                                                    controller:
                                                        controller.course,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.8.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 152,
                                                  child: Text(
                                                    translation(context).skills,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 44.8,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .lookingWork,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            widget.selectedOption == 'Blue'
                                                ? Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                skillvalue, // Provide a default value if it's empty
                                                            items: BlueSkill.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                int selectionLimit =
                                                                    2;
                                                                if (newValue !=
                                                                        null &&
                                                                    controller
                                                                            .skills
                                                                            .length <
                                                                        selectionLimit) {
                                                                  if (!controller
                                                                      .skills
                                                                      .contains(
                                                                          newValue)) {
                                                                    controller
                                                                        .skills
                                                                        .add(
                                                                            newValue);
                                                                  }
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 30.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 17,
                                                        ),
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                wokinvalue, // Provide a default value if it's empty
                                                            items: BlueWorkin.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                if (newValue !=
                                                                        null &&
                                                                    !controller
                                                                        .workins
                                                                        .contains(
                                                                            newValue)) {
                                                                  controller
                                                                      .workins
                                                                      .add(
                                                                          newValue);
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 30.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                skillvalue, // Provide a default value if it's empty
                                                            items: GreySkill.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                if (newValue !=
                                                                        null &&
                                                                    !controller
                                                                        .skills
                                                                        .contains(
                                                                            newValue)) {
                                                                  controller
                                                                      .skills
                                                                      .add(
                                                                          newValue);
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 30.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 17,
                                                        ),
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                wokinvalue, // Provide a default value if it's empty
                                                            items: GreyWorkin.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                if (newValue !=
                                                                        null &&
                                                                    !controller
                                                                        .workins
                                                                        .contains(
                                                                            newValue)) {
                                                                  controller
                                                                      .workins
                                                                      .add(
                                                                          newValue);
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 30.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    color: Colors.pink.shade100,
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: Wrap(
                                                      spacing: 8.0,
                                                      runSpacing: 8.0,
                                                      children:
                                                          controller.skills
                                                              .map(
                                                                (value) => Chip(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20))),
                                                                  iconTheme: IconThemeData(
                                                                      color: Colors
                                                                          .black),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  label: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'SegoeItalic',
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onDeleted:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      controller
                                                                          .skills
                                                                          .remove(
                                                                              value);
                                                                    });
                                                                  },
                                                                ),
                                                              )
                                                              .toList(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  Container(
                                                    height: 45,
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: Wrap(
                                                      spacing: 8.0,
                                                      runSpacing: 8.0,
                                                      children:
                                                          controller.workins
                                                              .map(
                                                                (value) => Chip(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20))),
                                                                  iconTheme: IconThemeData(
                                                                      color: Colors
                                                                          .black),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  label: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'SegoeItalic',
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onDeleted:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      controller
                                                                          .workins
                                                                          .remove(
                                                                              value);
                                                                    });
                                                                  },
                                                                ),
                                                              )
                                                              .toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.8.h,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 152,
                                                  child: Text(
                                                    translation(context)
                                                        .describeaboutyourself,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                maxLines: 5,
                                                style: TextStyle(height: 1),
                                                //      validator: nameValidator,
                                                controller: controller.aboutYou,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 12,
                                                          top: 20,
                                                          right: 12,
                                                          bottom: 20),
                                                  hintStyle: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'SegoeItalic'),
                                                  errorMaxLines: 2,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.5.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              String name =
                                                  controller.name.text;
                                              String age = controller.name.text;
                                              String email =
                                                  controller.email.text.trim();
                                              String password =
                                                  controller.password.text;
                                              String mobile =
                                                  controller.mobile.text;
                                              String worktitle =
                                                  controller.worktitle.text;
                                              String aboutYou =
                                                  controller.aboutYou.text;
                                              String adharno =
                                                  controller.aadharno.text;
                                              String gender =
                                                  controller.gender.text;
                                              String workexp =
                                                  controller.workexp.text;
                                              String workexpcount =
                                                  controller.workexpcount.text;
                                              String qualification =
                                                  controller.qualification.text;
                                              String qualiDescription =
                                                  controller
                                                      .qualiDescription.text;
                                              String address =
                                                  controller.address.text;
                                              String course =
                                                  controller.course.text;
                                              String project =
                                                  controller.project.text;
                                              List<String> workins =
                                                  controller.workins;
                                              List<String> skills =
                                                  controller.skills;
                                              String? selectedOption =
                                                  widget.selectedOption;
                                              showDialog(
                                                barrierColor: Color(0x00ffffff),
                                                context: context,
                                                builder: (context) {
                                                  return NewUserUpload(
                                                    name: name,
                                                    email: email,
                                                    password: password,
                                                    mobile: mobile,
                                                    workexp: workexp,
                                                    workexpcount: workexpcount,
                                                    workins: workins,
                                                    worktitle: worktitle,
                                                    skills: skills,
                                                    address: address,
                                                    project: project,
                                                    course: course,
                                                    age: age,
                                                    aboutYou: aboutYou,
                                                    qualiDescription:
                                                        qualiDescription,
                                                    aadharno: adharno,
                                                    qualification:
                                                        qualification,
                                                    selectedOption:
                                                        selectedOption,
                                                    gender: gender,
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size.fromWidth(
                                                double.infinity),
                                            backgroundColor:
                                                Colors.indigo.shade900,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  5), // Adjust border radius as needed
                                            ),
                                          ),
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                              fontFamily: 'Colfax',
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: ImageIcon(
                                  NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/cancel.png?alt=media&token=951094e2-a6f9-46a3-96bc-ddbb3362f08c',
                                  ),
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  2.5.w, 2.5.h, 2.5.w, 2.5.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                          );
                                        },
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.indigo.shade900,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.8.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(3.w, 0, 3.w, 0.5.h),
                                    child: Row(
                                      children: [
                                        if (widget.selectedOption == 'Blue')
                                          Row(
                                            children: [
                                              Radio(
                                                value: widget.selectedOption,
                                                groupValue:
                                                    widget.selectedOption,
                                                onChanged: (value) {
                                                  setState(() {
                                                    controller.selectedOption
                                                            .text =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                translation(context).blueColler,
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IgnorePointer(
                                                child: Radio(
                                                    value:
                                                        widget.selectedOption,
                                                    groupValue: controller
                                                        .selectedOption.text,
                                                    onChanged: null),
                                              ),
                                              IgnorePointer(
                                                child: Text(
                                                  translation(context)
                                                      .greyColler,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                        else if (widget.selectedOption ==
                                            'Grey')
                                          Row(
                                            children: [
                                              IgnorePointer(
                                                child: Radio(
                                                    value:
                                                        widget.selectedOption,
                                                    groupValue: controller
                                                        .selectedOption.text,
                                                    onChanged: null),
                                              ),
                                              IgnorePointer(
                                                child: Text(
                                                  translation(context)
                                                      .blueColler,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Radio(
                                                value: widget.selectedOption,
                                                groupValue:
                                                    widget.selectedOption,
                                                onChanged: (value) {
                                                  // Handle radio button state change if needed
                                                  setState(() {
                                                    controller.selectedOption
                                                            .text =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text(
                                                translation(context).greyColler,
                                                style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        3.w, 0.6.h, 3.w, 0.5.h),
                                    child: Column(
                                      children: [
                                        Divider(color: Colors.black),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              translation(context)
                                                  .registerAsANewUser,
                                              textScaleFactor:
                                                  ScaleSize.textScaleFactor(
                                                      context),
                                              style: TextStyle(
                                                  fontFamily: 'Colfax',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context).name,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'First Name',
                                                //   validator: nameValidator,
                                                controller: controller.name,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context).age,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Age',
                                                //   validator: nameValidator,
                                                controller: controller.age,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context).email,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Email address',
                                                controller: controller.email,
                                                //     validator: emailValidator,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context).address,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Address',
                                                // validator: nameValidator,
                                                controller: controller.address,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context)
                                                      .workExperience,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  value: controller.workexpcount
                                                          .text.isNotEmpty
                                                      ? controller
                                                          .workexpcount.text
                                                      : 'Select', // Provide a default value if it's empty
                                                  items: <String>[
                                                    'Select',
                                                    '1 Month',
                                                    '2 Months',
                                                    '3 Months',
                                                    '4 Months',
                                                    '5 Months',
                                                    '6 Months',
                                                    '1 Year',
                                                    '2 Years',
                                                    'More than 2 Years'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12)),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      // Step 2: Update controller when dropdown value changes
                                                      controller.workexpcount
                                                          .text = newValue!;
                                                    });
                                                  },
                                                  buttonStyleData:
                                                      ButtonStyleData(
                                                    height: 45,
                                                    padding: EdgeInsets.only(
                                                        left: 14, right: 14),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade500),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  iconStyleData:
                                                      const IconStyleData(
                                                    icon: Icon(
                                                      Icons
                                                          .arrow_drop_down_sharp,
                                                    ),
                                                    iconSize: 25,
                                                    iconEnabledColor:
                                                        Colors.black,
                                                    iconDisabledColor: null,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    elevation: 0,
                                                    maxHeight: 200,
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade500),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                        topRight:
                                                            Radius.circular(0),
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    scrollPadding:
                                                        EdgeInsets.all(5),
                                                    scrollbarTheme:
                                                        ScrollbarThemeData(
                                                      thickness:
                                                          MaterialStateProperty
                                                              .all<double>(6),
                                                      thumbVisibility:
                                                          MaterialStateProperty
                                                              .all<bool>(true),
                                                    ),
                                                  ),
                                                  menuItemStyleData:
                                                      MenuItemStyleData(
                                                    height: 30,
                                                    padding: EdgeInsets.only(
                                                        left: 14, right: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context)
                                                      .workdescription,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                //          validator: nameValidator,
                                                controller: controller.workexp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context)
                                                    .qualificationdescription,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextfield(
                                                //        validator: nameValidator,
                                                controller:
                                                    controller.qualiDescription,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context).skills,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            widget.selectedOption == 'Blue'
                                                ? Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                skillvalue, // Provide a default value if it's empty
                                                            items: BlueSkill.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              isSkillSelect =
                                                                  !isSkillSelect;
                                                              setState(() {
                                                                int selectionLimit =
                                                                    2;
                                                                if (newValue !=
                                                                        null &&
                                                                    controller
                                                                            .skills
                                                                            .length <
                                                                        selectionLimit) {
                                                                  if (!controller
                                                                      .skills
                                                                      .contains(
                                                                          newValue)) {
                                                                    controller
                                                                        .skills
                                                                        .add(
                                                                            newValue);
                                                                  }
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 60.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                        isSkillSelect
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 17,
                                                                  ),
                                                                  Container(
                                                                    height: 45,
                                                                    padding: EdgeInsets.only(
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                    child: Wrap(
                                                                      spacing:
                                                                          8.0,
                                                                      runSpacing:
                                                                          8.0,
                                                                      children: controller
                                                                          .skills
                                                                          .map(
                                                                            (value) =>
                                                                                Chip(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                              iconTheme: IconThemeData(color: Colors.black),
                                                                              backgroundColor: Colors.transparent,
                                                                              label: Text(
                                                                                value,
                                                                                style: TextStyle(fontSize: 12, fontFamily: 'SegoeItalic', color: Colors.black),
                                                                              ),
                                                                              onDeleted: () {
                                                                                setState(() {
                                                                                  controller.skills.remove(value);
                                                                                });
                                                                              },
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  )
                                                : Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                skillvalue, // Provide a default value if it's empty
                                                            items: GreySkill.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                      String>(
                                                                  value: value,
                                                                  child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12),
                                                                  ));
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                isSkillSelect =
                                                                    !isSkillSelect;
                                                                int selectionLimit =
                                                                    2;
                                                                if (newValue !=
                                                                        null &&
                                                                    controller
                                                                            .skills
                                                                            .length <
                                                                        selectionLimit) {
                                                                  if (!controller
                                                                      .skills
                                                                      .contains(
                                                                          newValue)) {
                                                                    controller
                                                                        .skills
                                                                        .add(
                                                                            newValue);
                                                                  }
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 60.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                        isSkillSelect
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 17,
                                                                  ),
                                                                  Container(
                                                                    height: 45,
                                                                    padding: EdgeInsets.only(
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                    child: Wrap(
                                                                      spacing:
                                                                          8.0,
                                                                      runSpacing:
                                                                          8.0,
                                                                      children: controller
                                                                          .skills
                                                                          .map(
                                                                            (value) =>
                                                                                Chip(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                              iconTheme: IconThemeData(color: Colors.black),
                                                                              backgroundColor: Colors.transparent,
                                                                              label: Text(
                                                                                value,
                                                                                style: TextStyle(fontSize: 12, fontFamily: 'SegoeItalic', color: Colors.black),
                                                                              ),
                                                                              onDeleted: () {
                                                                                setState(() {
                                                                                  controller.skills.remove(value);
                                                                                });
                                                                              },
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context)
                                                      .lookingWork,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            widget.selectedOption == 'Blue'
                                                ? Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                wokinvalue, // Provide a default value if it's empty
                                                            items: BlueWorkin.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                isWorkinSelect =
                                                                    !isWorkinSelect;
                                                                if (newValue !=
                                                                        null &&
                                                                    !controller
                                                                        .workins
                                                                        .contains(
                                                                            newValue)) {
                                                                  controller
                                                                      .workins
                                                                      .add(
                                                                          newValue);
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 60.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                        isWorkinSelect
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 17,
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                    child: Wrap(
                                                                      spacing:
                                                                          8.0,
                                                                      runSpacing:
                                                                          8.0,
                                                                      children: controller
                                                                          .workins
                                                                          .map(
                                                                            (value) =>
                                                                                Chip(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                              iconTheme: IconThemeData(color: Colors.black),
                                                                              backgroundColor: Colors.transparent,
                                                                              label: Text(
                                                                                value,
                                                                                style: TextStyle(fontSize: 12, fontFamily: 'SegoeItalic', color: Colors.black),
                                                                              ),
                                                                              onDeleted: () {
                                                                                setState(() {
                                                                                  controller.workins.remove(value);
                                                                                });
                                                                              },
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  )
                                                : Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2<
                                                                  String>(
                                                            value:
                                                                wokinvalue, // Provide a default value if it's empty
                                                            items: GreyWorkin.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12)),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              isWorkinSelect =
                                                                  !isWorkinSelect;
                                                              setState(() {
                                                                if (newValue !=
                                                                        null &&
                                                                    !controller
                                                                        .workins
                                                                        .contains(
                                                                            newValue)) {
                                                                  controller
                                                                      .workins
                                                                      .add(
                                                                          newValue);
                                                                }
                                                              });
                                                            },
                                                            buttonStyleData:
                                                                ButtonStyleData(
                                                              height: 45,
                                                              width: 60.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            iconStyleData:
                                                                const IconStyleData(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_drop_down_sharp,
                                                              ),
                                                              iconSize: 25,
                                                              iconEnabledColor:
                                                                  Colors.black,
                                                              iconDisabledColor:
                                                                  null,
                                                            ),
                                                            dropdownStyleData:
                                                                DropdownStyleData(
                                                              elevation: 0,
                                                              maxHeight: 200,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              scrollPadding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              scrollbarTheme:
                                                                  ScrollbarThemeData(
                                                                thickness:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            6),
                                                                thumbVisibility:
                                                                    MaterialStateProperty
                                                                        .all<bool>(
                                                                            true),
                                                              ),
                                                            ),
                                                            menuItemStyleData:
                                                                MenuItemStyleData(
                                                              height: 30,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 14,
                                                                      right:
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                        isWorkinSelect
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 17,
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                    child: Wrap(
                                                                      spacing:
                                                                          8.0,
                                                                      runSpacing:
                                                                          8.0,
                                                                      children: controller
                                                                          .workins
                                                                          .map(
                                                                            (value) =>
                                                                                Chip(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                              iconTheme: IconThemeData(color: Colors.black),
                                                                              backgroundColor: Colors.transparent,
                                                                              label: Text(
                                                                                value,
                                                                                style: TextStyle(fontSize: 12, fontFamily: 'SegoeItalic', color: Colors.black),
                                                                              ),
                                                                              onDeleted: () {
                                                                                setState(() {
                                                                                  controller.workins.remove(value);
                                                                                });
                                                                              },
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context).aadhar,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Aadhar',
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
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context).mobile,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Phone number',
                                                controller: controller.mobile,
                                                // validator: (value) {
                                                //   if (value!.length != 10)
                                                //     return 'Mobile Number must be of 10 digit';
                                                //   else
                                                //     return null;
                                                // },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context).password,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Password',
                                                //   validator: validatePassword,
                                                onsaved: (value) {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                },
                                                controller: controller.password,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context)
                                                      .workTitle,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Work title',
                                                //           validator: nameValidator,
                                                controller:
                                                    controller.worktitle,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context)
                                                      .projectworked,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Project Worked',
                                                //            validator: nameValidator,
                                                controller: controller.project,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context)
                                                      .qualification,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  value: controller
                                                          .qualification
                                                          .text
                                                          .isNotEmpty
                                                      ? controller
                                                          .qualification.text
                                                      : 'Select', // Provide a default value if it's empty
                                                  items: <String>[
                                                    'Select',
                                                    'Nill',
                                                    'ITI',
                                                    'Diploma',
                                                    '10th Pass',
                                                    '12th Pass',
                                                    'Under Graduate',
                                                    'Post Graduate'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12)),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      // Step 2: Update controller when dropdown value changes
                                                      controller.qualification
                                                          .text = newValue!;
                                                    });
                                                  },
                                                  buttonStyleData:
                                                      ButtonStyleData(
                                                    height: 45,
                                                    padding: EdgeInsets.only(
                                                        left: 14, right: 14),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade500),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  iconStyleData:
                                                      const IconStyleData(
                                                    icon: Icon(
                                                      Icons
                                                          .arrow_drop_down_sharp,
                                                    ),
                                                    iconSize: 25,
                                                    iconEnabledColor:
                                                        Colors.black,
                                                    iconDisabledColor: null,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    elevation: 0,
                                                    maxHeight: 200,
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        top: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade500),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(0),
                                                        topRight:
                                                            Radius.circular(0),
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    scrollPadding:
                                                        EdgeInsets.all(5),
                                                    scrollbarTheme:
                                                        ScrollbarThemeData(
                                                      thickness:
                                                          MaterialStateProperty
                                                              .all<double>(6),
                                                      thumbVisibility:
                                                          MaterialStateProperty
                                                              .all<bool>(true),
                                                    ),
                                                  ),
                                                  menuItemStyleData:
                                                      MenuItemStyleData(
                                                    height: 30,
                                                    padding: EdgeInsets.only(
                                                        left: 14, right: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  translation(context)
                                                      .certifiedcourses,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12),
                                                )),
                                            Expanded(
                                              child: CustomTextfield(
                                                text: 'Certified Courses',
                                                //    validator: nameValidator,
                                                controller: controller.course,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context)
                                                    .describeaboutyourself,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomTextfield(
                                                dynamicHeight: 80,
                                                text: 'About You',
                                                //              validator: nameValidator,
                                                controller: controller.name,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.5.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              String name =
                                                  controller.name.text;
                                              String age = controller.name.text;
                                              String email =
                                                  controller.email.text.trim();
                                              String password =
                                                  controller.password.text;
                                              String mobile =
                                                  controller.mobile.text;
                                              String worktitle =
                                                  controller.worktitle.text;
                                              String aboutYou =
                                                  controller.aboutYou.text;
                                              String adharno =
                                                  controller.aadharno.text;
                                              String gender =
                                                  controller.gender.text;
                                              String workexp =
                                                  controller.workexp.text;
                                              String workexpcount =
                                                  controller.workexpcount.text;
                                              String qualification =
                                                  controller.qualification.text;
                                              String qualiDescription =
                                                  controller
                                                      .qualiDescription.text;
                                              String address =
                                                  controller.address.text;
                                              String course =
                                                  controller.course.text;
                                              String project =
                                                  controller.project.text;
                                              List<String> workins =
                                                  controller.workins;
                                              List<String> skills =
                                                  controller.skills;
                                              String? selectedOption =
                                                  widget.selectedOption;
                                              showDialog(
                                                context: context,
                                                barrierColor: Color(0x00ffffff),
                                                builder: (context) {
                                                  return NewUserUpload(
                                                    name: name,
                                                    email: email,
                                                    password: password,
                                                    mobile: mobile,
                                                    workexp: workexp,
                                                    workexpcount: workexpcount,
                                                    workins: workins,
                                                    worktitle: worktitle,
                                                    skills: skills,
                                                    address: address,
                                                    project: project,
                                                    course: course,
                                                    age: age,
                                                    aboutYou: aboutYou,
                                                    qualiDescription:
                                                        qualiDescription,
                                                    aadharno: adharno,
                                                    qualification:
                                                        qualification,
                                                    selectedOption:
                                                        selectedOption,
                                                    gender: gender,
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size.fromWidth(
                                                double.infinity),
                                            backgroundColor:
                                                Colors.indigo.shade900,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  5), // Adjust border radius as needed
                                            ),
                                          ),
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                              fontFamily: 'Colfax',
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      );
    });
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
