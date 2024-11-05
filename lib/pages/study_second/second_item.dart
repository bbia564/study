import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_work/db_study_work/study_entity.dart';
import 'package:study_work/main.dart';
import 'package:styled_widget/styled_widget.dart';

class SecondItem extends StatefulWidget {
  const SecondItem(this.entity,{this.statusOnTap,Key? key}) : super(key: key);

  final StudyEntity entity;
  final VoidCallback? statusOnTap;

  @override
  State<SecondItem> createState() => _FirstItemState();
}

class _FirstItemState extends State<SecondItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(12),
      child: <Widget>[
        <Widget>[
          Image.asset('assets/${widget.entity.isDone == 1 ? 'hadFinish' : 'notHadFinish'}.webp',width: 13,height: 13,),
          const SizedBox(width: 5,),
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
    ).decorated(color: Colors.white,borderRadius: BorderRadius.circular(10)).marginOnly(bottom: 10);
  }
}
