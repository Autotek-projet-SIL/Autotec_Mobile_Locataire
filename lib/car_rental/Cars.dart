// ignore_for_file: file_names

class Car {
   final String numeroChasis;
   String? marque ;
   String? modele;
   String? type;
   int? tarification;
   String? image;

  Car({required this.numeroChasis,required  this.marque,required  this.modele, required this.type, required  this.tarification, required this.image});
  Car.id({required this.numeroChasis});
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      numeroChasis: json['numero_chassis'],
      marque: json['marque'],
      modele: json['modele'],
      tarification: json['tarification'],
      type: json['libelle'],
      image: json['image_vehicule']
    );
  }
}
