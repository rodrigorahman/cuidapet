import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacebookButton extends StatelessWidget {
  final GestureTapCallback onTap;
  const FacebookButton({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: ScreenUtil.screenWidthDp * .85,
        height: 50,
        decoration: BoxDecoration(color: Colors.blue[700], borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Color(0xFF4267B3))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 2),
              child: Icon(
                FontAwesome.facebook,
                color: Colors.white,
                size: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: VerticalDivider(
                thickness: 2,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Conectar com facebook',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textScaleFactor: ScreenUtil().scaleText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
