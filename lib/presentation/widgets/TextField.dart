import 'package:flutter/material.dart';

class LaunderTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool showPassword;

  const LaunderTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.isRequired = false,
    this.showPassword = false,
  }) : super(key: key);

  @override
  _LaunderTextFormFieldState createState() => _LaunderTextFormFieldState();
}

class _LaunderTextFormFieldState extends State<LaunderTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.labelText,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: <TextSpan>[
              if (widget.isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintStyle: const TextStyle(fontSize: 14),
            suffixIcon: widget.showPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}