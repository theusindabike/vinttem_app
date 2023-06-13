// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as int?,
      user: $enumDecode(_$TransactionUserEnumMap, json['user']),
      value: (json['value'] as num).toDouble(),
      category: $enumDecode(_$TransactionCategoryEnumMap, json['category']),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      description: json['description'] as String?,
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
  TransactionCategory.marketStuff: 'marketStuff',
  TransactionCategory.health: 'health',
  TransactionCategory.study: 'study',
  TransactionCategory.cloths: 'cloths',
  TransactionCategory.housing: 'housing',
  TransactionCategory.transport: 'transport',
  TransactionCategory.subscription: 'subscription',
  TransactionCategory.pets: 'pets',
  TransactionCategory.gifts: 'gifts',
  TransactionCategory.personalCare: 'personalCare',
  TransactionCategory.donations: 'donations',
  TransactionCategory.shopping: 'shopping',
  TransactionCategory.travel: 'travel',
};

const _$TransactionTypeEnumMap = {
  TransactionType.individual: 'individual',
  TransactionType.proportional: 'proportional',
  TransactionType.even: 'even',
};
