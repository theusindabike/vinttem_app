import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class User {
  User({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

class TransactionCategory {
  TransactionCategory({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

class TransactionType {
  TransactionType({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final List<TransactionType> _transactionTypes = [
    TransactionType(id: 1, name: 'Personal'),
    TransactionType(id: 2, name: 'Proportional'),
    TransactionType(id: 3, name: 'Even'),
  ];

  late TransactionType? _selectedTransactionType = _transactionTypes[0];

  final List<User> _users = [
    User(id: 1, name: 'Matheus'),
    User(id: 2, name: 'Bianca'),
  ];

  late User? _selectedUser = _users[0];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formKey = GlobalKey<FormFieldState<dynamic>>();

    final transactionCategories = [
      TransactionCategory(id: 1, name: 'Recreation'),
      TransactionCategory(id: 2, name: 'Market stuff?'),
      TransactionCategory(id: 3, name: 'Health'),
      TransactionCategory(id: 4, name: 'Study'),
      TransactionCategory(id: 5, name: 'Cloths'),
      TransactionCategory(id: 6, name: 'Housing'),
      TransactionCategory(id: 7, name: 'Transport'),
      TransactionCategory(id: 8, name: 'App Subscription'),
      TransactionCategory(id: 9, name: 'Pets'),
      TransactionCategory(id: 10, name: 'Gifts'),
      TransactionCategory(id: 11, name: 'Personal Care'),
      TransactionCategory(id: 12, name: 'Donations'),
      TransactionCategory(id: 13, name: 'Buying something'),
    ];

    final categoryItems = transactionCategories
        .map(
          (transactionCategory) => MultiSelectItem<TransactionCategory>(
            transactionCategory,
            transactionCategory.name,
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Vinttem'), elevation: 4),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'who?',
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: _users.map((user) {
                        return ChoiceChip(
                          label: Text(user.name),
                          selected: _selectedUser?.id == user.id,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedUser = selected ? user : null;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'how much?',
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(moeda: true)
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'categories',
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
                MultiSelectChipField(
                  showHeader: false,
                  decoration: const BoxDecoration(),
                  chipShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: categoryItems,
                  initialValue: const [],
                  onTap: (values) {
                    //_selectedAnimals4 = values;
                  },
                ),
                Row(
                  children: [
                    Text(
                      'types',
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: _transactionTypes.map((type) {
                        return ChoiceChip(
                          label: Text(type.name),
                          selected: _selectedTransactionType?.id == type.id,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedTransactionType = selected ? type : null;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'description',
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '(optional)',
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
                          onPressed: () {},
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
      ),
    );
  }
}
