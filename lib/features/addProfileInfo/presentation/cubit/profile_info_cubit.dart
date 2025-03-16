import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_funland/core/components/background_sound.dart';
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
  })  : _picker = picker ?? ImagePicker(),
        _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance,
        super(const ProfileInfoState());

  Future<void> pickImageFromCamera() async {
    emit(ProfileInfoLoadingState());

    await _pickImage(ImageSource.camera);
  }

  Future<void> pickImageFromGallery() async {
    emit(ProfileInfoLoadingState());

    await _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      emit(ProfileInfoLoadingState());

      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1000,
      );

      if (image != null) {
        _selectedImage = image;
        // Update state with local file path for preview
        emit(PickedImageSuccessState(
          localImagePath: image.path,
        ));
      } else {
        emit(ProfileInfoInitialState(
          errorMessage: 'No image selected',
        ));
      }
    } catch (e) {
      emit(PickedImageErrorState(
        errorMessage: 'Failed to pick image: ${e.toString()}',
      ));
    }
  }

  Future<void> uploadSelectedImage() async {
    emit(ProfileInfoLoadingState());

    if (_selectedImage == null) {
      emit(UploadImageErrorState(
        errorMessage: 'No image selected to upload',
      ));

      return;
    }

    try {
      emit(ProfileInfoLoadingState());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(UploadImageErrorState(
          errorMessage: 'User not authenticated',
        ));
        return;
      }

      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${_selectedImage!.name}';
      final storageRef = _storage
          .ref()
          .child('profile_images')
          .child(currentUser.uid)
          .child(fileName);

      await storageRef.putFile(File(_selectedImage!.path));
      final String downloadUrl = await storageRef.getDownloadURL();
      emit(UploadImageSuccessState(imageUrl: downloadUrl));
    } catch (e) {
      emit(UploadImageErrorState(
        errorMessage: 'Failed to upload image: ${e.toString()}',
      ));
    }
  }

  Future<void> saveChildData(
      String childName, String childAge, String? imageUrl) async {
    try {
      emit(ProfileInfoLoadingState());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(SaveChildInfoErrorState(
          errorMessage: 'User not authenticated',
        ));

        return;
      }

      if (imageUrl == null) {
        emit(SaveChildInfoErrorState(
          errorMessage: 'Profile image is required',
        ));

        return;
      }

      if (childName.isEmpty || childAge.isEmpty) {
        emit(SaveChildInfoErrorState(
          errorMessage: 'Child name and age are required',
        ));

        return;
      }

      final int? parsedAge = int.tryParse(childAge);
      if (parsedAge == null) {
        emit(SaveChildInfoErrorState(
          errorMessage: 'Invalid age format',
        ));

        return;
      }

      // Add child data to Firestore
      final DocumentReference childRef = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .add({
        'name': childName,
        'age': parsedAge,
        'profileImage': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update user profile status
      await _firestore.collection('users').doc(currentUser.uid).update({
        'hasCompletedProfile': true,
        'lastUpdated': FieldValue.serverTimestamp(),
        'currentChildId': childRef.id, // Store the current child's ID
      });

      emit(SaveChildInfoSuccessState(messag: "Success Save Child Info"));

      // Fetch the current child data
      await getCurrentChild();
    } catch (e) {
      emit(SaveChildInfoErrorState(
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> uploadChildData({
    required String childName,
    required int childAge,
  }) async {
    try {
      emit(ProfileInfoLoadingState());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(UploadChildDataErrorState(
          errorMessage: 'User not authenticated',
        ));

        return;
      }

      // First upload the image if one is selected
      String? imageUrl;
      if (_selectedImage != null) {
        final String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${_selectedImage!.name}';
        final storageRef = _storage
            .ref()
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

      emit(UploadChildDataSuccessState(messag: "Upload Child Data Success"));
    } catch (e) {
      emit(UploadChildDataErrorState(
        errorMessage: 'Failed to upload child data: ${e.toString()}',
      ));
    }
  }

  Future<void> updateChildData(
    String childId, {
    required String childName,
    required String childAge,
    String? imageUrl,
  }) async {
    try {
      emit(ProfileInfoLoadingState());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(UpdateChildDataErrorState(
          errorMessage: 'User not authenticated',
        ));
        return;
      }

      final int? parsedAge = int.tryParse(childAge);
      if (parsedAge == null) {
        emit(UpdateChildDataErrorState(
          errorMessage: 'Invalid age format',
        ));
        return;
      }

      final Map<String, dynamic> updateData = {
        'name': childName,
        'age': parsedAge,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (imageUrl != null) {
        updateData['profileImage'] = imageUrl;
      }

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .doc(childId)
          .update(updateData);

      emit(UpdateChildDataSuccessState(
          message: 'Child data updated successfully'));

      // Fetch updated child data
      await getCurrentChild();
    } catch (e) {
      emit(UpdateChildDataErrorState(
        errorMessage: 'Failed to update child data: ${e.toString()}',
      ));
    }
  }

  Future<void> UpdateChildData(
      String childName, String childAge, String imageUrl) async {
    try {
      emit(ProfileInfoLoadingState());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(UpdateChildDataErrorState(
          errorMessage: 'User not authenticated',
        ));
        return;
      }

      // Get user document to find current child ID
      final userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (!userDoc.exists) {
        emit(UpdateChildDataErrorState(
          errorMessage: 'User document not found',
        ));
        return;
      }

      final userData = userDoc.data();
      final String? currentChildId = userData?['currentChildId'];

      if (currentChildId == null) {
        emit(UpdateChildDataErrorState(
          errorMessage: 'No current child found',
        ));
        return;
      }

      final int? parsedAge = int.tryParse(childAge);
      if (parsedAge == null) {
        emit(UpdateChildDataErrorState(
          errorMessage: 'Invalid age format',
        ));
        return;
      }

      // Update child document
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .doc(currentChildId)
          .update({
        'name': childName,
        'age': parsedAge,
        'profileImage': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      emit(UpdateChildDataSuccessState(
        message: 'Child information updated successfully',
      ));

      // Fetch updated child data
      await getCurrentChild();
    } catch (e) {
      emit(UpdateChildDataErrorState(
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getChildren() async {
    try {
      emit(ProfileInfoLoadingState());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(GetChildrenErrorState(
          errorMessage: 'User not authenticated',
        ));

        return;
      }

      final QuerySnapshot childrenSnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .orderBy('createdAt', descending: true)
          .get();

      final List<Map<String, dynamic>> children =
          childrenSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'name': data['name'],
          'age': data['age'],
          'imageUrl': data['imageUrl'],
          'createdAt': data['createdAt'],
          'updatedAt': data['updatedAt'],
        };
      }).toList();

      emit(GetChildrenSuccessState(children: children));
    } catch (e) {
      emit(GetChildrenErrorState(
        errorMessage: 'Failed to fetch children: ${e.toString()}',
      ));
    }
  }

  Future<void> getCurrentChild() async {
    try {
      emit(ProfileInfoLoadingState());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(GetChildErrorState(
          errorMessage: 'User not authenticated',
        ));
        return;
      }

      // Get user document to find current child ID
      final userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (!userDoc.exists) {
        emit(GetChildErrorState(
          errorMessage: 'User document not found',
        ));
        return;
      }

      final userData = userDoc.data();
      final String? currentChildId = userData?['currentChildId'];

      if (currentChildId == null) {
        emit(GetChildErrorState(
          errorMessage: 'No current child set',
        ));
        return;
      }

      // Get child document using the ID
      final childDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .doc(currentChildId)
          .get();

      if (!childDoc.exists) {
        emit(GetChildErrorState(
          errorMessage: 'Child not found',
        ));
        return;
      }

      final childData = childDoc.data() as Map<String, dynamic>;
      emit(GetChildSuccessState(
        child: {
          'id': childDoc.id,
          'name': childData['name'],
          'age': childData['age'],
          'imageUrl': childData['profileImage'],
        },
      ));
      BackgroundAudio.playBackgroundMusic();
    } catch (e) {
      emit(GetChildErrorState(
        errorMessage: e.toString(),
      ));
    }
  }
}
