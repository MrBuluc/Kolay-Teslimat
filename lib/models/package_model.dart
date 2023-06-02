class Package {
  String id;
  String typeName;
  String status;
  double price;
  String receiver;
  String sender;
  String? receiverAddress;
  String? senderAddress;
  String? description;

  Package(
      {required this.id,
      required this.typeName,
      required this.status,
      required this.price,
      required this.receiver,
      required this.sender,
      this.receiverAddress,
      this.senderAddress,
      this.description});
}
