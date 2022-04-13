class Car {
  final String numero_chasis;
  final String marque ;
  final String modele;
  final String type;
  final int tarification;
  final String image;

  Car({required this.numero_chasis,required  this.marque,required  this.modele, required this.type, required  this.tarification, required this.image});

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
