class HomeModel {
  int? totalUsers;
  int? proUsers;
  int? totalEbooks;
  int? ebooksCat;
  int? totalQuiz;
  int? quizCat;

  HomeModel(
      {this.totalUsers,
        this.proUsers,
        this.totalEbooks,
        this.ebooksCat,
        this.totalQuiz,
        this.quizCat});

  HomeModel.fromJson(Map<String, dynamic> json) {
    totalUsers = json['total_users'];
    proUsers = json['pro_users'];
    totalEbooks = json['total_ebooks'];
    ebooksCat = json['ebooks_cat'];
    totalQuiz = json['total_quiz'];
    quizCat = json['quiz_cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_users'] = this.totalUsers;
    data['pro_users'] = this.proUsers;
    data['total_ebooks'] = this.totalEbooks;
    data['ebooks_cat'] = this.ebooksCat;
    data['total_quiz'] = this.totalQuiz;
    data['quiz_cat'] = this.quizCat;
    return data;
  }
}