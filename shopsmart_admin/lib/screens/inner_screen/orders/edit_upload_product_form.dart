// ignore_for_file: unused_element, unused_local_variable, unused_field

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_admin_en/consts/app_constants.dart';
import 'package:shopsmart_admin_en/consts/validator.dart';
import 'package:shopsmart_admin_en/models/product_model.dart';
import 'package:shopsmart_admin_en/services/my_app_functions.dart';
import 'package:shopsmart_admin_en/widgets/subtitle_text.dart';
import 'package:shopsmart_admin_en/widgets/title_text.dart';

class EditorUploadProductScreen extends StatefulWidget {
  static const routeName = '/EditorUploadProductScreen';
  final ProductModel? productModel;
  const EditorUploadProductScreen({super.key, this.productModel});

  @override
  State<EditorUploadProductScreen> createState() =>
      _EditorUploadProductScreenState();
}

class _EditorUploadProductScreenState extends State<EditorUploadProductScreen> {
  final _formkey = GlobalKey<FormState>();
  XFile? _pickedImage;

  late TextEditingController _titleController,
      _descriptionController,
      _priceController,
      _quantityController;
  String? _categoryValue;
  bool isEditing = false;
  String? productNetworkImage;
  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      productNetworkImage = widget.productModel!.productImage;
      _categoryValue = widget.productModel!.productCategory;
    }
    _titleController =
        TextEditingController(text: widget.productModel?.productTitle);
    _descriptionController =
        TextEditingController(text: widget.productModel?.productDescription);
    _priceController =
        TextEditingController(text: widget.productModel?.productPrice);
    _quantityController =
        TextEditingController(text: widget.productModel?.productQuantity);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _quantityController.clear();
    removePickedImage();
  }

  void removePickedImage() {
    setState(() {
      _pickedImage = null;
      productNetworkImage = null;
    });
  }

  Future<void> _uploadProduct() async {
    if (_pickedImage == null) {
      MyAppFunctions.showErrorOrWarningDialog(
          context: context, subtitle: "Please pick up an Image", fct: () {});
      return;
    }

    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context);
    if (isValid) {}
  }

  Future<void> _editProduct() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && productNetworkImage == null) {
      MyAppFunctions.showErrorOrWarningDialog(
          context: context, subtitle: "Please pick up an Image", fct: () {});
      return;
    }
    if (isValid) {}
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
        context: context,
        cameraFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFCT: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFCT: () async {
          setState(() {
            _pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomSheet: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      clearForm();
                    },
                    icon: const Icon(Icons.clear, color: Colors.red),
                    label: const Text(
                      "Clear",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (isEditing) {
                        _editProduct();
                      } else {
                        _uploadProduct();
                      }
                    },
                    icon: const Icon(Icons.upload),
                    label: Text(
                      isEditing ? "Update Product" : "Upload Product",
                      style: const TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: TitlesTextWidget(
            label: isEditing ? "Edit Product" : "Add a new product",
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Image picker section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: size.width * 0.5,
                        height: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: (isEditing &&
                                  productNetworkImage != null &&
                                  _pickedImage == null)
                              ? Image.network(
                                  productNetworkImage!,
                                  fit: BoxFit.cover,
                                )
                              : (_pickedImage != null)
                                  ? Image.file(
                                      File(_pickedImage!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_outlined,
                                          size: 60,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Pick Image",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Material(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: localImagePicker,
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_pickedImage != null || productNetworkImage != null)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Material(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: removePickedImage,
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Form section
                Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Category"),
                      DropdownButtonFormField<String>(
                        items: AppConstants.categoriesDropDownList,
                        value: _categoryValue,
                        decoration: InputDecoration(
                          hintText: 'Select a category',
                          fillColor: Theme.of(context).cardColor,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _categoryValue = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose a category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildLabel("Product Title"),
                      TextFormField(
                        controller: _titleController,
                        key: const ValueKey("Title"),
                        maxLength: 100,
                        decoration: InputDecoration(
                          hintText: "Enter title",
                          fillColor: Theme.of(context).cardColor,
                        ),
                        validator: (value) {
                          return MyValidators.uploadProdTexts(
                            value: value,
                            toBeReturnedString: "Please enter a valid title",
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Price (\$)"),
                                TextFormField(
                                  controller: _priceController,
                                  key: const ValueKey('Price'),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^(\d+)?\.?\d{0,2}'),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: '0.00',
                                    prefixText: '\$ ',
                                    fillColor: Theme.of(context).cardColor,
                                  ),
                                  validator: (value) {
                                    return MyValidators.uploadProdTexts(
                                      value: value,
                                      toBeReturnedString: "Price is missing",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Quantity"),
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: _quantityController,
                                  keyboardType: TextInputType.number,
                                  key: const ValueKey('Quantity'),
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    fillColor: Theme.of(context).cardColor,
                                  ),
                                  validator: (value) {
                                    return MyValidators.uploadProdTexts(
                                      value: value,
                                      toBeReturnedString: "Quantity is missed",
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildLabel("Description"),
                      TextFormField(
                        key: const ValueKey('Description'),
                        controller: _descriptionController,
                        minLines: 4,
                        maxLines: 8,
                        maxLength: 1000,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Describe the product...',
                          fillColor: Theme.of(context).cardColor,
                        ),
                        validator: (value) {
                          return MyValidators.uploadProdTexts(
                            value: value,
                            toBeReturnedString: "Description is missed",
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Space for bottom sheet
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: SubtitleTextWidget(
        label: label,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
