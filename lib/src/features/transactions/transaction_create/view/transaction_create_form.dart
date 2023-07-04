import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';
import 'package:vinttem_ui/vinttem_ui.dart';

class TransactionCreateForm extends StatelessWidget {
  const TransactionCreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionCreateBloc, TransactionCreateState>(
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
      builder: (context, state) => Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const _RowLabel(label: 'paid by'),
              MultiChoiceChips<TransactionUser>(
                key: const Key('TransactionCreateForm_user_wrap'),
                options: TransactionUser.values
                    .map(
                      (e) => ChoiceChipItem<TransactionUser>(
                        id: e.name,
                        label: e.name,
                      ),
                    )
                    .toList(),
                onSelected: (e) => context.read<TransactionCreateBloc>().add(
                      TransactionCreateUserChanged(
                        user: e.label,
                      ),
                    ),
                selectedItem: ChoiceChipItem(
                  id: state.user.value,
                  label: state.user.value,
                ),
              ),
              const SizedBox(height: 10),
              const _RowLabel(label: 'how much'),
              _TransactionCreateValueField(),
              const SizedBox(height: 10),
              const _RowLabel(label: 'category'),
              MultiChoiceChips<TransactionCategory>(
                key: const Key('TransactionCreateForm_category_wrap'),
                options: TransactionCategory.values
                    .map(
                      (e) => ChoiceChipItem<TransactionCategory>(
                        id: e.name,
                        label: e.name,
                      ),
                    )
                    .toList(),
                onSelected: (e) => context.read<TransactionCreateBloc>().add(
                      TransactionCreateCategoryChanged(
                        category: e.label,
                      ),
                    ),
                selectedItem: ChoiceChipItem(
                  id: state.category.value,
                  label: state.category.value,
                ),
              ),
              const SizedBox(height: 10),
              const _RowLabel(label: 'type'),
              MultiChoiceChips<TransactionType>(
                key: const Key('TransactionCreateForm_type_wrap'),
                options: TransactionType.values
                    .map(
                      (e) => ChoiceChipItem<TransactionType>(
                        id: e.name,
                        label: e.name,
                      ),
                    )
                    .toList(),
                onSelected: (e) => context.read<TransactionCreateBloc>().add(
                      TransactionCreateTypeChanged(
                        type: e.label,
                      ),
                    ),
                selectedItem: ChoiceChipItem(
                  id: state.type.value,
                  label: state.type.value,
                ),
              ),
              const SizedBox(height: 10),
              const _RowLabel(
                label: 'description',
              ),
              TextFormField(
                key: const Key('TransactionCreateForm_description_textField'),
                decoration: const InputDecoration(hintText: '<optional>'),
                textInputAction: TextInputAction.done,
                onChanged: (value) => context.read<TransactionCreateBloc>().add(
                      TransactionCreateDescriptionChanged(
                        description: value,
                      ),
                    ),
              ),
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
      ),
    );
  }
}

class _RowLabel extends StatelessWidget {
  const _RowLabel({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium,
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
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
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
