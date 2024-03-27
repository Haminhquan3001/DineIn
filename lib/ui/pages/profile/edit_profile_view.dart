import 'package:flutter/material.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  @override
  State<EditProfileView> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfileView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    _phoneController.dispose();
  }

  void saveProfile() {
    //TODO: save the new user profile to the database
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    Image userPicture = user.avatarUrl != null
        ? Image.network(user.avatarUrl!)
        : Image.asset("assets/core/woman.png", width: 80, height: 80);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: userPicture,
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("Username"),
                        prefixIcon: const Icon(
                          Icons.person_3_outlined,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("Email"),
                        prefixIcon: const Icon(
                          Icons.email,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        label: const Text("Phone No"),
                        prefixIcon: const Icon(Icons.phone)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.password)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black)),
                        label: const Text("Re-enter Password"),
                        prefixIcon: const Icon(Icons.password)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {}, // TODO: pass function
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 74, 81, 117),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "Save Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
