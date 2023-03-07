import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BesyonFunctions {
  String bpResults(systolic, diastolic) {
    // Blood Pressure Results
    // Normal: < 120/80 mmHg
    // Elevated: 120-139/80-89 mmHg
    // Hypertension: > 140/90 mmHg

    if (systolic < 120 && diastolic < 80) {
      return "Normal";
    } else if (systolic >= 120 &&
        systolic <= 139 &&
        diastolic >= 80 &&
        diastolic <= 89) {
      return "Elevated";
    } else if (systolic >= 140 && diastolic >= 90) {
      return "Hypertension";
    } else {
      return "Error";
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
    } else if (bg > 126) {
      return "Diabetes";
    } else {
      return "Error";
    }
  }

  void submitForm(
    name,
    dateOfBirth,
    sex,
    incomeBracket,
    contactNumber,
    height,
    weight,
    bmi,
    bmiClassification,
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
    const String scriptURL =
        'https://script.google.com/a/macros/up.edu.ph/s/AKfycbxQy7W2u6AABB3hBE_IXiRLvs7PZKj6jEviA_h-ZG7kFfA0Xwc5d1p-mEkjsib2ebkzJg/exec';

    String queryString =
        "?name=$name&dateOfBirth=$dateOfBirth&sex=$sex&incomeBracket=$incomeBracket&contactNumber=$contactNumber&height=$height&weight=$weight&bmi=$bmi&bmiClassification=$bmiClassification&alcoholDrinker=$alcoholDrinker&drinkingFrequency=$drinkingFrequency&smoker=$smoker&smokingFrequency=$smokingFrequency&sedentary=$sedentary&bpSystolic=$bpSystolic&bpDiastolic=$bpDiastolic&bpDate=$bpDate&bpTime=$bpTime&bpResults=$bpResults&bg=$bg&bgDate=$bgDate&bgTime=$bgTime&bgResults=$bgResults";

    var finalURI = Uri.parse(scriptURL + queryString);
    print(finalURI);
    var response = await http.get(finalURI);
    //print(finalURI);

    if (response.statusCode == 200) {
      print("Success");
    } else {
      print("Error");
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
    "Male",
    "Female",
  ];
}
