import 'package:flutter/material.dart';
import './movie_list_item.dart';
import './get_data.dart';

class MovieList extends StatelessWidget {
  var _data;
  var _tab;
  var _filter;

  MovieList(List<MovieListItem> data, tab, filter) {
    this._tab = tab;
    this._filter = filter; //ako je true ne prikazuj cinestar - hejter mode
    this._data = data
        .where((element) =>
            element.datum ==
            //Data.getDatum(DateTime.now().add(Duration(days: _tab))))
            tab)
        .where(
      (element) {
        if (this._filter) {
          if (element.kino == 'C') {
            return false;
          }
        }
        return true;
      },
    ).toList();
    this._data.sort((MovieListItem a, MovieListItem b) =>
        a.vrijeme.replaceAll(':', '').compareTo(b.vrijeme.replaceAll(':', '')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _data,
      /*.map(
            (e) => MovieListItem(
              e.naziv,
              e.redatelj,
              e.vrijeme,
              e.kino,
            ),
          )
          .toList()*/
    );
  }
}
