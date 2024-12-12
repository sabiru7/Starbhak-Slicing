import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _profilePictureUrl = 'assets/logo.jpg ';
  String _name = "Sabil Anomali"; 
  String _bio = "Software Engginer dan Flutter Devoloper"; 

  Future<void> _changeProfilePicture() async {
    setState(() {
      _profilePictureUrl = ''; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(_profilePictureUrl),
              radius: 50,
              onBackgroundImageError: (e, s) {
                print('Error loading image: $e');
              },
            ),
            SizedBox(height: 20),
            Text(_name, style: TextStyle(fontSize: 24)),
            Text(_bio, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeProfilePicture,
              child: Text('Ubah Foto Profil'),
            ),
          ],
        ),
      ),
    );
  }
}