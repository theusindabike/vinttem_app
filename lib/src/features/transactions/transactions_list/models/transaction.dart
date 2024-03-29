import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction extends Equatable {
  const Transaction({
    this.id,
    this.description,
    required this.user,
    required this.value,
    required this.category,
    required this.type,
  });

  final int? id;
  final TransactionUser user;
  final double value;
  final TransactionCategory category;
  final TransactionType type;
  final String? description;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonEnum(fieldRename: FieldRename.snake)
enum TransactionUser {
  matheus('matheus_id', 'Matheus'),
  bianca('bianca_id', 'Bianca');

  const TransactionUser(this.id, this.name);

  final String id;
  final String name;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum TransactionCategory {
  recreation('RECREATION', 'Recreation'),
  marketStuff('MARKET_STUFF', 'Market Stuff'),
  health('HEALTH', 'Health'),
  study('STUDY', 'Study'),
  cloths('CLOTHS', 'Cloths'),
  housing('HOUSING', 'Housing'),
  transport('TRANSPORT', 'Transport'),
  subscription('SUBSCRIPTION', 'Subscription'),
  pets('PETS', 'Pets'),
  gifts('GIFTS', 'Gifts'),
  personalCare('PERSONAL_CARE', 'Personal Care'),
  donations('DONATIONS', 'Donations'),
  shopping('SHOPPING', 'Shopping'),
  travel('TRAVEL', 'Travel');

  const TransactionCategory(this.apiName, this.name);

  final String apiName;
  final String name;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum TransactionType {
  individual('INDIVIDUAL', 'Individual'),
  proportional('PROPORTIONAL', 'Proportional'),
  even('EVEN', 'Even');

  const TransactionType(this.apiName, this.name);

  final String apiName;
  final String name;
}
