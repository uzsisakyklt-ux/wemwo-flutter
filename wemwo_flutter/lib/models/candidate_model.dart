// FILE: lib/models/candidate_model.dart

import 'dart:convert';

class Skill {
  final String name;
  final String years; // e.g. "5 m."
  final String? level; // e.g. "Senior"

  Skill({required this.name, required this.years, this.level});

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        name: json['name'] as String? ?? '',
        years: json['years'] as String? ?? '',
        level: json['level'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'years': years,
        'level': level,
      };
}

class Language {
  final String name;
  final String level; // e.g. "C1"

  Language({required this.name, required this.level});

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        name: json['name'] as String? ?? '',
        level: json['level'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'level': level,
      };
}

class Education {
  final String degree; // e.g. "Bakalauras"
  final String field; // e.g. "Informatika"
  final String institution; // e.g. "Vilniaus Universitetas"

  Education({required this.degree, required this.field, required this.institution});

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        degree: json['degree'] as String? ?? '',
        field: json['field'] as String? ?? '',
        institution: json['institution'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'degree': degree,
        'field': field,
        'institution': institution,
      };
}

class CandidateModel {
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String? city;
  final String? jobType;
  final String? sector;     // 👈 NAUJAS LAUKAS
  final String? about;
  final List<Skill> skills;
  final int? salaryFrom;
  final int? salaryTo;
  final List<Language> languages;
  final Education? education;

  CandidateModel({
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.city,
    this.jobType,
    this.sector,
    this.about,
    this.skills = const [],
    this.salaryFrom,
    this.salaryTo,
    this.languages = const [],
    this.education,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        city: json['city'] as String?,
        jobType: json['jobType'] as String?,
        sector: json['sector'] as String?, // 👈 nuskaitom, jei yra
        about: json['about'] as String?,
        skills: (json['skills'] as List<dynamic>?)
                ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        salaryFrom: json['salaryFrom'] is int
            ? json['salaryFrom'] as int
            : (json['salaryFrom'] is String ? int.tryParse(json['salaryFrom']) : null),
        salaryTo: json['salaryTo'] is int
            ? json['salaryTo'] as int
            : (json['salaryTo'] is String ? int.tryParse(json['salaryTo']) : null),
        languages: (json['languages'] as List<dynamic>?)
                ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        education: json['education'] != null
            ? Education.fromJson(json['education'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'avatarUrl': avatarUrl,
        'city': city,
        'jobType': jobType,
        'sector': sector, // 👈 naujas
        'about': about,
        'skills': skills.map((s) => s.toJson()).toList(),
        'salaryFrom': salaryFrom,
        'salaryTo': salaryTo,
        'languages': languages.map((l) => l.toJson()).toList(),
        'education': education?.toJson(),
      };

  String encode() => json.encode(toJson());

  factory CandidateModel.decode(String source) =>
      CandidateModel.fromJson(json.decode(source) as Map<String, dynamic>);
}
