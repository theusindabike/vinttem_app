import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TransactionCategory {
  TransactionCategory({
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
  @override
  Widget build(BuildContext context) {
    final _multiSelectKey = GlobalKey<FormFieldState>();
    final List<TransactionCategory> _transactionCategories = [
      TransactionCategory(id: 1, name: 'Lazer'),
      TransactionCategory(id: 2, name: 'Mercado'),
      TransactionCategory(id: 3, name: 'Saúde'),
      TransactionCategory(id: 4, name: 'Estudo'),
      TransactionCategory(id: 5, name: 'Vestuário'),
      TransactionCategory(id: 6, name: 'Moradia'),
      TransactionCategory(id: 7, name: 'Transporte'),
      TransactionCategory(id: 8, name: 'Assinatura de Apps'),
      TransactionCategory(id: 9, name: 'Animais de estimação'),
      TransactionCategory(id: 10, name: 'Presentes'),
      TransactionCategory(id: 11, name: 'Cuidados pessoais'),
      TransactionCategory(id: 12, name: 'Doações'),
      TransactionCategory(id: 13, name: 'Compras Geral'),
    ];
    final _items = _transactionCategories
        .map(
          (transactionCategory) => MultiSelectItem<TransactionCategory>(
            transactionCategory,
            transactionCategory.name,
          ),
        )
        .toList();

    List<TransactionCategory> _selectedTransactionCategories = [];

    @override
    void initState() {
      _selectedTransactionCategories = _transactionCategories;
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Vinttem')),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: true)
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Value',
              ),
            ),
            const SizedBox(height: 40),
            MultiSelectChipField(
              items: _items,
              initialValue: [],
              title: Text("Categories"),
              headerColor: Colors.blue.withOpacity(0.5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1.8),
              ),
              selectedChipColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: TextStyle(color: Colors.blue[800]),
              onTap: (values) {
                //_selectedAnimals4 = values;
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: const Text('nice'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {},
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
