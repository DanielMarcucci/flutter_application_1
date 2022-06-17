class FormTransactionDto {
  int id;
  int accountId;
  num amount;
  String comments;
  String date;

  FormTransactionDto(
      {required this.id,
      required this.accountId,
      required this.amount,
      required this.comments,
      this.date = ''});

  // factory FormTransactionDto.fromJson(Map<String, dynamic> json) {
  //   return FormTransactionDto(
  //       id: json['id'],
  //       accountId: json['account_id'],
  //       amount: json['amount'],
  //       comments: json['comments'],
  //       date: '');
  // }
}
