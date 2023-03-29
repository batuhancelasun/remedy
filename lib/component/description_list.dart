class Medicine {
  Medicine({required this.title, required this.description});

  String description;
  String title;
}

List<Medicine> medicineList = [
  Medicine(title: "Parol", description: "Ağrı Kesici"),
  Medicine(title: "Aferin", description: "Ateş Düşürücü"),
  Medicine(title: "Lexapro", description: "Antidepresan"),
];
