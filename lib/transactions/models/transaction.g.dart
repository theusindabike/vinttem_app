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
          id: $checkedConvert('id', (v) => v as String?),
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
  TransactionCategory.appSubscription: 'app_subscription',
  TransactionCategory.pets: 'pets',
  TransactionCategory.gifts: 'gifts',
  TransactionCategory.personalCare: 'personal_care',
  TransactionCategory.donations: 'donations',
  TransactionCategory.buyingSomething: 'buying_something',
};

const _$TransactionTypeEnumMap = {
  TransactionType.justMe: 'just_me',
  TransactionType.proportional: 'proportional',
  TransactionType.even: 'even',
};
