import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launder_app/main.dart';
import 'package:launder_app/presentation/blocs/outlet/outlet_bloc.dart';
import 'package:launder_app/presentation/blocs/outlet/outlet_state.dart';
import 'package:launder_app/presentation/widgets/TextFormField.dart';

import '../../blocs/outlet/outlet_event.dart';

class CreateOutletPage extends StatefulWidget {
  @override
  _CreateOutletPageState createState() => _CreateOutletPageState();
}

class _CreateOutletPageState extends State<CreateOutletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _outletNameController = TextEditingController();
  final TextEditingController _outletAddressController = TextEditingController();
  final TextEditingController _outletPhoneController = TextEditingController();
  final TextEditingController _outletCityController = TextEditingController();
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
      appBar: AppBar(
        title: const Text('Create Outlet', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
      ),
      body: BlocConsumer<OutletBloc, OutletState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
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
                                      : null,
                                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                ),
                                child: _image == null
                                    ? const Icon(Icons.image, size: 48, color: Colors.grey)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        LaunderTextFormField(
                          labelText: 'Outlet Name',
                          hintText: 'Enter outlet name',
                          controller: _outletNameController,
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        LaunderTextFormField(
                          labelText: 'Outlet Address',
                          hintText: 'Enter outlet address',
                          controller: _outletAddressController,
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        LaunderTextFormField(
                          labelText: 'Outlet Phone',
                          hintText: 'Enter outlet phone',
                          controller: _outletPhoneController,
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        LaunderTextFormField(
                          labelText: 'Outlet City',
                          hintText: 'Enter outlet city',
                          controller: _outletCityController,
                          isRequired: true,
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<OutletBloc>().add(OutletCreateEvent(
                                name: _outletNameController.text,
                                address: _outletAddressController.text,
                                phone: _outletPhoneController.text,
                                city: _outletCityController.text,
                              ));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text('Create', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is OutletSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ));
              context.read<OutletBloc>().add(const OutletListEvent(page: 1, size: 10));
              Navigator.pop(context);
            } else if (state is OutletFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            }
          },
      ),
    );
  }
}