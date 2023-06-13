import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';

class TransactionCreateForm extends StatelessWidget {
  const TransactionCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const selectedUser = TransactionUser.matheus;

    return BlocListener<NewTransactionBloc, NewTransactionState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure || !state.isValid) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Somenthing went wrong'),
              ),
            );
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Omg worked11!'),
              ),
            );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Wrap(
            //       spacing: 8,
            //       children: TransactionUser.values.map((user) {
            //         return ChoiceChip(
            //           label: Text(user.name),
            //           selected: selectedUser.id == user.id,
            //           onSelected: (bool selected) {
            //             // setState(() {
            //             //   _selectedUser = selected ? user : null;
            //             // });
            //           },
            //         );
            //       }).toList(),
            //     ),
            //   ],
            // ),
            _NewTransactionUserField(),
            Row(
              children: [
                Text(
                  'how much?',
                  style: textTheme.titleLarge,
                ),
              ],
            ),
            _NewTransactionValueField(),
            const SizedBox(height: 10),
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
                    _SaveTransactionButton(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NewTransactionUserField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionBloc, NewTransactionState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please fill this field';
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '(user)',
          ),
          onChanged: (value) {
            context
                .read<NewTransactionBloc>()
                .add(NewTransactionUserChanged(user: value));
          },
        );
      },
    );
  }
}

class _NewTransactionValueField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionBloc, NewTransactionState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('newTransactionForm_value'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please fill this field';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CentavosInputFormatter(moeda: true)
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: r'R$ 0,00',
          ),
          onChanged: (value) => {
            context.read<NewTransactionBloc>().add(
                  NewTransactionValueChanged(
                      value: UtilBrasilFields.converterMoedaParaDouble(value)),
                )
          },
        );
      },
    );
  }
}

class _SaveTransactionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionBloc, NewTransactionState>(
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('newTransactionForm_save_raisedButton'),
          onPressed: () {
            context
                .read<NewTransactionBloc>()
                .add(const NewTransactionSubmitted());
          },
          child: const Text('Save'),
        );
      },
    );
  }
}
