import 'package:flutter/material.dart';

class MovieListItem extends StatelessWidget {
  final String naziv;
  final String redatelj;
  final String vrijeme;
  final String kino;
  final String datum;

  MovieListItem(this.naziv, this.redatelj, this.vrijeme, this.kino, this.datum);

  dynamic getNazivKina(kino) {
    dynamic rezultat;
    if (kino == 'T') {
      rezultat = 'KINO TUŠKANAC';
    } else if (kino == 'K') {
      rezultat = 'KINOTEKA';
    } else {
      rezultat = 'CINESTAR';
    }
    return rezultat;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green[100],
            border: Border(
              top: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(getNazivKina(this.kino),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(this.naziv,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(this.redatelj),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    this.vrijeme,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0,
        ),
      ],
    );
  }
}
