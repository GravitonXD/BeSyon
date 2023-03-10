import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BesyonFunctions {
  String bpResults(systolic, diastolic) {
    var _systolic = int.parse(systolic);
    var _diastolic = int.parse(diastolic);
    // Blood Pressure Results
    // Normal: < 120/80 mmHg
    // Borderline: 120-139/80-89 mmHg
    // Hypertension: > 140/90 mmHg

    if (_systolic <= 120 && _diastolic <= 80) {
      return "Normal";
    } else if (_systolic > 120 &&
        _systolic <= 139 &&
        _diastolic > 80 &&
        _diastolic <= 89) {
      return "Borderline";
    } else if (_systolic >= 140 && _diastolic >= 90) {
      return "Hypertension";
    } else {
      return "Invalid Entry";
    }
  }

  String bpInterpretation(bpRes) {
    if (bpRes == "Normal") {
      return "Your blood pressure is normal.";
    } else if (bpRes == "Elevated") {
      return "Your blood pressure is borderline. Maintain a healthy lifestyle.";
    } else if (bpRes == "Hypertension") {
      return "You are hypertensive. Make sure to take your maintenance medicine/s and maintain a healthy lifestyle.";
    } else {
      return "Systolic and diastolic values are invalid.";
    }
  }

  String bgResults(bg) {
    // Blood Glucose Results
    // Normal: 70-99 mg/dL
    // Prediabetes: 100-125 mg/dL
    // Diabetes: > 126 mg/dL

    if (bg >= 70 && bg <= 99) {
      return "Normal";
    } else if (bg >= 100 && bg <= 125) {
      return "Prediabetes";
    } else if (bg >= 126) {
      return "Diabetes";
    } else {
      return "Invalid Entry";
    }
  }

  String bgInterpretation(bgRes) {
    if (bgRes == "Normal") {
      return "Your blood glucose is normal.";
    } else if (bgRes == "Prediabetes") {
      return "You have prediabetes. Maintain a healthy lifestyle.";
    } else if (bgRes == "Diabetes") {
      return "You are diabetic. Make sure to take your maintenance medicine/s and maintain a healthy lifestyle.";
    } else {
      return "Blood glucose value is invalid.";
    }
  }

  double bmiCalculator(height, weight) {
    // Height in cm, weight in kg
    height = height / 100;
    double bmi = weight / (height * height);
    return bmi;
  }

  String bmiClassifier(bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Normal";
    } else if (bmi >= 25 && bmi < 30) {
      return "Overweight";
    } else if (bmi >= 30) {
      return "Obese";
    } else {
      return "Error";
    }
  }

  Future<bool> submitForm(
    name,
    dateOfBirth,
    sex,
    incomeBracket,
    contactNumber,
    height,
    weight,
    alcoholDrinker,
    drinkingFrequency,
    smoker,
    smokingFrequency,
    sedentary,
    bpSystolic,
    bpDiastolic,
    bpDate,
    bpTime,
    bpResults,
    bg,
    bgDate,
    bgTime,
    bgResults,
  ) async {
    // Calculate BMI
    double bmi = bmiCalculator(double.parse(height), double.parse(weight));
    // Determine BMI Classification
    String bmiClassification = bmiClassifier(bmi);
    const String scriptURL =
        'https://script.google.com/a/macros/up.edu.ph/s/AKfycbxQy7W2u6AABB3hBE_IXiRLvs7PZKj6jEviA_h-ZG7kFfA0Xwc5d1p-mEkjsib2ebkzJg/exec';

    String queryString =
        "?name=$name&dateOfBirth=$dateOfBirth&sex=$sex&incomeBracket=$incomeBracket&contactNumber=$contactNumber&height=$height&weight=$weight&bmi=$bmi&bmiClassification=$bmiClassification&alcoholDrinker=$alcoholDrinker&drinkingFrequency=$drinkingFrequency&smoker=$smoker&smokingFrequency=$smokingFrequency&sedentary=$sedentary&bpSystolic=$bpSystolic&bpDiastolic=$bpDiastolic&bpDate=$bpDate&bpTime=$bpTime&bpResults=$bpResults&bg=$bg&bgDate=$bgDate&bgTime=$bgTime&bgResults=$bgResults";

    var finalURI = Uri.parse(scriptURL + queryString);
    print(finalURI);
    var response = await http.get(finalURI);
    //print(finalURI);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class BesyonStatic {
  // Income Bracket List
  final List<String> incomeBrackets = [
    "Annual Income",
    "Below 120,000",
    "120,001 to 300,000",
    "300,001 to 600,000",
    "over 600,000",
    "Prefer not to say",
  ];

  // Sex at Birth List
  final List<String> sexAtBirth = [
    "As Assigned at Birth",
    "Male",
    "Female",
  ];

  // Alcohol Frequency
  final List<String> alcoholFrequency = [
    "Select Drinking Frequency",
    "Monthly or Less (1 point)",
    "2 to 4 times a month (2 points)",
    "2 to 3 times a week (3 points)",
    "4 or more times a week (4 points)"
  ];

  // Smoking Frequency
  final List<String> smokingFrequency = [
    "Select Smoking Frequency",
    "10 cigarettes or less",
    "11-20",
    "21-30",
    "31 or more"
  ];
}
