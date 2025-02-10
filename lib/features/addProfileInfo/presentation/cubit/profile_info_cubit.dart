import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_state.dart';
import 'dart:io';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  final ImagePicker _picker;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  XFile? _selectedImage;

  ProfileInfoCubit({
    ImagePicker? picker,
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _picker = picker ?? ImagePicker(),
       _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance,
       super(const ProfileInfoState());

  Future<void> pickImageFromCamera() async {
    await _pickImage(ImageSource.camera);
  }

  Future<void> pickImageFromGallery() async {
    await _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      emit(state.copyWith(status: ProfileInfoStatus.loading));
      
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1000,
      );

      if (image != null) {
        _selectedImage = image;
        // Update state with local file path for preview
        emit(state.copyWith(
          status: ProfileInfoStatus.success,
          localImagePath: image.path,
        ));
      } else {
        emit(state.copyWith(
          status: ProfileInfoStatus.initial,
          errorMessage: 'No image selected',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProfileInfoStatus.failure,
        errorMessage: 'Failed to pick image: ${e.toString()}',
      ));
    }
  }

  Future<void> uploadSelectedImage() async {
    if (_selectedImage == null) {
      emit(state.copyWith(
        status: ProfileInfoStatus.failure,
        errorMessage: 'No image selected to upload',
      ));
      return;
    }

    try {
      emit(state.copyWith(status: ProfileInfoStatus.loading));

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(state.copyWith(
          status: ProfileInfoStatus.failure,
          errorMessage: 'User not authenticated',
        ));
        return;
      }
      
      final String fileName = 
          '${DateTime.now().millisecondsSinceEpoch}_${_selectedImage!.name}';
      final storageRef = _storage.ref()
          .child('profile_images')
          .child(currentUser.uid)
          .child(fileName);
      
      await storageRef.putFile(File(_selectedImage!.path));
      final String downloadUrl = await storageRef.getDownloadURL();

      emit(state.copyWith(
        imageUrl: downloadUrl,
        status: ProfileInfoStatus.success,
      ));

      // Clear the selected image after successful upload
      _selectedImage = null;
    } catch (e) {
      emit(state.copyWith(
        status: ProfileInfoStatus.failure,
        errorMessage: 'Failed to upload image: ${e.toString()}',
      ));
    }
  }

  Future<void> saveChildData(String childName, String childAge) async {
    try {
      emit(state.copyWith(status: ProfileInfoStatus.loading));

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(state.copyWith(
          status: ProfileInfoStatus.failure,
          errorMessage: 'User not authenticated',
        ));
        return;
      }
      
      if (state.imageUrl == null) {
        emit(state.copyWith(
          status: ProfileInfoStatus.failure,
          errorMessage: 'Profile image is required',
        ));
        return;
      }

      if (childName.isEmpty || childAge.isEmpty) {
        emit(state.copyWith(
          status: ProfileInfoStatus.failure,
          errorMessage: 'Child name and age are required',
        ));
        return;
      }

      final int? parsedAge = int.tryParse(childAge);
      if (parsedAge == null) {
        emit(state.copyWith(
          status: ProfileInfoStatus.failure,
          errorMessage: 'Invalid age format',
        ));
        return;
      }

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .add({
        'name': childName,
        'age': parsedAge,
        'profileImage': state.imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await _firestore.collection('users').doc(currentUser.uid).update({
        'hasCompletedProfile': true,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      emit(state.copyWith(status: ProfileInfoStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileInfoStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}