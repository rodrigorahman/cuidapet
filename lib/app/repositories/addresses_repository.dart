import 'package:cuidapet/app/database/connection.dart';
import 'package:cuidapet/app/models/address_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class AdressesRepository {
  Future<List<AddressModel>> findAll() async {
    final conn = await Connection().instance;
    final result = await conn.rawQuery('select * from address');
    return result.map((e) => AddressModel.fromMap(e)).toList();
  }

  Future<bool> hasAddress() async {
    final conn = await Connection().instance;
    final result = await conn.rawQuery('select * from address');
    return result.isNotEmpty;
  }

  Future<void> saveAddress(AddressModel model) async {
    final conn = await Connection().instance;
    await conn.rawInsert('insert into address values(?, ?, ?, ?, ?)', [null, model.address, model.latitude, model.longitude, model.complemento]);
  }

  Future<List<Prediction>> findAddressByGooglePlaces(String address) async {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    var response = await places.autocomplete(
      address,
      language: 'pt',
    );

    return response.predictions;
  }

  Future<PlacesDetailsResponse> findGooglePlacesDetail(String placeId) async {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    return await places.getDetailsByPlaceId(placeId);
  }

  Future<void> clearDatabase() async {
     final conn = await Connection().instance;
     await conn.rawDelete('delete from address');
  }
}
