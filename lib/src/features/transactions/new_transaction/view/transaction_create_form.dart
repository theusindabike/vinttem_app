import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';

class TransactionCreateForm extends StatelessWidget {
  const TransactionCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<NewTransactionBloc, NewTransactionState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure || !state.isValid) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Ops! Somenthing went wrong'),
              ),
            );
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Transaction saved successfully'),
              ),
            );
          context.pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _NewTransactionUserChoiceChip(),
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
            _NewTransactionCategoriesChoiceChip(),
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

class _NewTransactionUserChoiceChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<NewTransactionBloc, NewTransactionState>(
          builder: (context, state) {
            return Wrap(
              key: const Key('newTransactionForm_user_wrap'),
              spacing: 8,
              children: TransactionUser.values.map((user) {
                return ChoiceChip(
                  label: Text(user.name),
                  selected: state.user.value == user.name,
                  onSelected: (bool selected) {
                    context
                        .read<NewTransactionBloc>()
                        .add(NewTransactionUserChanged(user: user.name));
                  },
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _NewTransactionValueField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionBloc, NewTransactionState>(
      builder: (context, state) {
        late double parsedValue;
        return TextFormField(
          key: const Key('newTransactionForm_value_textField'),
          autovalidateMode: state.isValid
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          validator: (value) {
            if (value == null || value.isEmpty || state.value.isNotValid) {
              return 'please, fill this field';
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
          onChanged: (value) {
            try {
              parsedValue = UtilBrasilFields.converterMoedaParaDouble(value);
            } catch (_) {
              parsedValue = 0;
            }
            context.read<NewTransactionBloc>().add(
                  NewTransactionValueChanged(
                    value: parsedValue,
                  ),
                );
          },
        );
      },
    );
  }
}

class _NewTransactionCategoriesChoiceChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<NewTransactionBloc, NewTransactionState>(
          builder: (context, state) {
            return Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  key: const Key('newTransactionForm_categories_wrap'),
                  spacing: 8,
                  children: TransactionCategory.values.map((category) {
                    return ChoiceChip(
                      label: Text(category.name),
                      selected: state.categories.value.contains(category.name),
                      onSelected: (bool selected) {
                        context.read<NewTransactionBloc>().add(
                              NewTransactionCategoriesChanged(
                                category: category.name,
                                action: selected
                                    ? CategoryAction.insert
                                    : CategoryAction.remove,
                              ),
                            );
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SaveTransactionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionBloc, NewTransactionState>(
      builder: (context, state) {
        void submit() {
          context
              .read<NewTransactionBloc>()
              .add(const NewTransactionSubmitted());
        }

        return ElevatedButton(
          key: const Key('newTransactionForm_save_raisedButton'),
          onPressed: state.isValid ? submit : null,
          child: const Text('Save'),
        );
      },
    );
  }
}
