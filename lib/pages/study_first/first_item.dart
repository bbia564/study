import 'package:flutter/material.dart';
import 'package:study_work/db_study_work/study_entity.dart';
import 'package:study_work/main.dart';
import 'package:styled_widget/styled_widget.dart';

class FirstItem extends StatefulWidget {
  const FirstItem(this.entity, {this.statusOnTap, Key? key}) : super(key: key);

  final VoidCallback? statusOnTap;
  final StudyEntity entity;

  @override
  State<FirstItem> createState() => _FirstItemState();
}

class _FirstItemState extends State<FirstItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: <Widget>[
        Divider(
          height: 15,
          color: Colors.grey.withOpacity(0.3),
        ),
        <Widget>[
          Expanded(
              child: <Widget>[
            Text(
              taskTypes[widget.entity.type],
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  decoration: widget.entity.isDone == 1
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: widget.entity.isDone == 1
                      ? Colors.grey : null),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.entity.title,
              style: TextStyle(
                  fontSize: 14,
                  color: widget.entity.isDone == 1 ? Colors.grey : Colors.black,
                  decoration: widget.entity.isDone == 1
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: widget.entity.isDone == 1
                      ? Colors.grey : null),
              overflow: TextOverflow.ellipsis,
            ),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
          const SizedBox(width: 8,),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                taskFinishTitles[widget.entity.isDone],
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ).decorated(
                color: widget.entity.isDone == 1 ? primaryColor : Colors.grey.withOpacity(0.6), borderRadius: BorderRadius.circular(8)),
            onTap: () {
              widget.statusOnTap!();
            },
          )
        ].toRow()
      ].toColumn(),
    );
  }
}
