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

  Future<void> uploadChildData({
    required String childName,
    required int childAge,
  }) async {
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

      // First upload the image if one is selected
      String? imageUrl;
      if (_selectedImage != null) {
        final String fileName = 
            '${DateTime.now().millisecondsSinceEpoch}_${_selectedImage!.name}';
        final storageRef = _storage.ref()
            .child('child_images')
            .child(currentUser.uid)
            .child(fileName);
        
        await storageRef.putFile(File(_selectedImage!.path));
        imageUrl = await storageRef.getDownloadURL();
      }

      // Create child data map
      final Map<String, dynamic> childData = {
        'name': childName,
        'age': childAge,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Save child data to Firestore
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .add(childData);

      emit(state.copyWith(
        status: ProfileInfoStatus.success,
        imageUrl: imageUrl,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileInfoStatus.failure,
        errorMessage: 'Failed to upload child data: ${e.toString()}',
      ));
    }
  }

  Future<void> updateChildData({
    required String childId,
    required String childName,
    required int childAge,
    bool updateImage = false,
  }) async {
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

      // Create base update data
      final Map<String, dynamic> updateData = {
        'name': childName,
        'age': childAge,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Update image if requested and new image is selected
      if (updateImage && _selectedImage != null) {
        // Get the child document to check if there's an existing image
        final childDoc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('children')
            .doc(childId)
            .get();

        // Delete old image if it exists
        if (childDoc.exists) {
          final existingData = childDoc.data();
          if (existingData != null && existingData['imageUrl'] != null) {
            try {
              final oldImageRef = _storage.refFromURL(existingData['imageUrl']);
              await oldImageRef.delete();
            } catch (e) {
              // Continue even if old image deletion fails
              print('Failed to delete old image: ${e.toString()}');
            }
          }
        }

        // Upload new image
        final String fileName = 
            '${DateTime.now().millisecondsSinceEpoch}_${_selectedImage!.name}';
        final storageRef = _storage.ref()
            .child('child_images')
            .child(currentUser.uid)
            .child(fileName);
        
        await storageRef.putFile(File(_selectedImage!.path));
        final String newImageUrl = await storageRef.getDownloadURL();
        
        // Add new image URL to update data
        updateData['imageUrl'] = newImageUrl;
      }

      // Update child document in Firestore
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .doc(childId)
          .update(updateData);

      emit(state.copyWith(
        status: ProfileInfoStatus.success,
        imageUrl: updateData['imageUrl'],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileInfoStatus.failure,
        errorMessage: 'Failed to update child data: ${e.toString()}',
      ));
    }
  }
}