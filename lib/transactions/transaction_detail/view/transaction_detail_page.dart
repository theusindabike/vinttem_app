import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:vinttem_app/transactions/models/models.dart';

class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({super.key});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  late TransactionType? _selectedTransactionType = TransactionType.justMe;
  late TransactionUser? _selectedUser = TransactionUser.matheus;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formKey = GlobalKey<FormFieldState<dynamic>>();

    final categoryItems = TransactionCategory.values
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
                      children: TransactionUser.values.map((user) {
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
                      children: TransactionType.values.map((type) {
                        return ChoiceChip(
                          label: Text(type.name),
                          selected:
                              _selectedTransactionType?.apiName == type.apiName,
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
