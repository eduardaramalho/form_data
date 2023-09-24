import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/theme.dart';
import 'package:to_do_list/provider/product_provider.dart';

import 'product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      // passar o objeto (produto) por arguments quando utilizar o navigator
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['urlImage'] = product.urlImage;

        _imageUrlController.text = product.urlImage;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageFocus.dispose();
    _imageUrlController.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();

    Provider.of<ProductProvider>(context, listen: false)
        .saveProductFromData(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário'),
          backgroundColor: ToDoListTheme.purple,
          actions: [
            IconButton(onPressed: _submit, icon: const Icon(Icons.done))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: _formData['name']?.toString(),
                    decoration: const InputDecoration(labelText: 'Nome'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    validator: (_name) {
                      final name = _name ?? '';

                      if (name.trim().isEmpty) {
                        return 'Nome é obrigatório';
                      }

                      return null;
                    },
                    onSaved: (name) => _formData['name'] = name ?? '',
                  ),
                  TextFormField(
                    initialValue: _formData['price']?.toString(),
                    decoration: const InputDecoration(labelText: 'Preço'),
                    onSaved: (price) =>
                        _formData['price'] = double.parse(price ?? '0'),
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocus,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
                    validator: (_price) {
                      final priceString = _price ?? '-1';
                      final price = double.tryParse(priceString) ?? -1;

                      if (price <= 0) {
                        return 'Informe um valor válido';
                      }
                    },
                  ),
                  TextFormField(
                    initialValue: _formData['description']?.toString(),
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    textInputAction: TextInputAction.next,
                    onSaved: (description) =>
                        _formData['description'] = description ?? '',
                    focusNode: _descriptionFocus,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    validator: (_description) {
                      final description = _description ?? '';

                      if (description.trim().isEmpty) {
                        return 'Descrição é obrigatório';
                      }

                      return null;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _formData['urlImage'].toString(),
                          onSaved: (urlImage) =>
                              _formData['urlImage'] = urlImage ?? '',
                          decoration:
                              const InputDecoration(labelText: 'URL da imagem'),
                          textInputAction: TextInputAction.done,
                          focusNode: _imageFocus,
                          keyboardType: TextInputType.url,
                          controller: _imageUrlController,
                          onFieldSubmitted: (_) => _submit(),
                          validator: (_urlImage) {
                            final urlImage = _urlImage ?? '';

                            if (!isValidImageUrl(urlImage)) {
                              return 'Informe uma url válida!';
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        alignment: Alignment.center,
                        child: _imageUrlController.text.isEmpty
                            ? const Text('Informe a URL')
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(_imageUrlController.text),
                              ),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}
