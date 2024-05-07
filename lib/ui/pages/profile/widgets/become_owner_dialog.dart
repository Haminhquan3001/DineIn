import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/ui/utils/local_storage_singleton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BecomeOwnerDialog extends StatelessWidget {
  final void Function(dynamic) updateIsOwner;
  const BecomeOwnerDialog({required this.updateIsOwner, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Become an Owner User"),
      content: const Text(
          "By becoming an owner, you can manage your own restaurant. Are you sure you want to become an owner?"),
      actions: [
        // Close dialog
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),

        // Become owner
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () async {
            await KwunLocalStorage.setBool("is_owner", true);

            await Supabase.instance.client
                .from('users')
                .update({'is_owner': true}).eq(
                    'id', Supabase.instance.client.auth.currentUser!.id);

            updateIsOwner(true);

            if (!context.mounted) return;
            Navigator.of(context).pop();
            context.push('/profile/owner-form');
          },
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
