import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'Widgets/customtextstyle.dart';
import 'classes/language_constants.dart';
import 'widgets/custombutton.dart';
import 'widgets/hiremeinindia.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'classes/language.dart';
import 'gen_l10n/app_localizations.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class NewUserPayment extends StatefulWidget {
  const NewUserPayment();
  @override
  State<NewUserPayment> createState() => _NewUserPayment();
}

class _NewUserPayment extends State<NewUserPayment> {
  bool isChecked = false;
  bool isProcessing = false;
  PlatformFile? _cashReceipt;
  String? _uploadedImageURL; // New variable to store uploaded image URL

  Future<void> showFileUploadSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File Upload Successful'),
          content: Text('The cash receipt has been uploaded successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> uploadImageToFirebase(
      List<int> fileBytes, String fileName) async {
    try {
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      await reference.putData(Uint8List.fromList(fileBytes));
      print('Image uploaded to Firebase Storage with filename: $fileName');
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> getCashReceipt() async {
    final String serverUrl = 'http://localhost:3013';
    final String endpoint = '/getCashReceipt';

    try {
      final response = await http.get(Uri.parse('$serverUrl$endpoint'));

      if (response.statusCode == 200) {
        String cashReceiptData = response.body;
        // Display or process the received cash receipt data as needed
        print('Received Cash Receipt: $cashReceiptData');
      } else {
        print(
          'Failed to retrieve cash receipt. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      print('Error retrieving cash receipt: $error');
    }
  }

  Future<void> uploadCashReceipt() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _cashReceipt = result.files.first;
        });

        print('Cash receipt uploaded: ${_cashReceipt!.name}');

        // Check if the path is not null before proceeding
        // Check if the path is not null before proceeding
        if (_cashReceipt!.path != null) {
          // For non-web platforms, use the path property
          List<int> fileBytes;
          if (kIsWeb) {
            // For web, use the bytes property
            fileBytes = _cashReceipt!.bytes!;
          } else {
            fileBytes = await _readFileAsBytes(_cashReceipt!.path!);
          }

          // Upload the cash receipt image to Firebase Storage
          await uploadImageToFirebase(fileBytes, 'cash_receipt.jpg');

          // Show the file upload success dialog
          await showFileUploadSuccessDialog();
        } else {
          print('File path is null');
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<List<int>> _readFileAsBytes(String path) async {
    // Read the content of the file as bytes
    final file = File(path);
    List<int> fileBytes = await file.readAsBytes();
    return fileBytes;
  }

  Widget _buildSendingCashDialog(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: AlertDialog(
            title: Text('Sending Cash Notification'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Please wait...'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> sendCashNotification() async {
    print("cash2");
    setState(() {
      isProcessing = true; // Set the flag to indicate processing
    });
    final String serverUrl = 'http://localhost:3013';
    final String endpoint = '/cashNotification';

    try {
      print('Sending cash notification...');
      final response = await http.post(
        Uri.parse('$serverUrl$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print("cash3");
        print('Waiting for 3 minutes before showing verification result...');
        // Wait for 3 minutes before showing verification result
        await Future.delayed(Duration(minutes: 1));

        // Dismiss the "Sending Cash Notification" dialog
        Navigator.of(context).pop();

        setState(() {
          isProcessing = false;
        });

        // Display a popup message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Cash Received and Verified'),
              content: Text('The cash payment has been received and verified.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print(
          'Failed to send notification. Status code: ${response.statusCode}',
        );
        setState(() {
          isProcessing = false; // Set the flag to indicate processing is done
        });
      }
    } catch (error) {
      print('Error sending notification: $error');
      setState(() {
        isProcessing = false; // Set the flag to indicate processing is done
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: HireMeInIndia(),
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
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                  SizedBox(width: 40),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 50,
                    child: Text(
                      'Guest User',
                      maxLines: 2,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
            padding:
                EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.indigo.shade900;
                        }
                        return Colors.transparent;
                      },
                    ),
                    checkColor: Colors.black,
                    side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  Text(translation(context).greyColler),
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.grey;
                        }
                        return Colors.transparent;
                      },
                    ),
                    checkColor: Colors.black,
                    side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  Text(
                    translation(context).greyColler,
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: CustomButton(
                    text: translation(context).gpay,
                    onPressed: () {},
                  )),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: CustomButton(
                    text: translation(context).neft,
                    onPressed: () {},
                  )),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: CustomButton(
                      text: translation(context).cash,
                      onPressed: () async {
                        print("cash1");

                        // Call the method to upload cash receipt
                        await uploadCashReceipt();

                        // Display the pop-up dialog only if the receipt is uploaded successfully
                        if (_cashReceipt != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildSendingCashDialog(context);
                            },
                          );

                          try {
                            // Call the method to send cash notification
                            await sendCashNotification();

                            // Call the method to retrieve cash receipt after the notification is sent
                            await getCashReceipt();

                            // The pop-up dialog will be dismissed automatically when the process is complete
                            // Instead of navigating back immediately, you can handle the response here
                            // For example, you can show a message or navigate to another page based on the response
                          } catch (error) {
                            print('Error handling cash notification: $error');
                            // Handle the error scenario, e.g., show an error message to the user
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: CustomButton(
                    text: translation(context).paymentGateway,
                    onPressed: () {},
                  )),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: translation(context).next,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              )
            ])));
  }
}

Widget _buildSendingCashDialog() {
  return Stack(
    children: [
      Positioned.fill(
        child: Container(
          color: Colors.transparent,
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: AlertDialog(
          title: Text('Sending Cash Notification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Please wait...'),
            ],
          ),
        ),
      ),
    ],
  );
}
