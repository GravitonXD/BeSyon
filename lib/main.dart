import 'package:flutter/material.dart';
import 'package:besyon/besyon_colors.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Besyon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PersonalInfo(title: 'PERSONAL INFORMATION'),
    );
  }
}

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key, required this.title});

  final String title;

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
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

  // Income Bracket List
  final List<String> _incomeBrackets = [
    "Annual Income",
    "Below 120,000",
    "120,001 to 300,000",
    "300,001 to 600,000",
    "over 600,000",
    "Prefer not to say",
  ];

  final List<String> _sexAtBirth = [
    "Male",
    "Female",
  ];

  String bmi = "";
  void _calculateBMI(height, weight) {
    double _height = double.parse(height);
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

  _hasContent() {
    return _nameController.text.isNotEmpty ||
        _dateOfBirthController.text.isNotEmpty ||
        _sexController.text.isNotEmpty ||
        _incomeBracketController.text.isNotEmpty ||
        _contactNumberController.text.isNotEmpty ||
        _heightController.text.isNotEmpty ||
        _weightController.text.isNotEmpty;
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height * 0.075,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
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

                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                      thickness: 0,
                      indent: 0,
                      endIndent: 0,
                    ),

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
                                  suffixIcon: _dateOfBirthController
                                          .text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(
                                              () {
                                                _dateOfBirthController.clear();
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
                                "\tSex Assigned at Birth",
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
                                value: _sexAtBirth[0],
                                items: _sexAtBirth.map((String value) {
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

                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                      thickness: 0,
                      indent: 0,
                      endIndent: 0,
                    ),

                    // Income Bracket Input Box
                    const Text(
                      "\tIncome Bracket",
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
                      value: _incomeBrackets[0],
                      items: _incomeBrackets.map((String value) {
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

                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                      thickness: 0,
                      indent: 0,
                      endIndent: 0,
                    ),

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

                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                      thickness: 0,
                      indent: 0,
                      endIndent: 0,
                    ),

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
                                },
                                cursorColor: BesyonColors.blue,
                                controller: _heightController,
                                decoration: InputDecoration(
                                  suffixIcon: _heightController.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(() {
                                              _heightController.clear();
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
                                  hintText: "in meters",
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
                                },
                                cursorColor: BesyonColors.blue,
                                controller: _weightController,
                                decoration: InputDecoration(
                                  suffixIcon: _weightController.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(() {
                                              _weightController.clear();
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
                                  hintText: "in kilograms",
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

                    const Divider(
                      height: 10,
                      color: Colors.transparent,
                      thickness: 0,
                      indent: 0,
                      endIndent: 0,
                    ),

                    // BMI
                    Row(
                      children: [
                        const Text(
                          "\tBMI: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          bmi,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                      thickness: 0,
                      indent: 0,
                      endIndent: 0,
                    ),

                    // Clear All (Text Button)
                    _hasContent()
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Confirm to clear all
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Clear All"),
                                    content: const Text(
                                        "Are you sure you want to clear all?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _nameController.clear();
                                          _dateOfBirthController.clear();
                                          _sexController.clear();
                                          _incomeBracketController.clear();
                                          _contactNumberController.clear();
                                          _heightController.clear();
                                          _weightController.clear();
                                          setState(() {
                                            bmi = "";
                                          });
                                        },
                                        child: const Text("Clear All"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Clear All",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          )
                        : const Text(""),
                  ],
                ),
              ),

              // Next Button
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _hasContent()
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BesyonColors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              // Proceed to LifeStyle Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LifeStylePage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const Text(""),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LifeStylePage extends StatefulWidget {
  const LifeStylePage({Key? key}) : super(key: key);

  @override
  State<LifeStylePage> createState() => _LifeStylePageState();
}

class _LifeStylePageState extends State<LifeStylePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("LifeStyle Page"),
      ),
    );
  }
}
