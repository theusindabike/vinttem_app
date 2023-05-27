import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction extends Equatable {
  Transaction({
    required this.id,
    required this.user,
    required this.value,
    required this.category,
    required this.type,
    this.description,
  });

  final String id;
  final TransactionUser user;
  final double value;
  final TransactionCategory category;
  final TransactionType type;
  String? description;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
  
  @override
  List<Object?> get props => [id, user, value, category, type, description];
}

enum TransactionUser {
  matheus('matheus_id', 'Matheus'),
  bianca('bianca_id', 'Bianca');

  const TransactionUser(this.id, this.description);

  final String id;
  final String description;
}

enum TransactionCategory {
  recreation('RECREATION', 'Recreation'),
  marketStuff('MARKET_STUFF', 'Market Stuff'),
  health('HEALTH', 'Health'),
  study('STUDY', 'Study'),
  cloths('CLOTHS', 'Cloths'),
  housing('HOUSING', 'Housing'),
  transport('TRANSPORT', 'Transport'),
  appSubscription('APP_SUBSCRIPTION', 'App Subscription'),
  pets('PETS', 'Pets'),
  gifts('GIFTS', 'Gifts'),
  personalCare('PERSONAL_CARE', 'Personal Care'),
  donations('DONATIONS', 'Donations'),
  buyingSomething('BUYING_SOMETHING', 'Buying Something');

  const TransactionCategory(this.apiName, this.description);

  final String apiName;
  final String description;
}

enum TransactionType {
  justMe('JUST_ME', 'Just Me'),
  proportinal('PROPORTIONAL', 'Proportional'),
  even('EVEN', 'Even');

  const TransactionType(this.apiName, this.description);

  final String apiName;
  final String description;
}
