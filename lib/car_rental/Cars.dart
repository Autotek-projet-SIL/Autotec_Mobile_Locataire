class Car {
   final String numero_chasis;
   String? marque ;
   String? modele;
   String? type;
   int? tarification;
   String? image;

  Car({required this.numero_chasis,required  this.marque,required  this.modele, required this.type, required  this.tarification, required this.image});
  Car.id({required this.numero_chasis});
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      numero_chasis: json['numero_chassis'],
      marque: json['marque'],
      modele: json['modele'],
      tarification: json['tarification'],
      type: json['libelle'],
      image: json['image_vehicule']
    );
  }
}
