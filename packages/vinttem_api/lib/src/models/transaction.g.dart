// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['description'] as String?,
      id: json['id'] as String,
      transactionUser:
          $enumDecode(_$TransactionUserEnumMap, json['transactionUser']),
      value: (json['value'] as num).toDouble(),
      category: $enumDecode(_$TransactionCategoryEnumMap, json['category']),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionUser': _$TransactionUserEnumMap[instance.transactionUser]!,
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
