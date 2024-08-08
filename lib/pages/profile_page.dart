import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitty/components/my_bio_box.dart';
import 'package:twitty/components/my_input_alert_box.dart';
import 'package:twitty/models/user.dart';
import 'package:twitty/services/auth/auth_service.dart';
import 'package:twitty/services/database/database_provider.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({
    super.key,
    required this.uid,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController bioController = TextEditingController();
  late final databaseProvider =
      Provider.of<DataBaseProvider>(context, listen: false);

  UserProfile? user;
  String currentUserId = AuthService().getCurrentUid();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  Future<void> loadUser() async {
    user = await databaseProvider.userProfile(widget.uid);

    setState(() {
      isLoading = false;
    });
  }

  void _updateBioBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyInputAlertBox(
          bioController: bioController,
          hintText: 'Enter your bio',
          onPressedText: 'Save',
          onPressed: saveBio,
        );
      },
    );
  }

  Future<void> saveBio() async {
    setState(() {
      isLoading = true;
    });
    // Update Bio
    await databaseProvider.updateBio(bioController.text);

    // Reload user
    await loadUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(isLoading ? '' : (user?.name ?? 'Unknown User')),
        foregroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  // Username
                  Center(
                    child: Text(
                      '@${user!.username}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Profile Image
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(25)),
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.primary,
                        size: 75,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Bio
                  GestureDetector(
                    onTap: _updateBioBox,
                    child: MyBioBox(text: user!.bio),
                  )
                ],
              ),
            ),
    );
  }
}
