import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'dart:convert';

class Data {
  static Future<List<List<String>>> getData() async {
    var url_tuskanac = Uri.parse("http://www.kinotuskanac.hr/schedules");
    List<List<String>> lista = [];
    final response = await http.get(url_tuskanac);
    var document = parse(response.body);

    var lista_dana = document.querySelectorAll("div.col.fifth:not(.past)");
    var naziv, redatelj, vrijeme, kino, datum;
    var nazivi = [], redatelji = [], vremena = [];
    String test = '';

    for (var dan in lista_dana) {
      nazivi = [];
      redatelji = [];
      vremena = [];
      dan.querySelectorAll(".item-time-title").forEach((element) {
        nazivi.add(element.text.trim());
      });
      dan.querySelectorAll(".item-director").forEach((element) {
        redatelji.add(element.text.trim());
      });
      dan.querySelectorAll(".item-time").forEach((element) {
        vremena.add(element.text.trim());
      });
      datum = dan
          .querySelector(".item-date")!
          .text
          .toString()
          .trim()
          .split(' ')[1]
          .substring(0, 6);
      kino = 'T';
      print(datum + '---------------------------------------');
      for (var i = 0; i < nazivi.length; i++) {
        print(nazivi[i]);
        try {
          print(vremena[i]);
        } catch (e) {
          print(vremena[0]);
        }
      }
    }

    return lista;
  }

  static String? getDanUTjednu(dow) {
    var dict = {
      1: 'PON',
      2: 'UTO',
      3: 'SRI',
      4: 'ČET',
      5: 'PET',
      6: 'SUB',
      7: 'NED',
    };
    return dict[dow];
  }

  static List<String> getDatumi() {
    List<String> datumi = [];
    var sysdate = DateTime.now();
    DateTime cur_datum;
    var datum = '';
    for (var i = 0; i < 15; i++) {
      cur_datum = sysdate.add(Duration(days: i));
      datum = cur_datum.day.toString().padLeft(2, '0') +
          '.' +
          cur_datum.month.toString().padLeft(2, '0') +
          '.' +
          ' (' +
          getDanUTjednu(cur_datum.weekday)! +
          ')';
      datumi.add(datum);
    }
    return datumi;
  }

  static String getDatum(DateTime dttm) {
    return dttm.day.toString().padLeft(2, '0') +
        '.' +
        dttm.month.toString().padLeft(2, '0') +
        '.' +
        ' (' +
        getDanUTjednu(dttm.weekday)! +
        ')';
  }

  static /*Future<List<List<String>>>*/ void getDataK() async {
    var url_kinoteka = Uri.parse("https://kinokinoteka.hr/program/");
    final response = await http.get(url_kinoteka);
    var document = parse(response.body);
    var lista_sekcija = document.querySelectorAll("div.row.mt40 > div.gr-12");
    var naziv, redatelj, vrijeme, datum;
    DateTime datum_parse;
    var kino = 'K';
    var select;
    for (var sekcija in lista_sekcija) {
      select = sekcija.querySelector("h4");
      if (select != null) {
        //datum, postavi datum
        datum_parse =
            DateTime.parse(select.attributes['data-date']!.substring(0, 10));
        datum = datum_parse.day.toString().padLeft(2, '0') +
            '.' +
            datum_parse.month.toString().padLeft(2, '0') +
            '.';
      } else {
        select = sekcija.querySelector('div.card__title');
        naziv = select.text.trim();
        select = sekcija.querySelector('span.card__datetime_item');
        vrijeme = select.text.trim();
        select =
            sekcija.querySelectorAll('div.card__content > span.card__info');
        try {
          redatelj = 'R: ' +
              select[2].querySelector('strong').innerHtml.toString().trim();
        } catch (e) {
          null;
        }
      }
    }
  }

  static Future<List<String>> getDataC() async {
    List<String> lista = [];
    var url = Uri.parse("https://zagreb.cinestarcinemas.hr/na-programu/");
    final response = await http.get(url);
    //var document = parse(response.body.toString());
    var text = response.body;
    var target = text.substring(
        text.indexOf('"apiData":') + '"apiData":'.length,
        text.indexOf(',"cinemaData":'));
    //print(document.querySelectorAll("div")[1].outerHtml);
    var decoded = await json.decode(target);
    var keys = decoded['movies']['items'].keys;
    for (final key in keys) {
      var naziv = decoded['movies']['items'][key]['origTitle'];
      var redateljDict = decoded['movies']['items'][key]['directors'];
      var redatelj;
      if (redateljDict != null) {
        redatelj = redateljDict[0]['name'];
      } else {
        redatelj = ' ';
      }
      var kino = 'C';
      for (final performance in decoded['movies']['items'][key]
          ['performances']) {
        var datum_parse =
            DateTime.fromMillisecondsSinceEpoch(performance['timeUtc']);
        if (datum_parse.compareTo(DateTime.now()) > 0) {
          var datum = datum_parse.day.toString().padLeft(2, '0') +
              '.' +
              datum_parse.month.toString().padLeft(2, '0') +
              '.';
          var vrijeme = datum_parse.hour.toString().padLeft(2, '0') +
              ':' +
              datum_parse.minute.toString().padLeft(2, '0');
          lista.add(naziv);
          print(naziv);
        }
      }
    }
    return lista;
  }
}

void main() async {
  print(await Data.getDataC());
}
