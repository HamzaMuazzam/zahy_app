// To parse this JSON data, do
//
//     final initPaymentResponse = initPaymentResponseFromJson(jsonString);

import 'dart:convert';

InitPaymentResponse initPaymentResponseFromJson(String str) => InitPaymentResponse.fromJson(json.decode(str));

String initPaymentResponseToJson(InitPaymentResponse data) => json.encode(data.toJson());

class InitPaymentResponse {
  InitPaymentResponse({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory InitPaymentResponse.fromJson(Map<String, dynamic> json) => InitPaymentResponse(
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.status,
    this.amount,
    this.fee,
    this.currency,
    this.refunded,
    this.refundedAt,
    this.captured,
    this.capturedAt,
    this.voidedAt,
    this.description,
    this.amountFormat,
    this.feeFormat,
    this.refundedFormat,
    this.capturedFormat,
    this.invoiceId,
    this.ip,
    this.callbackUrl,
    this.createdAt,
    this.updatedAt,
    this.metadata,
    this.source,
  });

  String id;
  String status;
  dynamic amount;
  dynamic fee;
  String currency;
  dynamic refunded;
  dynamic refundedAt;
  dynamic captured;
  dynamic capturedAt;
  dynamic voidedAt;
  dynamic description;
  String amountFormat;
  String feeFormat;
  String refundedFormat;
  String capturedFormat;
  dynamic invoiceId;
  dynamic ip;
  String callbackUrl;
  String createdAt;
  String updatedAt;
  dynamic metadata;
  Source source;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    status: json["status"],
    amount: json["amount"],
    fee: json["fee"],
    currency: json["currency"],
    refunded: json["refunded"],
    refundedAt: json["refunded_at"],
    captured: json["captured"],
    capturedAt: json["captured_at"],
    voidedAt: json["voided_at"],
    description: json["description"],
    amountFormat: json["amount_format"],
    feeFormat: json["fee_format"],
    refundedFormat: json["refunded_format"],
    capturedFormat: json["captured_format"],
    invoiceId: json["invoice_id"],
    ip: json["ip"],
    callbackUrl: json["callback_url"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    metadata: json["metadata"],
    source: Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "amount": amount,
    "fee": fee,
    "currency": currency,
    "refunded": refunded,
    "refunded_at": refundedAt,
    "captured": captured,
    "captured_at": capturedAt,
    "voided_at": voidedAt,
    "description": description,
    "amount_format": amountFormat,
    "fee_format": feeFormat,
    "refunded_format": refundedFormat,
    "captured_format": capturedFormat,
    "invoice_id": invoiceId,
    "ip": ip,
    "callback_url": callbackUrl,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "metadata": metadata,
    "source": source.toJson(),
  };
}

class Source {
  Source({
    this.type,
    this.company,
    this.name,
    this.number,
    this.message,
    this.transactionUrl,
  });

  String type;
  String company;
  String name;
  String number;
  dynamic message;
  String transactionUrl;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    type: json["type"],
    company: json["company"],
    name: json["name"],
    number: json["number"],
    message: json["message"],
    transactionUrl: json["transaction_url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "company": company,
    "name": name,
    "number": number,
    "message": message,
    "transaction_url": transactionUrl,
  };
}
