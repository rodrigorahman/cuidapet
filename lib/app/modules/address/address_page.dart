import 'package:cuidapet/app/models/address_model.dart';
import 'package:cuidapet/app/modules/address/address_confirm/address_confirm_page.dart';
import 'package:cuidapet/app/modules/address/address_controller.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import "package:google_maps_webservice/geocoding.dart";

class AddressPage extends StatefulWidget {
  final String title;
  const AddressPage({Key key, this.title = "Address"}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends ModularState<AddressPage, AddressController> {
  FocusNode addressFocusNode;

  @override
  void initState() {
    super.initState();
    addressFocusNode = FocusNode();
    controller.findAllAdresses();
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('clicado');
        addressFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
                  child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Adicione ou escolha um endereço',
                  style: ThemeUtils.theme.textTheme.headline5.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.addressTextController,
                        focusNode: addressFocusNode,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            hintText: 'Insira um endereço',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(style: BorderStyle.none),
                            )),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await controller.findAddressGoogle(pattern);
                      },
                      itemBuilder: (context, Prediction suggestion) {
                        return ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(suggestion.description),
                        );
                      },
                      onSuggestionSelected: (suggestion) async {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(product: suggestion)));
                        var editar = await controller.goToConfirm(suggestion);
                        if (editar != null && editar.isNotEmpty) {
                          controller.addressTextController.text = editar;
                          addressFocusNode.requestFocus();
                        } else {
                          controller.addressTextController.clear();
                        }
                        controller.findAllAdresses();
                        // var editar = await Get.to(AddressConfirmPage());
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildAddressContainer(
                    currentLocation: true,
                    title: 'Localização Atual',
                    onPressed: () async {
                      var editar = await Get.to(AddressConfirmPage());
                      controller.addressTextController.text = editar;
                      addressFocusNode.requestFocus();
                      controller.findAllAdresses();
                      // setar na controller o endereco
                    }),
                Observer(builder: (_) {
                  return FutureBuilder(
                    future: controller.adressesFuture,
                    builder: (_, AsyncSnapshot<List<AddressModel>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                          return Container();
                          break;
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, int index) {
                              var item = snapshot.data[index];
                              return _buildAddressContainer(
                                currentLocation: false,
                                title: item.address,
                                subtitle: item.complemento,
                                onPressed: () {
                                  addressFocusNode.unfocus();
                                },
                              );
                            },
                          );
                        default:
                          return Container();
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressContainer({bool currentLocation = false, String title, String subtitle, GestureTapCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: currentLocation ? Colors.red : Colors.white,
                  radius: 30,
                  child: Icon(
                    currentLocation ? Icons.near_me : Icons.place,
                    color: currentLocation ? Colors.white : Colors.black,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title),
                      ),
                      Visibility(
                        visible: subtitle != null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(subtitle ?? ''),
                        ),
                      ),
                    ],
                  ),
                ),
                currentLocation
                    ? Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
