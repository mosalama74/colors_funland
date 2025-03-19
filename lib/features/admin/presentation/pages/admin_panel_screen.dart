import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/admin_cubit.dart';
import '../../domain/entities/feature_config.dart';
import 'user_management_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserManagementScreen(),
                ),
              );
            },
            tooltip: 'Manage Users',
          ),
        ],
      ),
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          if (state is AdminLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  'Feature Management',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...state.features.map((feature) => _buildFeatureCard(context, feature)),
              ],
            );
          } else if (state is AdminError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, FeatureConfig feature) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  feature.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: feature.isEnabled,
                  onChanged: (value) {
                    context.read<AdminCubit>().toggleFeature(feature.id);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Status: ${feature.isEnabled ? "Enabled" : "Disabled"}',
              style: TextStyle(
                color: feature.isEnabled ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (feature.settings.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Text(
                'Settings:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              ...feature.settings.entries.map(
                (entry) => Text('${entry.key}: ${entry.value}'),
              ),
            ],
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showSettingsDialog(context, feature),
              child: const Text('Edit Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context, FeatureConfig feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${feature.name} Settings'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add specific settings fields based on feature type
              // This is a placeholder for feature-specific settings
              const Text('Feature settings coming soon'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle settings update
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
