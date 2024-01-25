import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  List<Map<String, String>> items = [
    {'Name': 'John', 'Age': '25', 'Country': 'USA'},
    {'Name': 'Alice', 'Age': '30', 'Country': 'Canada'},
    {'Name': 'Bob', 'Age': '22', 'Country': 'UK'},
    // Add more items as needed
  ];

  List<Map<String, String>> filteredItems = [];

  String selectedCountry = 'All';

  @override
  void initState() {
    super.initState();
    // Initialize filteredItems with all items initially
    filteredItems = List.from(items);
  }

  void filterItems() {
    setState(() {
      if (selectedCountry == 'All') {
        // If 'All' is selected, show all items
        filteredItems = List.from(items);
      } else {
        // Filter items based on the selected country
        filteredItems =
            items.where((item) => item['Country'] == selectedCountry).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          value: selectedCountry,
          items: ['All', 'USA', 'Canada', 'UK']
              .map((String country) => DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCountry = newValue ?? 'All';
              filterItems();
            });
          },
        ),
        DataTable(
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('Country')),
          ],
          rows: filteredItems
              .map((item) => DataRow(cells: [
                    DataCell(Text(item['Name'] ?? '')),
                    DataCell(Text(item['Age'] ?? '')),
                    DataCell(Text(item['Country'] ?? '')),
                  ]))
              .toList(),
        ),
      ],
    );
  }
}
