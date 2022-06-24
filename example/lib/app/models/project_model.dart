/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
import 'package:flutter/material.dart';

class ProjectModel {
  final String? number;
  final String? job;
  final String? name;
  final String? title;
  final String? date;
  final String? client;
  final double? progress;
  final Color color;

  const ProjectModel({
    this.number,
    this.job,
    this.name,
    this.title,
    this.date,
    this.client,
    this.progress,
    this.color = const Color(0xFF37B34A),
  });
}
