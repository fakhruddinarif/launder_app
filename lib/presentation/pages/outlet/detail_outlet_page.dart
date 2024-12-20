import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launder_app/presentation/widgets/TextFormField.dart';
import 'dart:io';

class DetailOutletPage extends StatefulWidget {
  @override
  _DetailOutletPageState createState() => _DetailOutletPageState();
}

class _DetailOutletPageState extends State<DetailOutletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Outlet 1');
  final TextEditingController _addressController = TextEditingController(text: 'Jl. Raya Kuta No. 1');
  final TextEditingController _phoneController = TextEditingController(text: '08123456789');
  final TextEditingController _cityController = TextEditingController(text: 'Denpasar');
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Detail Outlet', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              image: _image != null
                                  ? DecorationImage(
                                image: FileImage(File(_image!.path)),
                                fit: BoxFit.cover,
                              )
                                  : const DecorationImage(
                                image: AssetImage('assets/images/logo.jpg'),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: Colors.grey.withOpacity(0.4)),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LaunderTextFormField(
                            labelText: 'Name Outlet',
                            hintText: 'Enter name outlet',
                            controller: _nameController,
                          ),
                          const SizedBox(height: 12,),
                          LaunderTextFormField(
                            labelText: 'Phone',
                            hintText: 'Enter phone',
                            controller: _phoneController,
                          ),
                          const SizedBox(height: 12,),
                          LaunderTextFormField(
                            labelText: 'City',
                            hintText: 'Enter city',
                            controller: _cityController,
                          ),
                          const SizedBox(height: 12,),
                          LaunderTextFormField(
                            labelText: 'Address',
                            hintText: 'Enter address',
                            controller: _addressController,
                          ),
                          const SizedBox(height: 24,),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // BlocProvider.of<UserBloc>(context).add(UserLoginEvent(username: _usernameController.text, password: _passwordController.text));
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16,),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _buttonSectionOutlet(() {
                      Navigator.pushNamed(context, '/outlet/scan');
                    }, "Scan Outlet", "Enter Outlet Mode From Another Device"),
                    _buttonSectionOutlet(() {
                      Navigator.pushNamed(context, '/outlet/resource');
                    }, "List of Resources", "10 Registered Resources"),
                    _buttonSectionOutlet(() {
                      Navigator.pushNamed(context, '/outlet/iot');
                    }, "List of Device IoT", "10 Registered IoT Devices"),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _buttonOptionOutlet(const Icon(Icons.file_copy_rounded, color: Colors.blueAccent,), "Duplicate Outlet", () {}),
                    _buttonOptionOutlet(const Icon(Icons.delete, color: Colors.red,), "Delete Outlet", () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buttonOptionOutlet(Icon icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.withOpacity(0.1))),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: icon,
          title: Text(title, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }

  GestureDetector _buttonSectionOutlet(Function() onTap, String title, String subtitle) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.withOpacity(0.1))),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          title: Text(title, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54, size: 16,),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),),
        ),
      ),
    );
  }
}