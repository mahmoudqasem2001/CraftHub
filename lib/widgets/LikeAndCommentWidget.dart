// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grad_new_project/core/utils/router/AppColors.dart';
import 'package:grad_new_project/view_model/comment_cubit/comment_state.dart';
import 'package:grad_new_project/widgets/TextFiledContainer.dart';

import '../view_model/comment_cubit/comment_cubit.dart';
import '../view_model/like_cubit/like_cubit.dart';
import '../view_model/like_cubit/like_state.dart';

class LikeAndCommentWidget extends StatefulWidget {
  final int itemId;
  final int userId;
  final TextEditingController commentController;
  bool isLiked = false;
  LikeAndCommentWidget({
    Key? key,
    required this.itemId,
    required this.userId,
    required this.commentController,
  }) : super(key: key);

  @override
  _LikeAndCommentWidgetState createState() => _LikeAndCommentWidgetState();
}

class _LikeAndCommentWidgetState extends State<LikeAndCommentWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        BlocListener<CommentCubit, CommentState>(
          listener: (context, state) {
            if (state is CommentPostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Comment posted successfully!')),
              );
              // Clear the comment input field after posting
              widget.commentController.clear();
            } else if (state is CommentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Failed to post comment: ${state.message}')),
              );
            }
          },
          child: BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CommentListSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.comments[index].user.image),
                      ),
                      title: Text(state.comments[index].user.firstName +
                          ' ' +
                          state.comments[index].user.lastName),
                      subtitle: Text(state.comments[index].comment),
                    );
                  },
                );
              } else if (state is CommentFailure) {
                return Center(
                    child: Text('Failed to load comments: ${state.message}'));
              }
              return SizedBox.shrink();
            },
          ),
        ),
        BlocBuilder<LikeCubit, LikeState>(
          builder: (context, state) {
            int likeCount = 0;
            if (state is LikeListSuccess) {
              likeCount = state.likes.length;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 0, right: 6, bottom: 5),
                  child: Container(
                    width: size.width * 0.1,
                    height: size.width * 0.11,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/images/Person.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.65,
                  height: size.height * 0.052,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.lightPurple2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 15, right: 15),
                    child: TextField(
                      controller: widget.commentController,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: "Write a Comment",
                        border: InputBorder
                            .none, // Remove border for normal text appearance
                      ),
                      style: GoogleFonts.philosopher(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                              fontSize: 14)),
                      maxLines: null,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (widget.commentController.text.isNotEmpty) {
                      BlocProvider.of<CommentCubit>(context).postComment(
                        widget.itemId,
                        widget.userId,
                        widget.commentController.text,
                      );
                    }
                  },
                  icon: Icon(Icons.send_rounded),
                  color: AppColors.lightPurple2,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isLiked = !widget.isLiked;
                      if (widget.isLiked) {
                        BlocProvider.of<LikeCubit>(context)
                            .postLike(widget.itemId, widget.userId);
                      }
                    });
                  },
                  icon: Icon(widget.isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded),
                  color: widget.isLiked
                      ? AppColors.primary
                      : AppColors.lightPurple2,
                ),
                // Displaying like count
                Text('$likeCount',
                    style: TextStyle(color: AppColors.darkBrown)),
              ],
            );
          },
        ),
      ],
    );
  }
}
