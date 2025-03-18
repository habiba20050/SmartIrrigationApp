import 'package:flutter/material.dart';

class FarmerDetailsPage extends StatefulWidget {
  const FarmerDetailsPage({super.key});

  @override
  _FarmerDetailsPageState createState() => _FarmerDetailsPageState();
}

class _FarmerDetailsPageState extends State<FarmerDetailsPage> {
  String? plantType;
  String? soilType;
  String? spacing;
  int? numberOfAcres;
  int? numberOfPlants;
  double? calculatedWater;

  final plantTypes = ['Coconut', 'Banana', 'Mango', 'Guava', 'Pomegranate', 'Sugar cane'];
  final soilTypes = ['Loamy', 'Sandy', 'Clayey', 'Silty', 'Peaty'];

  void calculateWaterRequirement() {
    if (numberOfAcres != null && numberOfPlants != null) {
      setState(() {
        calculatedWater = numberOfPlants! * 0.5; // Example: 0.5 liters per plant
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmer Details',
          style: TextStyle(color: Colors.white), // ✅ Title remains white
        ),
        backgroundColor: const Color(0xFF1B401D), // ✅ Primary Color
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home'); // Navigate back to home
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFF2F2F2), // ✅ Background Color
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ✅ Card for better form presentation
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDropdownField('Plant Type', plantType, plantTypes, (value) {
                        setState(() {
                          plantType = value;
                        });
                      }),
                      buildDropdownField('Soil Type', soilType, soilTypes, (value) {
                        setState(() {
                          soilType = value;
                        });
                      }),
                      const SizedBox(height: 10),

                      // ✅ Input Fields
                      buildNumberField('Number of Acres', (value) {
                        setState(() {
                          numberOfAcres = int.tryParse(value);
                        });
                      }),
                      buildNumberField('Number of Plants', (value) {
                        setState(() {
                          numberOfPlants = int.tryParse(value);
                        });
                      }),
                      const SizedBox(height: 10),

                      // ✅ Calculate Button
                      Center(
                        child: ElevatedButton(
                          onPressed: calculateWaterRequirement,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF255929), // ✅ Secondary Color
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Calculate Water', style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Display Water Requirement
              if (calculatedWater != null)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Required Water: ${calculatedWater!.toStringAsFixed(2)} liters',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0C260E), // ✅ Accent Color
                        ),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // ✅ OK Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B401D), // ✅ Primary Color
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('OK', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Dropdown Field Widget
  Widget buildDropdownField(String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        value: value,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // ✅ Number Input Field Widget
  Widget buildNumberField(String label, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
