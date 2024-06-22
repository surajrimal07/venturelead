import 'package:flutter/material.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';

class ConnectionCard extends StatelessWidget {
  final User user;

  const ConnectionCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final connection = user.connections!;
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connections',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.connections!.length,
              itemBuilder: (context, index) {
                var connection = user.connections![index];
                return ListTile(
                  title: Text(connection.subject!),
                  subtitle: Text(connection.reason!),
                  trailing: Text(connection.status!),
                  onTap: () {
                    // Handle tap on connection item
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
