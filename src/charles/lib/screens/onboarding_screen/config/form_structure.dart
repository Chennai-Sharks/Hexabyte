import 'package:flutter/material.dart';

final List<Map<String, dynamic>> onBoardingForm = [
  {
    'type': 'text',
    'name': 'name',
    'label': 'Enter name',
    'required': true,
    'keyboardType': TextInputType.name,
  },
  {
    'type': 'text',
    'name': 'age',
    'label': 'Enter Age',
    'required': true,
    'keyboardType': TextInputType.number,
  },
  {
    'type': 'text',
    'name': 'email',
    'label': 'Enter Email',
    'required': true,
    'keyboardType': TextInputType.emailAddress
  },
  {
    'type': 'text',
    'name': 'business',
    'label': 'What type of business',
    'required': true,
    'keyboardType': TextInputType.name
  },
];
