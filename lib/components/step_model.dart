class StepModel {
  final int? id;
  final String? text;

  StepModel({this.id, this.text});

  static List<StepModel> list = [
    StepModel(
      id: 1,
      text:
          "E-learning Platform for every\n students to learn, test and conquer.\n Learn With AI",
    ),
    StepModel(
      id: 2,
      text:
          "We offer best materials\n to enhance your knowledge and\n take you to your goal.",
    ),
  ];
}
