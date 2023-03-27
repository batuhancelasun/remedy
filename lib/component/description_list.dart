import 'package:flutter/material.dart';

class Medicine {
  String title;
  String description;

  Medicine({required this.title, required this.description});
}

List<Medicine> medicineList = [
  Medicine(title: "Parol", description: "Ağrı Kesici"),
  Medicine(title: "Aferin", description: "Ateş Düşürücü"),
  Medicine(title: "Lexapro", description: "Antidepresan"),
];
