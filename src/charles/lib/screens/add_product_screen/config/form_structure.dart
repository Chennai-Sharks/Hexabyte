import 'package:flutter/material.dart';

final List<Map<String, dynamic>> addProductFormStructure = [
  {
    'type': 'text',
    'name': 'title',
    'label': 'Enter title',
    'required': true,
    'keyboardType': TextInputType.name,
  },
  {
    'type': 'text',
    'name': 'duration',
    'label': 'Enter duration(no. of months)',
    'required': true,
    'keyboardType': TextInputType.number
  },
  {
    'type': 'text',
    'name': 'description',
    'label': 'Enter description',
    'required': true,
    'keyboardType': TextInputType.multiline,
    'multiline': true,
  },
  {
    'type': 'text',
    'name': 'total_qty',
    'label': 'Enter total quantity',
    'required': true,
    'keyboardType': TextInputType.number
  },
  {
    'type': 'multichip',
    'name': 'tags',
    'label': 'Select Product tags',
    'required': true,
    'values': [
      'food_waste',
      'organic_waste',
      'fruit_pulp',
      'fruit_peels',
      'fruit_seeds',
      'vegetable_peels',
      'sugary_starchy_waste',
      'fatty_foodwaste',
      'edible_oilwaste',
    ],
  },
];
