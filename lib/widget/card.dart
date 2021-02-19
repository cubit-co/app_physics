import 'package:app_physics/routes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:intl/intl.dart';

class CardList extends StatelessWidget {
  final formattedDate = DateFormat('kk:mm:a');
  final String id;
  final String name;
  final String author;
  final DateTime date;
  final String url;
  final String zoomId;

  CardList(
      {@required this.id,
      @required this.name,
      @required this.date,
      @required this.url,
      this.author,
      this.zoomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _cardContent(context),
    );
  }

  Widget _cardContent(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final urlL = url;
        if (await urlLauncher.canLaunch(urlL)) {
          await urlLauncher.launch(urlL);
        }
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: Offset(0, 10.0),
              spreadRadius: -10.0),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: _cardRow(context),
      ),
    );
  }

  Widget _cardRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTexts(context),
        _cardStatusCircle(context),
      ],
    );
  }

  Widget _cardStatusCircle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10.0,
      ),
      height: 17.0,
      width: 17.0,
      decoration: BoxDecoration(
          color:
              validateDate() ? Colors.black38 : Theme.of(context).accentColor,
          shape: BoxShape.circle),
    );
  }

  bool validateDate() {
    var difference = new DateTime.now().difference(date);
    return difference.inHours.abs() > 1;
  }

  Widget _cardTexts(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: Theme.of(context).textTheme.title.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(height: 5),
          Text(author == null ? '' : author,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 14,
                  )),
          SizedBox(height: 2),
          Row(
            children: [
              Text(formattedDate.format(date),
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Colors.black38,
                      )),
              SizedBox(width: 5),
              Text("-"),
              SizedBox(width: 5),
              GestureDetector(
                  child: Row(children: [
                    Text(
                      "Confirmar asistencia",
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 14,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.open_in_browser)
                  ]),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteNames.ASSITANCE, arguments: id);
                  })
            ],
          ),
          SizedBox(height: 2),
          zoomId != null
              ? Text('Zoom ID: ' + zoomId,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Theme.of(context).primaryColorDark))
              : Container()
        ],
      ),
    );
  }
}
