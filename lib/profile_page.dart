import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profilePicture;
  String _name = "Sabil Anomali"; 
  String _bio = "School Developer"; 

  Future<void> _changeProfilePicture() async {
    // Meminta izin untuk akses penyimpanan
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // Meminta izin untuk akses kamera
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }

    // Cek apakah izin diberikan
    if (await Permission.storage.isGranted && await Permission.camera.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        print("Image selected: ${image.path}"); final selectedImage = File(image.path);
        if (selectedImage.existsSync()) {
          setState(() {
            _profilePicture = selectedImage;
          });
        } else {
          print("Selected image does not exist.");
        }
      } else {
        print("No image selected.");
      }
    } else {
      print("Permissions not granted");
    }
  }

  void _removeProfilePicture() {
    setState(() {
      _profilePicture = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                _profilePicture != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(_profilePicture!),
                        radius: 50,
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.person, size: 50),
                        radius: 50,
                      ),
                if (_profilePicture != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: _removeProfilePicture,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _bio,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeProfilePicture,
              child: const Text('Change Profile Picture'),
            ),
          ],
        ),
      ),
    );
  }
}