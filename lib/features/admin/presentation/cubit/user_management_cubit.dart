import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/domain/entities/user.dart';

part 'user_management_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  final FirebaseFirestore _firestore;

  UserManagementCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(UserManagementInitial());

  Future<void> loadUsers() async {
    try {
      emit(UserManagementLoading());
      
      final snapshot = await _firestore.collection('users').get();
      final users = snapshot.docs.map((doc) {
        final data = doc.data();
        return User(
          uid: doc.id,
          firstName: data['firstName'] ?? '',
          lastName: data['lastName'] ?? '',
          email: data['email'] ?? '',
          username: data['username'] ?? '',
          isAdmin: data['isAdmin'] ?? false,
        );
      }).toList();

      emit(UserManagementLoaded(users: users));
    } catch (e) {
      emit(UserManagementError(message: 'Failed to load users: $e'));
    }
  }

  Future<void> toggleAdminStatus(String uid, bool newStatus) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'isAdmin': newStatus,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      if (state is UserManagementLoaded) {
        final currentState = state as UserManagementLoaded;
        final updatedUsers = currentState.users.map((user) {
          if (user.uid == uid) {
            return User(
              uid: user.uid,
              firstName: user.firstName,
              lastName: user.lastName,
              email: user.email,
              username: user.username,
              isAdmin: newStatus,
              childName: user.childName,
              childImageUrl: user.childImageUrl,
            );
          }
          return user;
        }).toList();

        emit(UserManagementLoaded(users: updatedUsers));
      }
    } catch (e) {
      emit(UserManagementError(message: 'Failed to update admin status: $e'));
    }
  }
}
