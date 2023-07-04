import 'package:hive/hive.dart';

// part 'payment_card.g.dart';

@HiveType(typeId: 1)
class PaymentCard {
  PaymentCard({
    required this.cardNumber,
    required this.expirationDate,
    required this.cvc,
    required this.ownerName,
    required this.ownerCountry,
    required this.ownerAddress,
    required this.ownerZipCode,
    required this.ownerState,
  });

  @HiveField(0)
  String cardNumber;

  @HiveField(1)
  String expirationDate;

  @HiveField(2)
  String cvc;

  @HiveField(3)
  String ownerName;

  @HiveField(4)
  String ownerCountry;

  @HiveField(5)
  String ownerAddress;

  @HiveField(6)
  String ownerZipCode;

  @HiveField(7)
  String ownerState;
}
