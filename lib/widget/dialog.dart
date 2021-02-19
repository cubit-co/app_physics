import 'package:flutter/material.dart';

class SwitchDialog extends StatelessWidget {
  final String title;
  final String body;

  SwitchDialog({
    @required this.body,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Wrap(children: <Widget>[
        _dialogContent(context),
      ]),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.title.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: Theme.of(context).primaryColorDark),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(body),
          SizedBox(height: 20.0),
          _dialogButton(
              icon: Icons.close,
              content: 'Cerrar',
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              context: context)
        ],
      ),
    );
  }

  Widget _dialogButton(
      {IconData icon,
      String content,
      Color color,
      Color textColor,
      BuildContext context}) {
    return RaisedButton(
      color: color,
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: textColor),
          Text(content, style: TextStyle(color: textColor))
        ],
      ),
    );
  }
}
