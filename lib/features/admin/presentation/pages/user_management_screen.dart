import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_management_cubit.dart';
import '../../../auth/domain/entities/user.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: Colors.purple,
      ),
      body: BlocProvider(
        create: (context) => UserManagementCubit()..loadUsers(),
        child: BlocBuilder<UserManagementCubit, UserManagementState>(
          builder: (context, state) {
            if (state is UserManagementLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserManagementLoaded) {
              return _buildUserList(context, state.users);
            } else if (state is UserManagementError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildUserList(BuildContext context, List<User> users) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${user.email}'),
                Text('Username: ${user.username}'),
                Text(
                  'Status: ${user.isAdmin ? "Admin" : "Regular User"}',
                  style: TextStyle(
                    color: user.isAdmin ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Switch(
              value: user.isAdmin,
              onChanged: (bool value) {
                _showConfirmationDialog(context, user, value);
              },
            ),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, User user, bool newStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${newStatus ? "Grant" : "Remove"} Admin Access'),
        content: Text(
          'Are you sure you want to ${newStatus ? "grant" : "remove"} admin access for ${user.firstName} ${user.lastName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<UserManagementCubit>()
                  .toggleAdminStatus(user.uid, newStatus);
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
