class FaqModel {
  String? faqId;
  String? faqQuestion;
  String? faqAnswer;
  String? faqCategory;
  String? faqType;
  
 
  FaqModel(
      {required this.faqId,
      required this.faqQuestion,
      required this.faqAnswer,
      required this.faqCategory,
      required this.faqType,
      });

  FaqModel.fromJson(Map<String, dynamic> json) {
    faqId = json['faqId'];
    faqQuestion = json['faqQuestion'];
    faqAnswer = json['faqAnswer'];
    faqCategory = json['faqCategory'];
    faqType = json['faqType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faqId'] = this.faqId;
    data['faqQuestion'] = this.faqQuestion;
    data['faqAnswer'] = this.faqAnswer;
    data['faqCategory'] = this.faqCategory;
    data['faqType'] = this.faqType;
    return data;
  }
}
