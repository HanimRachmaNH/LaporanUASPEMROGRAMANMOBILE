import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sugarcareapp/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model
class BloodSugarRecord {
  String dateTime;
  double bloodSugarLevel;
  String period;
  bool beforeMeal;
  String notes;

  BloodSugarRecord({
    required this.dateTime,
    required this.bloodSugarLevel,
    required this.period,
    required this.beforeMeal,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'blood_sugar_level': bloodSugarLevel,
      'period': period,
      'before_meal': beforeMeal ? 1 : 0,
      'notes': notes,
    };
  }

  factory BloodSugarRecord.fromJson(Map<String, dynamic> json) {
    String dateTimeString = json['dateTime'].toString();
    DateTime? dateTime;

    if (dateTimeString.contains(RegExp(r'\d{4}-\d{2}-\d{2}'))) {
      try {
        dateTime = DateTime.parse(dateTimeString);
      } catch (e) {
        print('Failed to parse ISO 8601 format: $e');
      }
    } else {
      List<String> customFormats = [
        "d MMMM",
        "d MMMM yyyy",
        "yyyy-MM-ddTHH:mm:ss.SSS",
        "yyyy-MM-ddTHH:mm:ss",
      ];

      for (String format in customFormats) {
        try {
          dateTime = DateFormat(format, 'id').parse(dateTimeString);
          break;
        } catch (e) {
          print('Failed to parse date with format $format: $e');
        }
      }
    }

    if (dateTime == null) {
      throw FormatException("Invalid date format string: $dateTimeString");
    }

    return BloodSugarRecord(
      dateTime: dateTime.toIso8601String(),
      bloodSugarLevel: json['blood_sugar_level'].toDouble(),
      period: json['period'].toString(),
      beforeMeal: json['before_meal'] == true,
      notes: json['notes'].toString(),
    );
  }
}

// Data Model
class DataModel extends ChangeNotifier {
  List<BloodSugarRecord> _records = [];

  List<BloodSugarRecord> get records => _records;

  void addRecord(BloodSugarRecord record) {
    _records.add(record);
    notifyListeners();
  }

  void setRecords(List<BloodSugarRecord> records) {
    _records = records;
    notifyListeners();
  }
}

// Record Page
class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _sugarLevelController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedPeriod = 'Breakfast';
  bool _beforeMeal = true;

  @override
  void dispose() {
    _sugarLevelController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveRecord(BloodSugarRecord record) async {
    final url = Uri.parse('http://127.0.0.1:8000/save_record/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(record.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error saving record: ${response.body}');
    }
  }

  Future<List<BloodSugarRecord>> fetchRecords() async {
    final url = Uri.parse('http://127.0.0.1:8000/get_records/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print('Fetched data: $responseData');
        return responseData.map((record) => BloodSugarRecord.fromJson(record)).toList();
      } else {
        throw Exception('Failed to load records');
      }
    } catch (e) {
      throw Exception('Error fetching records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: FutureBuilder<List<BloodSugarRecord>>(
        future: fetchRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No records available'));
          } else {
            List<BloodSugarRecord> records = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _sugarLevelController,
                            decoration: InputDecoration(
                              labelText: 'Blood Sugar Level (mg/dL)',
                              labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF489D26)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF9D0063)),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your blood sugar level';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: _selectedPeriod,
                            items: ['Breakfast', 'Lunch', 'Dinner']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedPeriod = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Period',
                              labelStyle: TextStyle(color: Color(0xFF489D26)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF489D26)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF9D0063)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Before Meal', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                              Switch(
                                value: _beforeMeal,
                                onChanged: (value) {
                                  setState(() {
                                    _beforeMeal = value;
                                  });
                                },
                                activeColor: Color(0xFF9D0063),
                              ),
                              Text('After Meal', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                            ],
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _notesController,
                            decoration: InputDecoration(
                              labelText: 'Notes',
                              labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF489D26)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF9D0063)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final bloodSugarLevel = double.parse(_sugarLevelController.text);
                                final record = BloodSugarRecord(
                                  dateTime: DateTime.now().toIso8601String(),
                                  bloodSugarLevel: bloodSugarLevel,
                                  period: _selectedPeriod,
                                  beforeMeal: _beforeMeal,
                                  notes: _notesController.text,
                                );
                                try {
                                  await _saveRecord(record);
                                  Provider.of<DataModel>(context, listen: false).addRecord(record);
                                  setState(() {
                                    _sugarLevelController.clear();
                                    _notesController.clear();
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving record: $e')));
                                }
                              }
                            },
                            child: Text('Save Record'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF9D0063),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Date', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
                          DataColumn(label: Text('Level', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
                          DataColumn(label: Text('Period', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
                          DataColumn(label: Text('Before Meal', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
                          DataColumn(label: Text('Notes', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
                        ],
                        rows: records.map((record) {
                          return DataRow(
                            cells: [
                              DataCell(Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(record.dateTime)))),
                              DataCell(Text(record.bloodSugarLevel.toStringAsFixed(2))),
                              DataCell(Text(record.period)),
                              DataCell(Text(record.beforeMeal ? 'Yes' : 'No')),
                              DataCell(Text(record.notes)),
                            ],
                          );
                        }).toList(),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        headingRowColor: MaterialStateProperty.all(Color(0xFF9D0063)),
                        headingTextStyle: TextStyle(color: Colors.white),
                        dataRowColor: MaterialStateProperty.all(Colors.white),
                        dataTextStyle: TextStyle(color: Color(0xFF489D26)),
                        columnSpacing: 16.0,
                        dividerThickness: 1.0,
                        border: TableBorder(
                          verticalInside: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
                          horizontalInside: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 400,
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(),
                        title: ChartTitle(
                          text: 'Blood Sugar Levels Over Time',
                          textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        legend: Legend(isVisible: true, textStyle: TextStyle(color: Color(0xFF489D26))),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          LineSeries<BloodSugarRecord, DateTime>(  
                            dataSource: records,
                            xValueMapper: (BloodSugarRecord record, _) => DateTime.parse(record.dateTime),
                            yValueMapper: (BloodSugarRecord record, _) => record.bloodSugarLevel,
                            name: 'Blood Sugar Level',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                            color: Color(0xFF9D0063),
                          ),
                        ],
                        plotAreaBorderColor: Color(0xFF489D26),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataModel(),
      child: MaterialApp(
        title: 'SugarCare',
        home: RecordPage(),
      ),
    ),
  );
}
