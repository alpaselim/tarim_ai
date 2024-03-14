class SoilAnalysis {
  String? fieldId;
  dynamic latitude;
  dynamic longitude;
  String? fieldName;
  String? climate;
  String? soilStructure;
  String? soilReaction;
  String? electricalConductivity;
  String? limeContent;
  String? organicMatter;
  String? totalNitrogen;
  String? phosphorusContent;
  String? calsiyum;
  String? magnesium;
  String? sodium;
  String? potassium;
  String? iron;
  String? copper;
  String? zinc;
  String? manganese;
  String? boron;

  SoilAnalysis({
    this.fieldId,
    this.latitude,
    this.longitude,
    this.fieldName,
    this.climate,
    this.soilStructure,
    this.soilReaction,
    this.electricalConductivity,
    this.limeContent,
    this.organicMatter,
    this.totalNitrogen,
    this.phosphorusContent,
    this.calsiyum,
    this.magnesium,
    this.sodium,
    this.potassium,
    this.iron,
    this.copper,
    this.zinc,
    this.manganese,
    this.boron,
  });

  SoilAnalysis.fromJson(Map<String, dynamic> json) {
    fieldId = json['fieldId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    fieldName = json['fieldName'];
    climate = json['climate'];
    soilStructure = json['soilStructure'];
    soilReaction = json['soilReaction'];
    electricalConductivity = json['electricalConductivity'];
    limeContent = json['limeContent'];
    organicMatter = json['organicMatter'];
    totalNitrogen = json['totalNitrogen'];
    phosphorusContent = json['phosphorusContent'];
    calsiyum = json['calsiyum'];
    magnesium = json['magnesium'];
    sodium = json['sodium'];
    potassium = json['potassium'];
    iron = json['iron'];
    copper = json['copper'];
    zinc = json['zinc'];
    manganese = json['manganese'];
    boron = json['boron'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['fieldId'] = fieldId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['fieldName'] = fieldName;
    data['climate'] = climate;
    data['soilStructure'] = soilStructure;
    data['soilReaction'] = soilReaction;
    data['electricalConductivity'] = electricalConductivity;
    data['limeContent'] = limeContent;
    data['organicMatter'] = organicMatter;
    data['totalNitrogen'] = totalNitrogen;
    data['phosphorusContent'] = phosphorusContent;
    data['calsiyum'] = calsiyum;
    data['magnesium'] = magnesium;
    data['sodium'] = sodium;
    data['potassium'] = potassium;
    data['iron'] = iron;
    data['copper'] = copper;
    data['zinc'] = zinc;
    data['manganese'] = manganese;
    data['boron'] = boron;
    return data;
  }
}
