class SubordinateModel {
  dynamic id;
  dynamic u_id;
  dynamic bet_amount;
  dynamic total_cash;
  dynamic commission;
  dynamic yesterday_date;


  SubordinateModel({
    required this.id,
    required this.u_id,
    required this.bet_amount,
    required this.total_cash,
    required this.commission,
    required this.yesterday_date,

  });
  factory SubordinateModel.fromJson(Map<String, dynamic> json) {
    return SubordinateModel(
      id: json['id'],
      u_id: json['u_id'],
      bet_amount: json['bet_amount'],
      total_cash: json['total_cash'],
      commission: json['commission'],
      yesterday_date: json['yesterday_date'],

    );
  }
}