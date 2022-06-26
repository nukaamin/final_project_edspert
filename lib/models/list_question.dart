class ListQuestion {
  int? status;
  String? message;
  List<Data>? data;

  ListQuestion({this.status, this.message, this.data});

  ListQuestion.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? exerciseIdFk;
  String? bankQuestionId;
  String? questionTitle;
  String? questionTitleImg;
  String? optionA;
  String? optionAImg;
  String? optionB;
  String? optionBImg;
  String? optionC;
  String? optionCImg;
  String? optionD;
  String? optionDImg;
  String? optionE;
  String? optionEImg;
  String? studentAnswer;

  Data(
      {this.exerciseIdFk,
      this.bankQuestionId,
      this.questionTitle,
      this.questionTitleImg,
      this.optionA,
      this.optionAImg,
      this.optionB,
      this.optionBImg,
      this.optionC,
      this.optionCImg,
      this.optionD,
      this.optionDImg,
      this.optionE,
      this.optionEImg,
      this.studentAnswer});

  Data.fromJson(Map<String, dynamic> json) {
    exerciseIdFk = json['exercise_id_fk'];
    bankQuestionId = json['bank_question_id'];
    questionTitle = json['question_title'];
    questionTitleImg = json['question_title_img'];
    optionA = json['option_a'];
    optionAImg = json['option_a_img'];
    optionB = json['option_b'];
    optionBImg = json['option_b_img'];
    optionC = json['option_c'];
    optionCImg = json['option_c_img'];
    optionD = json['option_d'];
    optionDImg = json['option_d_img'];
    optionE = json['option_e'];
    optionEImg = json['option_e_img'];
    studentAnswer = json['student_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['exercise_id_fk'] = exerciseIdFk;
    data['bank_question_id'] = bankQuestionId;
    data['question_title'] = questionTitle;
    data['question_title_img'] = questionTitleImg;
    data['option_a'] = optionA;
    data['option_a_img'] = optionAImg;
    data['option_b'] = optionB;
    data['option_b_img'] = optionBImg;
    data['option_c'] = optionC;
    data['option_c_img'] = optionCImg;
    data['option_d'] = optionD;
    data['option_d_img'] = optionDImg;
    data['option_e'] = optionE;
    data['option_e_img'] = optionEImg;
    data['student_answer'] = studentAnswer;
    return data;
  }
}