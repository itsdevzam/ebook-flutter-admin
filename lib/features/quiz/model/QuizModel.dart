
class QuizModel {
  int? id;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? correctAns;
  int? categoryId;
  int? subcategory_id;
  String? explanation;

  QuizModel(
      {this.id,
        this.question,
        this.optionA,
        this.optionB,
        this.optionC,
        this.optionD,
        this.correctAns,
        this.categoryId,
        this.explanation,
        this.subcategory_id});

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    optionA = json['option_a'];
    optionB = json['option_b'];
    optionC = json['option_c'];
    optionD = json['option_d'];
    correctAns = json['correct_ans'];
    categoryId = json['category_id'];
    subcategory_id = json['subcategory_id'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['option_a'] = this.optionA;
    data['option_b'] = this.optionB;
    data['option_c'] = this.optionC;
    data['option_d'] = this.optionD;
    data['correct_ans'] = this.correctAns;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategory_id;
    data['explanation'] = this.explanation;
    return data;
  }
}