/*This class is common class for input field using inside login form, signup form etc*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator? validator;
  final TextInputType keyboard;
  final FocusNode? focusNode;
  final VoidCallback? onFinished;
  final bool isPassword;
  final double horizontalPadding;
  final Function? onValueChanged;
  final String? error;
  InputField({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.keyboard = TextInputType.text,
    this.focusNode,
    this.onFinished,
    this.isPassword = false,
    this.horizontalPadding = 16.0,
    this.onValueChanged,
    this.error,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   widget.hint,
        //   style: context.inputTextTitle,
        // ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.018,
        // ),
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 50,
              ),
            ],
            borderRadius: BorderRadius.circular(
              36.0,
            ),
          ),
          child: TextFormField(
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.020,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrey),
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboard,
            obscureText: widget.isPassword ? showPassword : false,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                errorMaxLines: 8,
                contentPadding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.06,
                  top: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.06,
                  bottom: MediaQuery.of(context).size.width * 0.04,
                ),
                filled: true,
                fillColor: AppColors.white,
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: const BorderSide(
                    color: AppColors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: const BorderSide(
                    color: AppColors.inputFieldBorderColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: const BorderSide(
                    color: AppColors.red,
                  ),
                ),
                errorStyle: TextStyle(
                    color: AppColors.red,
                    fontSize: MediaQuery.of(context).size.height * 0.015),
                enabledBorder: OutlineInputBorder(
                  gapPadding: 1,
                  borderRadius: BorderRadius.circular(36),
                  borderSide: const BorderSide(
                    color: AppColors.white,
                  ),
                ),
                suffixIcon: widget.isPassword
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: showPassword
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: AppColors.lightGreenGrey,
                                size: 18,
                              )
                            : const Icon(Icons.visibility_outlined,
                                size: 18, color: AppColors.lightGreenGrey))
                    : SizedBox(),
                hintText: widget.hint,
                hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueGrey.withOpacity(0.7))),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
