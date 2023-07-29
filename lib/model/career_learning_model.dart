class ClusterDetailsModel {
  String? href;
  String? code;
  String? title;
  Tags? tags;

  ClusterDetailsModel({
    this.href,
    this.code,
    this.title,
    this.tags,
  });

  ClusterDetailsModel.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    code = json['code'];
    title = json['title'];
    tags = json['tags'] != null ? Tags.fromJson(json['tags']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['code'] = code;
    data['title'] = title;
    if (tags != null) {
      data['tags'] = tags!.toJson();
    }

    return data;
  }
}

class Tags {
  bool? brightOutlook;
  bool? green;

  Tags({this.brightOutlook, this.green});

  Tags.fromJson(Map<String, dynamic> json) {
    brightOutlook = json['bright_outlook'];
    green = json['green'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bright_outlook'] = brightOutlook;
    data['green'] = green;
    return data;
  }
}

class CareerClusterModel {
  String? code;
  String? title;
  Tags? tags;
  String? description;
  SampleOfReportedJobTitles? sampleOfReportedJobTitles;
  Updated? updated;
  // List<TaskModel>? task;
  SummaryResources? summaryResources;
  SummaryResources? detailsResources;
  SummaryResources? customResources;

  CareerClusterModel(
      {this.code,
      this.title,
      this.tags,
      this.description,
      this.sampleOfReportedJobTitles,
      this.updated,
      this.summaryResources,
      // this.task,
      this.detailsResources,
      this.customResources});

  CareerClusterModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    tags = json['tags'] != null ? Tags.fromJson(json['tags']) : null;
    description = json['description'];
    sampleOfReportedJobTitles = json['sample_of_reported_job_titles'] != null
        ? SampleOfReportedJobTitles.fromJson(
            json['sample_of_reported_job_titles'])
        : null;
    updated =
        json['updated'] != null ? Updated.fromJson(json['updated']) : null;
    // if (json['task'] != null) {
    //   task = <TaskModel>[];
    //   json['task'].forEach((v) {
    //     task!.add(TaskModel.fromJson(v));
    //   });
    // }
    summaryResources = json['summary_resources'] != null
        ? SummaryResources.fromJson(json['summary_resources'])
        : null;
    detailsResources = json['details_resources'] != null
        ? SummaryResources.fromJson(json['details_resources'])
        : null;
    customResources = json['custom_resources'] != null
        ? SummaryResources.fromJson(json['custom_resources'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['title'] = title;
    if (tags != null) {
      data['tags'] = tags!.toJson();
    }
    data['description'] = description;
    if (sampleOfReportedJobTitles != null) {
      data['sample_of_reported_job_titles'] =
          sampleOfReportedJobTitles!.toJson();
    }
    if (updated != null) {
      data['updated'] = updated!.toJson();
    }
    if (summaryResources != null) {
      data['summary_resources'] = summaryResources!.toJson();
    }
    if (detailsResources != null) {
      data['details_resources'] = detailsResources!.toJson();
    }
    if (customResources != null) {
      data['custom_resources'] = customResources!.toJson();
    }
    // if (task != null) {
    //   data['task'] = task!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class SampleOfReportedJobTitles {
  List<String>? title;

  SampleOfReportedJobTitles({this.title});

  SampleOfReportedJobTitles.fromJson(Map<String, dynamic> json) {
    title = json['title'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}

class Updated {
  bool? partial;
  int? year;
  List<ResourceUpdated>? resourceUpdated;

  Updated({this.partial, this.year, this.resourceUpdated});

  Updated.fromJson(Map<String, dynamic> json) {
    partial = json['partial'];
    year = json['year'];
    if (json['resource_updated'] != null) {
      resourceUpdated = <ResourceUpdated>[];
      json['resource_updated'].forEach((v) {
        resourceUpdated!.add(ResourceUpdated.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partial'] = partial;
    data['year'] = year;
    if (resourceUpdated != null) {
      data['resource_updated'] =
          resourceUpdated!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskModel {
  int? id;
  bool? green;
  String? related;
  String? name;
  String? description;

  TaskModel({this.id, this.green, this.related, this.name, this.description});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    green = json['green'];
    related = json['related'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['green'] = green;
    data['related'] = related;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class WorkModel {
  String? id;
  String? related;
  String? name;
  String? description;
  List<Response>? response;

  WorkModel(
      {this.id, this.related, this.name, this.description, this.response});

  WorkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    related = json['related'];
    name = json['name'];
    description = json['description'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['related'] = related;
    data['name'] = name;
    data['description'] = description;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TechSkillModel {
  String? related;
  Title? title;
  List<Example>? example;

  TechSkillModel({this.related, this.title, this.example});

  TechSkillModel.fromJson(Map<String, dynamic> json) {
    related = json['related'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    if (json['example'] != null) {
      example = <Example>[];
      json['example'].forEach((v) {
        example!.add(Example.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['related'] = related;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (example != null) {
      data['example'] = example!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  int? percentage;
  String? name;

  Response({this.percentage, this.name});

  Response.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentage'] = percentage;
    data['name'] = name;
    return data;
  }
}

class Title {
  int? id;
  String? name;

  Title({this.id, this.name});

  Title.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Example {
  String? name;
  String? hotTechnology;

  Example({this.name, this.hotTechnology});

  Example.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hotTechnology = json['hot_technology'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['hot_technology'] = hotTechnology;
    return data;
  }
}

class ResourceUpdated {
  String? title;
  String? source;
  int? year;

  ResourceUpdated({this.title, this.source, this.year});

  ResourceUpdated.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    source = json['source'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['source'] = source;
    data['year'] = year;
    return data;
  }
}

class SummaryResources {
  List<Resource>? resource;

  SummaryResources({this.resource});

  SummaryResources.fromJson(Map<String, dynamic> json) {
    if (json['resource'] != null) {
      resource = <Resource>[];
      json['resource'].forEach((v) {
        resource!.add(Resource.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (resource != null) {
      data['resource'] = resource!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resource {
  String? href;
  String? title;

  Resource({this.href, this.title});

  Resource.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['title'] = title;
    return data;
  }
}

class JobZoneModel {
  String? code;
  String? report;
  int? value;
  String? title;
  String? education;
  String? relatedExperience;
  String? jobTraining;
  String? jobZoneExamples;
  String? svpRange;

  JobZoneModel(
      {this.code,
      this.report,
      this.value,
      this.title,
      this.education,
      this.relatedExperience,
      this.jobTraining,
      this.jobZoneExamples,
      this.svpRange});

  JobZoneModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    report = json['report'];
    value = json['value'];
    title = json['title'];
    education = json['education'];
    relatedExperience = json['related_experience'];
    jobTraining = json['job_training'];
    jobZoneExamples = json['job_zone_examples'];
    svpRange = json['svp_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['report'] = report;
    data['value'] = value;
    data['title'] = title;
    data['education'] = education;
    data['related_experience'] = relatedExperience;
    data['job_training'] = jobTraining;
    data['job_zone_examples'] = jobZoneExamples;
    data['svp_range'] = svpRange;
    return data;
  }
}

class ClusterEducationModel {
  String? name;
  Score? score;

  ClusterEducationModel({this.name, this.score});

  ClusterEducationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'] != null ? Score.fromJson(json['score']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (score != null) {
      data['score'] = score!.toJson();
    }
    return data;
  }
}

class Score {
  String? scale;
  int? value;

  Score({this.scale, this.value});

  Score.fromJson(Map<String, dynamic> json) {
    scale = json['scale'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scale'] = scale;
    data['value'] = value;
    return data;
  }
}
