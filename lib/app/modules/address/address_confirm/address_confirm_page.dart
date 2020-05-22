import 'dart:async';

import 'package:cuidapet/app/modules/address/address_confirm/address_confirm_controller.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class AddressConfirmPage extends StatefulWidget {
  final PlaceDetails address;
  const AddressConfirmPage({Key key, this.address}) : super(key: key);

  @override
  _AddressConfirmPageState createState() => _AddressConfirmPageState();
}

class _AddressConfirmPageState extends ModularState<AddressConfirmPage, AddressConfirmController> {
  // var controller = Modular.get<AddressConfirmController>();
  final Completer<GoogleMapController> _mapsController = Completer();

  @override
  void initState() {
    super.initState();
    controller.setAddress(widget.address);
  }

  @override
  void dispose() {
    controller.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Confirme seu endereço',
              style: ThemeUtils.theme.textTheme.headline5.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return Expanded(
                child: controller.addressModel != null
                    ? GoogleMap(
                        mapType: MapType.normal,
                        markers: {
                          Marker(
                            markerId: MarkerId(controller.addressModel.id.toString()),
                            position: LatLng(controller.addressModel.latitude, controller.addressModel.longitude),
                            infoWindow: InfoWindow(
                              title: controller.addressModel.address,
                            ),
                            onTap: () {},
                          ),
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.addressModel.latitude, controller.addressModel.longitude),
                          zoom: 16,
                        ),
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          _mapsController.complete(controller);
                        },
                      )
                    : Container(),
              );
            }),
            //AIzaSyApf37zicYFGFP8NzcehFxxDDQ9lkZymrM
            TextFormField(
              controller: controller.addressTextController,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: 'Endereço',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.back(result: controller.addressTextController.text);
                    },
                  )),
            ),
            TextFormField(
              controller: controller.complementTextController,
              decoration: InputDecoration(labelText: 'Complemento'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: ScreenUtil.screenWidthDp * .9,
              height: 50,
              child: RaisedButton(
                onPressed: () => controller.saveAddress(),
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 20),
                ),
                color: ThemeUtils.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
