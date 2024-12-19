/// https://naver.github.io/ntracker-sdk-ios/how_to_use_sdk/send_events#%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EC%A2%85%EB%A5%98%EC%97%90-%EB%94%B0%EB%A5%B8-%EC%83%81%ED%92%88-%EC%84%B8%EB%B6%80-%EC%A0%95%EB%B3%B4-%EC%A0%84%EC%86%A1
enum CurrencyCode {
  // ignore: constant_identifier_names
  KRW,
  // ignore: constant_identifier_names
  USD,
}

class NtrackerConversionItem {
  final int quantity;
  final num payAmount;
  final CurrencyCode? ext1;

  NtrackerConversionItem({
    required this.quantity,
    required this.payAmount,
    this.ext1,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json['quantity'] = quantity;
    json['payAmount'] = payAmount;
    if (ext1 != null) {
      json['ext1'] = ext1!.name;
    }

    return json;
  }
}
