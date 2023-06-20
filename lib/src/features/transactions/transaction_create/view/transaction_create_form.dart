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

    return BlocListener<TransactionCreateBloc, TransactionCreateState>(
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
            _TransactionCreateUserChoiceChip(),
            Row(
              children: [
                Text(
                  'how much?',
                  style: textTheme.titleLarge,
                ),
              ],
            ),
            _TransactionCreateValueField(),
            const SizedBox(height: 10),
            _TransactionCreateCategoryChoiceChip(),
            const SizedBox(height: 10),
            _TransactionCreateTypeChoiceChip(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    _TransactionCreateClearFormButton(),
                    _TransactionCreateSaveButton(),
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

class _TransactionCreateUserChoiceChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<TransactionCreateBloc, TransactionCreateState>(
          builder: (context, state) {
            return Wrap(
              key: const Key('TransactionCreateForm_user_wrap'),
              spacing: 8,
              children: TransactionUser.values.map((user) {
                return ChoiceChip(
                  label: Text(user.name),
                  selected: state.user.value == user.name,
                  onSelected: (bool selected) {
                    context
                        .read<TransactionCreateBloc>()
                        .add(TransactionCreateUserChanged(user: user.name));
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

class _TransactionCreateValueField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCreateBloc, TransactionCreateState>(
      builder: (context, state) {
        late double parsedValue;
        return TextFormField(
          key: const Key('TransactionCreateForm_value_textField'),
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
            context.read<TransactionCreateBloc>().add(
                  TransactionCreateValueChanged(
                    value: parsedValue,
                  ),
                );
          },
        );
      },
    );
  }
}

class _TransactionCreateCategoryChoiceChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<TransactionCreateBloc, TransactionCreateState>(
          builder: (context, state) {
            return Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  key: const Key('TransactionCreateForm_category_wrap'),
                  spacing: 8,
                  children: TransactionCategory.values.map((category) {
                    return ChoiceChip(
                      label: Text(category.name),
                      selected: state.category.value == category.name,
                      onSelected: (bool selected) {
                        context.read<TransactionCreateBloc>().add(
                              TransactionCreateCategoryChanged(
                                category: category.name,
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

class _TransactionCreateTypeChoiceChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<TransactionCreateBloc, TransactionCreateState>(
          builder: (context, state) {
            return Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  key: const Key('TransactionCreateForm_type_wrap'),
                  spacing: 8,
                  children: TransactionType.values.map((type) {
                    return ChoiceChip(
                      label: Text(type.name),
                      selected: state.type.value == type.name,
                      onSelected: (bool selected) {
                        context.read<TransactionCreateBloc>().add(
                              TransactionCreateTypeChanged(
                                type: type.name,
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

class _TransactionCreateClearFormButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCreateBloc, TransactionCreateState>(
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('TransactionCreateForm_clean_raisedButton'),
          onPressed: () => context.read<TransactionCreateBloc>().add(
                const TransactionCreateFormCleaned(),
              ),
          child: const Text('Clean'),
        );
      },
    );
  }
}

class _TransactionCreateSaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCreateBloc, TransactionCreateState>(
      builder: (context, state) {
        void submit() {
          context
              .read<TransactionCreateBloc>()
              .add(const TransactionCreateSubmitted());
        }

        return ElevatedButton(
          key: const Key('TransactionCreateForm_save_raisedButton'),
          onPressed: state.isValid ? submit : null,
          child: const Text('Save'),
        );
      },
    );
  }
}
