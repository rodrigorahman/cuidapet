import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/repositories/usuario_repository.dart';
import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'image_profile_controller.g.dart';

class ImageProfileController = _ImageProfileControllerBase with _$ImageProfileController;

abstract class _ImageProfileControllerBase with Store {
  final UsuarioRepository _usuarioRepository;
  final AuthStore _authStore;

  _ImageProfileControllerBase(this._usuarioRepository, this._authStore);

  Future<void> loadCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      Loader.show();
      //Create a reference to the location you want to upload to in firebase
      var reference = FirebaseStorage.instance.ref().child('/perfil/' + DateTime.now().millisecondsSinceEpoch.toString());

      //Upload the file to firebase
      var uploadTask = reference.putFile(image);
      var storageTask = await uploadTask.onComplete;
      var url = await storageTask.ref.getDownloadURL();
      var usuario = await _usuarioRepository.updateImageAvatar(url.toString());
      await _authStore.setUser(usuario);
      Loader.hide();
    }
    Modular.to.pop();
  }
}
