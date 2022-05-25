import 'package:flutter/material.dart';
import '../components/WBack.dart';

void main() {
  runApp(MaterialApp(
    home: FactureDetails(
        nomLoc: "someone",
        numeroChassis: "numeroChassis",
        heureDebut: "heureDebut",
        heureFin: " heureFin",
        region: "region",
        dateDebut: DateTime.now(),
        idFacture: 1,
        montant: 121323,
        marque: " marque",
        modele: " modele"),
  ));
}

class FactureDetails extends StatefulWidget {
  final String nomLoc;
  final String numeroChassis;
  final String heureDebut;
  final String heureFin;
  final String region;
  final DateTime dateDebut;
  final int idFacture;
  final int montant;
  final String marque;
  final String modele;
  const FactureDetails({
    Key? key,
    required this.nomLoc,
    required this.numeroChassis,
    required this.heureDebut,
    required this.heureFin,
    required this.region,
    required this.dateDebut,
    required this.idFacture,
    required this.montant,
    required this.marque,
    required this.modele,
  }) : super(key: key);

  @override
  State<FactureDetails> createState() => _FactureDetailsState();
}

class _FactureDetailsState extends State<FactureDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: const [
                  WidgetArrowBack(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Details de la facture ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xff2E9FB0)),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.nomLoc.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Image.asset(
                    "assets/logo.png",
                    width: 120,
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                "Informations facture : ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E9FB0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(" N° : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        Text("${widget.idFacture}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 19)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(" Date : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        Text(
                            "${widget.dateDebut.day}-${widget.dateDebut.month}-${widget.dateDebut.year}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 19)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(" Heure : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        Text("${widget.heureDebut}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 19)),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(5),
                  height: 55,
                  width: size.width * 0.7,
                  decoration: const BoxDecoration(
                    color: Color(0xff9AD4E2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Prix Total :",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 21,
                              color: Color(0xff042A2B),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.montant} DA",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, color: Color(0xff042A2B)),
                      )
                    ],
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Divider(
                thickness: 1,
                indent: 18,
                endIndent: 18,
                color: Colors.black,
                height: 25,
              ),
              const Text(
                "Informations trajet : ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E9FB0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [                
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.dateDebut.day}-${widget.dateDebut.month}-${widget.dateDebut.year} ${widget.heureDebut}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.region}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "${widget.dateDebut.day}-${widget.dateDebut.month}-${widget.dateDebut.year} ${widget.heureFin}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.region}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Divider(
                thickness: 1,
                indent: 18,
                endIndent: 18,
                color: Colors.black,
                height: 25,
              ),
              const Text(
                "Informations véhicule : ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E9FB0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(" Numero de chasis : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.height * 0.008,
                        ),
                        Text("${widget.numeroChassis}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 19)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(" Type de vehicule : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.height * 0.008,
                        ),
                        Text("${widget.marque} ${widget.modele}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 19)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black,
                      height: 25,
                    ),
                    const Text("Merci pour ")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
