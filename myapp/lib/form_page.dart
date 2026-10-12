
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final TextEditingController studentName = TextEditingController();
  final TextEditingController studentSection = TextEditingController();
  final TextEditingController studentYear = TextEditingController();
  final TextEditingController firstSubject = TextEditingController();
  final TextEditingController firstSchedule = TextEditingController();
  final TextEditingController secondSubject = TextEditingController();
  final TextEditingController secondSchedule = TextEditingController();
  final TextEditingController thirdSubject = TextEditingController();
  final TextEditingController thirdSchedule = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveData() async {

    if (studentName.text.trim().isEmpty ||
        studentSection.text.trim().isEmpty ||
        studentYear.text.trim().isEmpty ||
        firstSubject.text.trim().isEmpty ||
        firstSchedule.text.trim().isEmpty ||
        secondSubject.text.trim().isEmpty ||
        secondSchedule.text.trim().isEmpty ||
        thirdSubject.text.trim().isEmpty ||
        thirdSchedule.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    await firestore.collection('biodata').add({
      'Name': studentName.text.trim(),
      'Section': studentSection.text.trim(),
      'Year': studentYear.text.trim(),
      'Subject1': firstSubject.text.trim(),
      'Schedule1': firstSchedule.text.trim(),
      'Subject2': secondSubject.text.trim(),
      'Schedule2': secondSchedule.text.trim(),
      'Subject3': thirdSubject.text.trim(),
      'Schedule3': thirdSchedule.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data Saved Successfully'),
      ),
    );

    studentName.clear();
    studentSection.clear();
    studentYear.clear();
    firstSubject.clear();
    firstSchedule.clear();
    secondSubject.clear();
    secondSchedule.clear();
    thirdSubject.clear();
    thirdSchedule.clear();
  }

  @override
  void dispose() {
    studentName.dispose();
    studentSection.dispose();
    studentYear.dispose();
    firstSubject.dispose();
    firstSchedule.dispose();
    secondSubject.dispose();
    secondSchedule.dispose();
    thirdSubject.dispose();
    thirdSchedule.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student Registration'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: studentName,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: studentSection,
              decoration: const InputDecoration(
                labelText: 'Section',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: studentYear,
              decoration: const InputDecoration(
                labelText: 'Year',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(
                      firstSubject: firstSubject,
                      firstSchedule: firstSchedule,
                      secondSubject: secondSubject,
                      secondSchedule: secondSchedule,
                      thirdSubject: thirdSubject,
                      thirdSchedule: thirdSchedule,
                      saveData: saveData,
                    ),
                  ),
                );

              },
              child: const Text('Next'),
            ),

          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {

  final TextEditingController firstSubject;
  final TextEditingController firstSchedule;
  final TextEditingController secondSubject;
  final TextEditingController secondSchedule;
  final TextEditingController thirdSubject;
  final TextEditingController thirdSchedule;
  final Future<void> Function() saveData;

  const SecondScreen({
    super.key,
    required this.firstSubject,
    required this.firstSchedule,
    required this.secondSubject,
    required this.secondSchedule,
    required this.thirdSubject,
    required this.thirdSchedule,
    required this.saveData,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Subject Schedule'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const SizedBox(height: 24),

            TextField(
              controller: widget.firstSubject,
              decoration: const InputDecoration(
                labelText: 'Subject 1',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: widget.firstSchedule,
              decoration: const InputDecoration(
                labelText: 'Schedule 1',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: widget.secondSubject,
              decoration: const InputDecoration(
                labelText: 'Subject 2',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: widget.secondSchedule,
              decoration: const InputDecoration(
                labelText: 'Schedule 2',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: widget.thirdSubject,
              decoration: const InputDecoration(
                labelText: 'Subject 3',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: widget.thirdSchedule,
              decoration: const InputDecoration(
                labelText: 'Schedule 3',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                widget.saveData();
              },
              child: const Text('Submit'),
            ),

          ],
        ),
      ),
    );
  }
}
