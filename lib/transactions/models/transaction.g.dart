// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Transaction',
      json,
      ($checkedConvert) {
        final val = Transaction(
          id: $checkedConvert('id', (v) => v as int?),
          description: $checkedConvert('description', (v) => v as String?),
          user: $checkedConvert(
              'user', (v) => $enumDecode(_$TransactionUserEnumMap, v)),
          value: $checkedConvert('value', (v) => (v as num).toDouble()),
          category: $checkedConvert(
              'category', (v) => $enumDecode(_$TransactionCategoryEnumMap, v)),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TransactionTypeEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': _$TransactionUserEnumMap[instance.user]!,
      'value': instance.value,
      'category': _$TransactionCategoryEnumMap[instance.category]!,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'description': instance.description,
    };

const _$TransactionUserEnumMap = {
  TransactionUser.matheus: 'matheus',
  TransactionUser.bianca: 'bianca',
};

const _$TransactionCategoryEnumMap = {
  TransactionCategory.recreation: 'recreation',
  TransactionCategory.marketStuff: 'market_stuff',
  TransactionCategory.health: 'health',
  TransactionCategory.study: 'study',
  TransactionCategory.cloths: 'cloths',
  TransactionCategory.housing: 'housing',
  TransactionCategory.transport: 'transport',
  TransactionCategory.subscription: 'subscription',
  TransactionCategory.pets: 'pets',
  TransactionCategory.gifts: 'gifts',
  TransactionCategory.personalCare: 'personal_care',
  TransactionCategory.donations: 'donations',
  TransactionCategory.shopping: 'shopping',
  TransactionCategory.travel: 'travel',
};

const _$TransactionTypeEnumMap = {
  TransactionType.individual: 'individual',
  TransactionType.proportional: 'proportional',
  TransactionType.even: 'even',
};
