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
          $checkedConvert('id', (v) => v as String?),
          $checkedConvert('description', (v) => v as String?),
          transactionUser: $checkedConvert('transaction_user',
              (v) => $enumDecode(_$TransactionUserEnumMap, v)),
          value: $checkedConvert('value', (v) => (v as num).toDouble()),
          category: $checkedConvert(
              'category', (v) => $enumDecode(_$TransactionCategoryEnumMap, v)),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TransactionTypeEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'transactionUser': 'transaction_user'},
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_user': _$TransactionUserEnumMap[instance.transactionUser]!,
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
  TransactionCategory.marketStuff: 'marketStuff',
  TransactionCategory.health: 'health',
  TransactionCategory.study: 'study',
  TransactionCategory.cloths: 'cloths',
  TransactionCategory.housing: 'housing',
  TransactionCategory.transport: 'transport',
  TransactionCategory.appSubscription: 'appSubscription',
  TransactionCategory.pets: 'pets',
  TransactionCategory.gifts: 'gifts',
  TransactionCategory.personalCare: 'personalCare',
  TransactionCategory.donations: 'donations',
  TransactionCategory.buyingSomething: 'buyingSomething',
};

const _$TransactionTypeEnumMap = {
  TransactionType.justMe: 'justMe',
  TransactionType.proportinal: 'proportinal',
  TransactionType.even: 'even',
};
