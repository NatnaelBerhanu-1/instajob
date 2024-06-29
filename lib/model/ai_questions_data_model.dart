import 'dart:convert';

AiQuestionsModel aiQuestionsDataFromJson(String str) => AiQuestionsModel.fromJson(json.decode(str));

String aiQuestionsDataToJson(AiQuestionsModel data) => json.encode(data.toJson());

class AiQuestionsModel {
    final QuestionsModel questions;

    AiQuestionsModel({
        required this.questions,
    });

    AiQuestionsModel copyWith({
        QuestionsModel? questions,
    }) => 
        AiQuestionsModel(
            questions: questions ?? this.questions,
        );

    factory AiQuestionsModel.fromJson(Map<String, dynamic> json) => AiQuestionsModel(
        questions: QuestionsModel.fromJson(json["questions"]),
    );

    Map<String, dynamic> toJson() => {
        "questions": questions.toJson(),
    };
}

class QuestionsModel {
    final List<String> quesList;
    final List<String> quesListJob;
    final List<dynamic> contentOrder;
    final List<dynamic> convLst;

    QuestionsModel({
        required this.quesList,
        required this.quesListJob,
        required this.contentOrder,
        required this.convLst,
    });

    QuestionsModel copyWith({
        List<String>? quesList,
        List<String>? quesListJob,
        List<dynamic>? contentOrder,
        List<dynamic>? convLst,
    }) => 
        QuestionsModel(
            quesList: quesList ?? this.quesList,
            quesListJob: quesListJob ?? this.quesListJob,
            contentOrder: contentOrder ?? this.contentOrder,
            convLst: convLst ?? this.convLst,
        );

    factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        quesList: List<String>.from(json["ques_list"].map((x) => x)),
        quesListJob: List<String>.from(json["ques_list_job"].map((x) => x)),
        contentOrder: List<dynamic>.from(json["content_order"].map((x) => x)),
        convLst: List<dynamic>.from(json["conv_lst"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "ques_list": List<dynamic>.from(quesList.map((x) => x)),
        "ques_list_job": List<dynamic>.from(quesListJob.map((x) => x)),
        "content_order": List<dynamic>.from(contentOrder.map((x) => x)),
        "conv_lst": List<dynamic>.from(convLst.map((x) => x)),
    };
}
