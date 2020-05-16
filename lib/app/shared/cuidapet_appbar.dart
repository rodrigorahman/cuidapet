import 'package:cuidapet/app/modules/address/address_page.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class CuidapetAppbar extends PreferredSize {
  CuidapetAppbar(BuildContext context, {double width})
      : super(
            child: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text('Cuidapet', style: TextStyle(color: Colors.white)),
              ),
              backgroundColor: Colors.grey[100],
              elevation: 0,
              actions: <Widget>[
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (_) => AddressPage())),
                                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.location_on),
                  ),
                )
              ],
              flexibleSpace: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      color: ThemeUtils.primaryColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: width,
                      // Para adicionar o elevation no input
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(30),
                                              child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.search,
                                size: 30,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            preferredSize: Size(double.infinity, 100));
}
