import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Yield Prediction',
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.greenAccent,
        fontFamily: 'Roboto',
      ),
      home: CropYieldForm(),
    );
  }
}

class CropYieldForm extends StatefulWidget {
  @override
  _CropYieldFormState createState() => _CropYieldFormState();
}

class _CropYieldFormState extends State<CropYieldForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _rainfallController = TextEditingController();
  final TextEditingController _pesticidesController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();

  // State for API response
  String? _predictionResult;
  bool _isLoading = false;

  // API URL
  // ignore: unused_field
  //final String _apiUrl = 'https://summative-regression.onrender.com/predict'; // Update this with your deployed URL.

  // Submit form and make API call
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _predictionResult = null; // Clear previous result
      });

      // Prepare data for the API
      Map<String, dynamic> data = {
        'Area': int.parse(_areaController.text),
        'Item': int.parse(_itemController.text),
        'Year': int.parse(_yearController.text),
        'average_rain_fall_mm_per_year': double.parse(_rainfallController.text),
        'pesticides_tonnes': double.parse(_pesticidesController.text),
        'avg_temp': double.parse(_temperatureController.text),
      };

      try {
        // Make API call
        final response = await http.post(
          Uri.parse('https://summative-regression.onrender.com/predict'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          setState(() {
            _predictionResult = 'Predicted Yield: ${result['predicted_yield']} hg/ha';
          });
        } else {
          setState(() {
            _predictionResult = 'Error: ${response.reasonPhrase}';
          });
        }
      } catch (e) {
        setState(() {
          _predictionResult = 'Error: Failed to connect to the server.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Yield Prediction'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Page Title
              Center(
                child: Text(
                  'Predict Crop Yield',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Area Input
              _buildTextField(
                label: 'Area (as integer)',
                controller: _areaController,
                hint: 'Enter area code (e.g., 1 for Albania)',
              ),

              // Item Input
              _buildTextField(
                label: 'Item (as integer)',
                controller: _itemController,
                hint: 'Enter item code (e.g., 1 for Maize)',
              ),

              // Year Input
              _buildTextField(
                label: 'Year',
                controller: _yearController,
                hint: 'Enter year (e.g., 2022)',
              ),

              // Average Rainfall Input
              _buildTextField(
                label: 'Average Rainfall (mm/year)',
                controller: _rainfallController,
                hint: 'Enter rainfall in mm',
              ),

              // Pesticides Used Input
              _buildTextField(
                label: 'Pesticides Used (tonnes)',
                controller: _pesticidesController,
                hint: 'Enter pesticides in tonnes',
              ),

              // Average Temperature Input
              _buildTextField(
                label: 'Average Temperature (°C)',
                controller: _temperatureController,
                hint: 'Enter temperature in °C',
              ),

              // Submit Button
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Predict Yield'),
              ),

              // Display Prediction Result
              if (_predictionResult != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      _predictionResult!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for building styled text fields
  Widget _buildTextField({required String label, required TextEditingController controller, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: const Color.fromRGBO(238, 238, 238, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
