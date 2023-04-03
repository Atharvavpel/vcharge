class TransactionModel {
  String? initiateTransactionDate;
  String? completeTransactionDate;
  String? initiateTransactionTime;
  String? completeTransactionTime;
  String? transactionAmount;
  String? transactionUTR;
  String? transactionStatus;
  String? createdDate;

  TransactionModel(
      {this.initiateTransactionDate,
      this.completeTransactionDate,
      this.initiateTransactionTime,
      this.completeTransactionTime,
      this.transactionAmount,
      this.transactionUTR,
      this.transactionStatus,
      this.createdDate});
}
