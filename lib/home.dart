import 'dart:io';
import 'package:flutter/material.dart';
import 'package:besyon/besyon_colors.dart';
import 'package:besyon/besyon_functions.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:besyon/file_provider.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    Future<void> uploadData() async {
      if (await FileAddressProvider().fileExists()) {
        // Open file if it exists, and go through each line
        for (var line
            in FileAddressProvider().readFile().toString().split("\n")) {
          List<dynamic> temp_data = [];
          temp_data = line.split(",");
          // Submit the data to Google Sheets
          if (await BesyonFunctions().submitForm(
              temp_data[0],
              temp_data[1],
              temp_data[2],
              temp_data[3],
              temp_data[4],
              temp_data[5],
              temp_data[6],
              temp_data[7],
              temp_data[8],
              temp_data[9],
              temp_data[10],
              temp_data[11],
              temp_data[12],
              temp_data[13],
              temp_data[14],
              temp_data[15],
              temp_data[16],
              temp_data[17],
              temp_data[18],
              temp_data[19],
              temp_data[20])) {
            // Delete the file if the data was uploaded successfully
            FileAddressProvider().deleteFile();
          }
        }
      }
    }

    uploadData();
  }

  _buildDivider() {
    return const Divider(
      height: 20,
      color: Colors.transparent,
      thickness: 0,
      indent: 0,
      endIndent: 0,
    );
  }

  // Text Controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _incomeBracketController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _alcoholDrinkerController =
      TextEditingController();
  final TextEditingController _drinkingFrequencyController =
      TextEditingController();
  final TextEditingController _smokerController = TextEditingController();
  final TextEditingController _smokingFrequencyController =
      TextEditingController();
  final TextEditingController _sedentaryController = TextEditingController();
  final TextEditingController _bpSystolicController = TextEditingController();
  final TextEditingController _bpDiastolicController = TextEditingController();
  final TextEditingController _bpDateController = TextEditingController();
  final TextEditingController _bpTimeController = TextEditingController();
  final TextEditingController _bgController = TextEditingController();
  final TextEditingController _bgDateController = TextEditingController();
  final TextEditingController _bgTimeController = TextEditingController();

  String bmi = "";
  String bpResults = "";
  String bgResults = "";
  bool _isButtonDisabled = false;

  void _calculateBMI(height, weight) {
    // height in cm, weight in kg
    double _height = double.parse(height) / 100;
    double _weight = double.parse(weight);
    double _bmi = _weight / (_height * _height);

    String classification = "";
    if (_bmi < 18.5) {
      classification = "Underweight";
    } else if (_bmi >= 18.5 && _bmi < 25) {
      classification = "Normal";
    } else if (_bmi >= 25 && _bmi < 30) {
      classification = "Overweight";
    } else if (_bmi >= 30) {
      classification = "Obese";
    }

    setState(() {
      bmi = "$classification, ${_bmi.toStringAsFixed(2)}";
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height * 0.075,
        title: Transform.translate(
          offset: const Offset(20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Make logo tappable
              GestureDetector(
                onDoubleTap: () {
                  // Show Contact Developer (John Markton Olart, email: jmolarte@up.edu.ph)
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Contact Developer"),
                          content: TextButton(
                            child: const Text("John Markton Olarte",
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () {
                              // Open email app
                              _launchInBrowser(
                                  Uri.parse("mailto:jmolarte@up.edu.ph"));
                            },
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Image.asset(
                  "lib/assets/logo.png",
                  width: 30,
                ),
              ),
              Text(
                "BeSyon",
                style: TextStyle(
                  color: BesyonColors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "App",
                style: TextStyle(
                  color: BesyonColors.purple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          // Clear All Button (with confirmation)
          IconButton(
            icon: const Icon(Icons.restore_page),
            color: Colors.redAccent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Clear All"),
                    content: const Text("Are you sure you want to clear all?"),
                    actions: [
                      TextButton(
                        child: const Text("Yes",
                            style: TextStyle(color: Colors.redAccent)),
                        onPressed: () {
                          _nameController.clear();
                          _dateOfBirthController.clear();
                          _sexController.clear();
                          _incomeBracketController.clear();
                          _contactNumberController.clear();
                          _heightController.clear();
                          _weightController.clear();
                          _alcoholDrinkerController.clear();
                          _drinkingFrequencyController.clear();
                          _smokerController.clear();
                          _smokingFrequencyController.clear();
                          _sedentaryController.clear();
                          _bpSystolicController.clear();
                          _bpDiastolicController.clear();
                          _bpDateController.clear();
                          _bpTimeController.clear();
                          _bgController.clear();
                          _bgDateController.clear();
                          _bgTimeController.clear();
                          Navigator.of(context).pop();
                          setState(() {
                            bmi = "";
                            bpResults = "";
                            bgResults = "";

                            // reload page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(
                                  title: 'Besyon',
                                ),
                              ),
                            );
                          });
                        },
                      ),
                      TextButton(
                        child: const Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // Check if keyboard is open
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height * 0.80
                : MediaQuery.of(context).size.height * 0.60,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information
                  Center(
                    child: Lottie.asset(
                      'lib/assets/person.json',
                      width: MediaQuery.of(context).size.width,
                      frameRate: FrameRate(120),
                    ),
                  ),
                  Center(
                    child: Text(
                      "PERSONAL INFORMATION",
                      style: TextStyle(
                        color: BesyonColors.blue,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    // Name Input Box
                  ),
                  _buildDivider(),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Input Box
                        const Text("\tName",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        TextField(
                          cursorColor: BesyonColors.blue,
                          controller: _nameController,
                          decoration: InputDecoration(
                            suffixIcon: _nameController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _nameController.clear();
                                      });
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: BesyonColors.grey,
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            hintText: "Full Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        _buildDivider(),

                        // Date of Birth and Sex Input Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date of Birth
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "\tDate of Birth",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Date of Birth Input Box
                                  TextFormField(
                                    onSaved: (value) {
                                      _dateOfBirthController.text = value!;
                                    },
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      // Show Date Picker and use the selected date to update the text field
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      ).then(
                                        (date) {
                                          _dateOfBirthController.text =
                                              date.toString().substring(0, 10);
                                        },
                                      );
                                    },
                                    cursorColor: BesyonColors.blue,
                                    controller: _dateOfBirthController,
                                    decoration: InputDecoration(
                                      suffixIcon:
                                          _dateOfBirthController.text.isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        _dateOfBirthController
                                                            .clear();
                                                      },
                                                    );
                                                  },
                                                )
                                              : null,
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      hintText: "Date",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Sex
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "\tSex",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Dropdown Menu
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    value: BesyonStatic().sexAtBirth[0],
                                    items: BesyonStatic()
                                        .sexAtBirth
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _sexController.text = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        _buildDivider(),

                        // Income Bracket Input Box
                        const Text(
                          "\tAnnual Income",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: BesyonColors.grey,
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          value: BesyonStatic().incomeBrackets[0],
                          items:
                              BesyonStatic().incomeBrackets.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(
                              () {
                                if (value == "Annual Income") {
                                  _incomeBracketController.text = "";
                                } else {
                                  _incomeBracketController.text = value!;
                                }
                              },
                            );
                          },
                        ),

                        _buildDivider(),

                        // Contact Number Input Box
                        const Text(
                          "\tContact Number",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          cursorColor: BesyonColors.blue,
                          controller: _contactNumberController,
                          decoration: InputDecoration(
                            suffixIcon: _contactNumberController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _contactNumberController.clear();
                                      });
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: BesyonColors.grey,
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            hintText: "Contact Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        _buildDivider(),

                        // Height and Weight Input Boxes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Height
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "\tHeight",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Height Input Box
                                  TextField(
                                    onEditingComplete: () {
                                      if (_heightController.text.isNotEmpty &&
                                          _weightController.text.isNotEmpty) {
                                        _calculateBMI(_heightController.text,
                                            _weightController.text);
                                      }

                                      FocusScope.of(context).unfocus();
                                    },
                                    cursorColor: BesyonColors.blue,
                                    controller: _heightController,
                                    decoration: InputDecoration(
                                      suffixIcon:
                                          _heightController.text.isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: () {
                                                    setState(() {
                                                      _heightController.clear();
                                                      bmi = "";
                                                    });
                                                  },
                                                )
                                              : null,
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      hintText: "in centimeters (cm)",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Weight
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "\tWeight",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Weight Input Box
                                  TextField(
                                    onEditingComplete: () {
                                      if (_heightController.text.isNotEmpty &&
                                          _weightController.text.isNotEmpty) {
                                        _calculateBMI(_heightController.text,
                                            _weightController.text);
                                      }

                                      FocusScope.of(context).unfocus();
                                    },
                                    cursorColor: BesyonColors.blue,
                                    controller: _weightController,
                                    decoration: InputDecoration(
                                      suffixIcon:
                                          _weightController.text.isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: () {
                                                    setState(() {
                                                      _weightController.clear();
                                                      bmi = "";
                                                    });
                                                  },
                                                )
                                              : null,
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      hintText: "in kilograms (kg)",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Calculate BMI Button (with snackbar if there is no input, only weight or only height)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BesyonColors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_heightController.text.isNotEmpty &&
                                _weightController.text.isNotEmpty) {
                              setState(() {
                                _calculateBMI(_heightController.text,
                                    _weightController.text);
                              });
                            } else if (_heightController.text.isEmpty &&
                                _weightController.text.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                  content: Text(
                                    "Please enter height (cm) value",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (_heightController.text.isNotEmpty &&
                                _weightController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                  content: Text(
                                    "Please enter weight (kg) value",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                  content: Text(
                                    "Please enter height and weight values",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            FocusScope.of(context).unfocus();
                          },
                          child: const Text(
                            "Calculate BMI",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // BMI
                        bmi != ""
                            ? Text(bmi)
                            : const Text(
                                "Enter height and weight to calculate BMI"),

                        _buildDivider(),
                        _buildDivider(),
                        _buildDivider(),
                        // Lifestyle Information
                        Center(
                          child: Lottie.asset('lib/assets/lifestyle.json',
                              width: MediaQuery.of(context).size.width),
                        ),
                        Center(
                          child: Text(
                            'LIFESTYLE INFORMATION',
                            style: TextStyle(
                              color: BesyonColors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),

                        // Do you drink alcohol?
                        _buildDivider(),
                        const Text(
                          "\tDo you drink alcohol?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // Yes or No
                        Row(
                          children: [
                            // Yes
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _alcoholDrinkerController.text == "Yes"
                                          ? BesyonColors.purple
                                          : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _alcoholDrinkerController.text = "Yes";
                                  });
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color:
                                        _alcoholDrinkerController.text == "Yes"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // No
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _alcoholDrinkerController.text == "No"
                                          ? BesyonColors.blue
                                          : Colors.white,
                                  foregroundColor:
                                      _alcoholDrinkerController.text == "Yes"
                                          ? Colors.white
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _alcoholDrinkerController.text = "No";
                                  });
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color:
                                        _alcoholDrinkerController.text == "No"
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // How many drinks do you have per week?
                        _alcoholDrinkerController.text == "Yes"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "\tHow often do you drink alcohol?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Drinking Frequency Dropdown
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    value: BesyonStatic().alcoholFrequency[0],
                                    items: BesyonStatic()
                                        .alcoholFrequency
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _drinkingFrequencyController.text =
                                            value!;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Container(),

                        _buildDivider(),

                        // Do you smoke?
                        const Text(
                          "\tDo you smoke?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // Yes or No
                        Row(
                          children: [
                            // Yes
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _smokerController.text == "Yes"
                                          ? BesyonColors.purple
                                          : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _smokerController.text = "Yes";
                                  });
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: _smokerController.text == "Yes"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // No
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _smokerController.text == "No"
                                          ? BesyonColors.blue
                                          : Colors.white,
                                  foregroundColor:
                                      _smokerController.text == "Yes"
                                          ? Colors.purple
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _smokerController.text = "No";
                                  });
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: _smokerController.text == "No"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // How many cigarettes a day do you smoke?
                        _smokerController.text == "Yes"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "\tHow often do you drink alcohol?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Drinking Frequency Dropdown
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    value: BesyonStatic().smokingFrequency[0],
                                    items: BesyonStatic()
                                        .smokingFrequency
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _smokingFrequencyController.text =
                                            value!;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Container(),

                        _buildDivider(),
                        // Sedentary Lifestyle
                        const Text(
                          "\tDo you have a sedentary lifestyle?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // Yes or No
                        Row(
                          children: [
                            // Yes
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _sedentaryController.text == "Yes"
                                          ? BesyonColors.purple
                                          : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _sedentaryController.text = "Yes";
                                  });
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: _sedentaryController.text == "Yes"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // No
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _sedentaryController.text == "No"
                                          ? BesyonColors.blue
                                          : Colors.white,
                                  foregroundColor:
                                      _sedentaryController.text == "Yes"
                                          ? Colors.white
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _sedentaryController.text = "No";
                                  });
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: _sedentaryController.text == "No"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        _buildDivider(),
                        _buildDivider(),
                        _buildDivider(),
                        // Medical Examination
                        Center(
                          child: Lottie.asset(
                            'lib/assets/med.json',
                            width: MediaQuery.of(context).size.width,
                            frameRate: FrameRate(120),
                          ),
                        ),
                        Center(
                          child: Text(
                            'MEDICAL EXAMINATION',
                            style: TextStyle(
                              color: BesyonColors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),

                        _buildDivider(),
                        // Blood Pressure
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Blood Pressure
                            Text(
                              "\tBlood Pressure",
                              style: TextStyle(
                                color: BesyonColors.purple,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            // Systolic / Diastolic Input Boxes
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Systolic
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: TextField(
                                    onEditingComplete: () {
                                      if (_bpSystolicController
                                              .text.isNotEmpty &&
                                          _bpDiastolicController
                                              .text.isNotEmpty) {
                                        setState(() {
                                          bpResults = BesyonFunctions()
                                              .bpResults(
                                                  _bpSystolicController.text,
                                                  _bpDiastolicController.text);
                                        });
                                      }
                                      FocusScope.of(context).unfocus();
                                    },
                                    cursorColor: BesyonColors.blue,
                                    controller: _bpSystolicController,
                                    decoration: InputDecoration(
                                      suffixIcon:
                                          _bpSystolicController.text.isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        _bpSystolicController
                                                            .clear();
                                                        bpResults = "";
                                                      },
                                                    );
                                                  },
                                                )
                                              : null,
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      hintText: "Systolic in mmHg",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                // '/'
                                const Text(
                                  " / ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 50,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                // Diastolic
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: TextField(
                                    onEditingComplete: () {
                                      if (_bpSystolicController
                                              .text.isNotEmpty &&
                                          _bpDiastolicController
                                              .text.isNotEmpty) {
                                        setState(() {
                                          bpResults = BesyonFunctions()
                                              .bpResults(
                                                  _bpSystolicController.text,
                                                  _bpDiastolicController.text);
                                        });
                                      }
                                      FocusScope.of(context).unfocus();
                                    },
                                    cursorColor: BesyonColors.blue,
                                    controller: _bpDiastolicController,
                                    decoration: InputDecoration(
                                      suffixIcon:
                                          _bpDiastolicController.text.isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        _bpDiastolicController
                                                            .clear();
                                                        bpResults = "";
                                                      },
                                                    );
                                                  },
                                                )
                                              : null,
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      hintText: "Diastolic in mmHg",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Calculate BP Results (Button)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BesyonColors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_bpSystolicController.text.isNotEmpty &&
                                _bpDiastolicController.text.isNotEmpty) {
                              setState(() {
                                bpResults = BesyonFunctions().bpResults(
                                    _bpSystolicController.text,
                                    _bpDiastolicController.text);
                              });
                            } else if (_bpSystolicController.text.isEmpty &&
                                _bpDiastolicController.text.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                  content: Text(
                                    "Please enter Systolic BP value",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (_bpSystolicController.text.isNotEmpty &&
                                _bpDiastolicController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                  content: Text(
                                    "Please enter Diastolic BP value",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                  content: Text(
                                    "Please enter Systolic and Diastolic BP values",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            FocusScope.of(context).unfocus();
                          },
                          child: const Text(
                            "Calculate",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // BP Results
                        bpResults.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // BP Results
                                  Text(
                                    '\t$bpResults : ',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // BP Results Interpretation
                                  Flexible(
                                    child: Text(
                                      BesyonFunctions().bpInterpretation(
                                        bpResults,
                                      ),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              )
                            : const Text("Enter BP data"),

                        _buildDivider(),
                        // Date and Time Taken
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // Date Taken
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "\tDate Taken",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                // Text Form Field (Show Calendar)
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: TextField(
                                    onTap: () async {
                                      // Show Calendar
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2015, 8),
                                        lastDate: DateTime.now(),
                                      );
                                      if (pickedDate != null) {
                                        setState(
                                          () {
                                            _bpDateController.text = pickedDate
                                                .toString()
                                                .substring(0, 10);
                                          },
                                        );
                                      }
                                    },
                                    onEditingComplete: () {
                                      if (_bpDateController.text.isNotEmpty) {
                                        // Close Keyboard
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    cursorColor: BesyonColors.blue,
                                    controller: _bpDateController,
                                    decoration: InputDecoration(
                                      suffixIcon: _bpDateController
                                              .text.isNotEmpty
                                          ? IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _bpDateController.clear();
                                                  },
                                                );
                                              },
                                            )
                                          : null,
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      hintText: "dd/mm/yyyy",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "\tTime Taken",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                // Time Taken (Using Time Picker)
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: TextField(
                                    onTap: () async {
                                      // Show Time Picker
                                      final TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        setState(
                                          () {
                                            _bpTimeController.text =
                                                pickedTime.format(context);
                                          },
                                        );
                                      }
                                    },
                                    onEditingComplete: () {
                                      if (_bpTimeController.text.isNotEmpty) {
                                        // Close Keyboard
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    cursorColor: BesyonColors.blue,
                                    controller: _bpTimeController,
                                    decoration: InputDecoration(
                                      suffixIcon: _bpTimeController
                                              .text.isNotEmpty
                                          ? IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _bpTimeController.clear();
                                                  },
                                                );
                                              },
                                            )
                                          : null,
                                      filled: true,
                                      fillColor: BesyonColors.grey,
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      hintText: "hh:mm",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  _buildDivider(),
                  // Blood Glucose (bg)
                  Text(
                    "\tBlood Glucose",
                    style: TextStyle(
                        color: BesyonColors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  // Blood Glucose Input Box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      onEditingComplete: () {
                        if (_bgController.text.isNotEmpty) {
                          setState(() {
                            bgResults = BesyonFunctions()
                                .bgResults(int.parse(_bgController.text));
                          });
                        }
                        // Close Keyboard
                        FocusScope.of(context).unfocus();
                      },
                      cursorColor: BesyonColors.blue,
                      controller: _bgController,
                      decoration: InputDecoration(
                        suffixIcon: _bgController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(
                                    () {
                                      _bgController.clear();
                                      bgResults = "";
                                    },
                                  );
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: BesyonColors.grey,
                        contentPadding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        hintText: "in mg/dL",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // Blood Glucose Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BesyonColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_bgController.text.isNotEmpty) {
                        setState(() {
                          bgResults = BesyonFunctions()
                              .bgResults(int.parse(_bgController.text));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            closeIconColor: Colors.white,
                            showCloseIcon: true,
                            content: Text(
                              "Please enter blood glucose value",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text(
                      "Calculate",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Blood Glucose Results
                  bgResults.isNotEmpty
                      ? Row(
                          children: [
                            Text(
                              '\t$bgResults : ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                BesyonFunctions().bgInterpretation(bgResults),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          "Enter blood glucose level",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                  _buildDivider(),
                  // Date and Time Taken
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Date Taken
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "\tDate Taken",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          // Text Form Field (Show Calendar)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: TextField(
                              onTap: () async {
                                // Show Calendar
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  setState(
                                    () {
                                      _bgDateController.text = pickedDate
                                          .toString()
                                          .substring(0, 10);
                                    },
                                  );
                                }
                              },
                              onEditingComplete: () {
                                if (_bgDateController.text.isNotEmpty) {
                                  // Close Keyboard
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              cursorColor: BesyonColors.blue,
                              controller: _bgDateController,
                              decoration: InputDecoration(
                                suffixIcon: _bgDateController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(
                                            () {
                                              _bgDateController.clear();
                                            },
                                          );
                                        },
                                      )
                                    : null,
                                filled: true,
                                fillColor: BesyonColors.grey,
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                  bottom: 5,
                                ),
                                hintText: "dd/mm/yyyy",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "\tTime Taken",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          // Time Taken (Using Time Picker)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: TextField(
                              onTap: () async {
                                // Show Time Picker
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  setState(
                                    () {
                                      _bgTimeController.text =
                                          pickedTime.format(context);
                                    },
                                  );
                                }
                              },
                              onEditingComplete: () {
                                if (_bgTimeController.text.isNotEmpty) {
                                  // Close Keyboard
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              cursorColor: BesyonColors.blue,
                              controller: _bgTimeController,
                              decoration: InputDecoration(
                                suffixIcon: _bgTimeController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(
                                            () {
                                              _bgTimeController.clear();
                                            },
                                          );
                                        },
                                      )
                                    : null,
                                filled: true,
                                fillColor: BesyonColors.grey,
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                  bottom: 5,
                                ),
                                hintText: "hh:mm",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Submit Button
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: !_isButtonDisabled
                ? ElevatedButton(
                    onPressed: () async {
                      // Check if all fields are filled
                      if (_nameController.text.isNotEmpty &&
                              _dateOfBirthController.text.isNotEmpty &&
                              _sexController.text.isNotEmpty &&
                              _incomeBracketController.text.isNotEmpty &&
                              _contactNumberController.text.isNotEmpty &&
                              _heightController.text.isNotEmpty &&
                              _weightController.text.isNotEmpty &&
                              _alcoholDrinkerController.text.isNotEmpty ||
                          _drinkingFrequencyController.text.isNotEmpty &&
                              _smokerController.text.isNotEmpty ||
                          _smokingFrequencyController.text.isNotEmpty &&
                              _sedentaryController.text.isNotEmpty &&
                              _bpSystolicController.text.isNotEmpty &&
                              _bpDiastolicController.text.isNotEmpty &&
                              _bpDateController.text.isNotEmpty &&
                              _bpTimeController.text.isNotEmpty &&
                              _bgController.text.isNotEmpty &&
                              _bgDateController.text.isNotEmpty &&
                              _bgTimeController.text.isNotEmpty) {
                        // Disables the button
                        setState(() {
                          _isButtonDisabled = true;
                        });

                        try {
                          var success = await BesyonFunctions().submitForm(
                              _nameController.text,
                              _dateOfBirthController.text,
                              _sexController.text,
                              _incomeBracketController.text,
                              _contactNumberController.text,
                              _heightController.text,
                              _weightController.text,
                              _alcoholDrinkerController.text,
                              _drinkingFrequencyController.text,
                              _smokerController.text,
                              _smokingFrequencyController.text,
                              _sedentaryController.text,
                              _bpSystolicController.text,
                              _bpDiastolicController.text,
                              _bpDateController.text,
                              _bpTimeController.text,
                              bpResults,
                              _bgController.text,
                              _bgDateController.text,
                              _bgTimeController.text,
                              bgResults);

                          if (success) {
                            // Show SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                closeIconColor: Colors.white,
                                showCloseIcon: true,
                                backgroundColor: BesyonColors.purple,
                                content: const Text(
                                  "Form Submitted",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );

                            // Clear all fields
                            _nameController.clear();
                            _dateOfBirthController.clear();
                            _sexController.clear();
                            _incomeBracketController.clear();
                            _contactNumberController.clear();
                            _heightController.clear();
                            _weightController.clear();
                            _alcoholDrinkerController.clear();
                            _drinkingFrequencyController.clear();
                            _smokerController.clear();
                            _smokingFrequencyController.clear();
                            _sedentaryController.clear();
                            _bpSystolicController.clear();
                            _bpDiastolicController.clear();
                            _bpDateController.clear();
                            _bpTimeController.clear();
                            _bgController.clear();
                            _bgDateController.clear();
                            _bgTimeController.clear();

                            setState(() {
                              bpResults = "";
                              bgResults = "";
                              bmi = "";

                              // reload page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(
                                    title: 'Besyon',
                                  ),
                                ),
                              );
                            });
                          } else {
                            // Show SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                showCloseIcon: true,
                                closeIconColor: Colors.white,
                                backgroundColor: BesyonColors.purple,
                                content: const Text(
                                  "Data was stored locally, it will be uploaded when you have an internet connection",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );

                            // Clear all fields
                            _nameController.clear();
                            _dateOfBirthController.clear();
                            _sexController.clear();
                            _incomeBracketController.clear();
                            _contactNumberController.clear();
                            _heightController.clear();
                            _weightController.clear();
                            _alcoholDrinkerController.clear();
                            _drinkingFrequencyController.clear();
                            _smokerController.clear();
                            _smokingFrequencyController.clear();
                            _sedentaryController.clear();
                            _bpSystolicController.clear();
                            _bpDiastolicController.clear();
                            _bpDateController.clear();
                            _bpTimeController.clear();
                            _bgController.clear();
                            _bgDateController.clear();
                            _bgTimeController.clear();

                            setState(() {
                              bpResults = "";
                              bgResults = "";
                              bmi = "";

                              // reload page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(
                                    title: 'Besyon',
                                  ),
                                ),
                              );
                            });
                          }
                        } catch (e) {
                          // Show SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              showCloseIcon: true,
                              closeIconColor: Colors.white,
                              backgroundColor: Colors.red,
                              content: Text(
                                "Error Submitting Form, Please Try Again",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }
                      }

                      // Show SnackBar if not all fields are filled
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            showCloseIcon: true,
                            closeIconColor: Colors.white,
                            backgroundColor: Colors.red,
                            content: Text(
                              "Please Fill All Fields",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }

                      // Re-enable the button
                      setState(() {
                        _isButtonDisabled = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BesyonColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: BesyonColors.blue,
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}
