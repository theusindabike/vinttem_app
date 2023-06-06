import 'package:flutter/material.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({super.key});

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Vinttem'), elevation: 4),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'user',
                    style: textTheme.titleLarge,
                  ),
                ],
              ),
              TextFormField(
                validator: (value) {
                  print('=== Trying to validate: $value');
                  if (value == null || value.isEmpty) {
                    return 'please fill this field';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '(user)',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Clean'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('=== Trying to save: ');
                          if (formKey.currentState!.validate()) {
                            print('=== Trying to show snackbar: ');
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saving...')));
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
