import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grad_new_project/core/utils/router/AppColors.dart';
import '../widget/message_card.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../api/FirebaseServices.dart';

import '../auth/view_profile_screen.dart';
import '../helper/my_date_util.dart';
import '../../main.dart';
import '../model/chat_user.dart';
import '../model/message.dart';

import 'package:flutter/foundation.dart' as foundation;

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  List<Message> _list = [];
  //for handling message text changes
  final _textController = TextEditingController();

  //showEmoji -- for storing value of showing or hiding emoji
  //isUploading -- for checking if image is uploading or not?
  bool _showEmoji = false, _isUploading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          //if emojis are shown & back button is pressed then hide emojis
          //or else simple close current screen on back button click
          onWillPop: () {
            if (_showEmoji) {
              setState(() => _showEmoji = !_showEmoji);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            bool isDesktop = constraints.maxWidth > 900;
            return Scaffold(
              //app bar
              appBar: AppBar(
                shadowColor: AppColors.orange,
                surfaceTintColor: AppColors.white,
                foregroundColor: AppColors.brown,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10))),
                /*actions: [
                    IconButton(
                        onPressed: () {
                          final time = DateTime.now();
                          // final date =
                          //     DateTime.fromMillisecondsSinceEpoch(int.parse(time));
                          print(TimeOfDay.fromDateTime(time).format(context));
                        },
                        icon: Icon(
                          Icons.telegram,
                          color: Colors.black,
                        ))
                  ],*/
                // elevation: 0.65,
                // brightness: Brightness.light,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: _appBar(),
              ),

              backgroundColor: AppColors.white,
              // backgroundColor: const Color.fromARGB(255, 255, 255, 255),

              //body
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        // stream: FirebaseFirestore.instance.collection('users').snapshots(),
                        stream: APIs.getAllMessages(widget.user),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            // if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            // if some or all data is loadde then show it
                            case ConnectionState.active:
                            case ConnectionState.done:

                              // if (snapshot.hasData) {
                              final data = snapshot.data!.docs;
                              // log('data : ${data[0].data()}');

                              _list = data
                                  .map((e) => Message.fromJson(e.data()))
                                  .toList();
                              // final _list = ['hii', 'hello'];
                              if (_list.isNotEmpty) {
                                return ListView.builder(
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    return MessageCard(message: _list[index]);
                                  },
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.02),
                                  itemCount: _list.length,
                                  physics: const BouncingScrollPhysics(),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    'Say Hii! 👋',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              }
                          }
                        },
                      ),
                    ),
                    // progress indicator for showing uploading
                    if (_isUploading)
                      const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child:
                                  CircularProgressIndicator(strokeWidth: 2))),
                    _chatInput(isDesktop),

                    //show emojis on keyboard emoji button click & vice versa
                    if (_showEmoji)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .35,
                        child: EmojiPicker(
                          textEditingController: _textController,
                          config: Config(
                            height: 256,
                            checkPlatformCompatibility: true,
                            emojiViewConfig: EmojiViewConfig(
                              columns: 10,
                              backgroundColor: AppColors.white,

                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 28 *
                                  (foundation.defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                      ? 1.20
                                      : 1.0),
                            ),
                            swapCategoryAndBottomBar: false,
                            skinToneConfig: const SkinToneConfig(
                                enabled: true,
                                dialogBackgroundColor: AppColors.lightPurple),
                            categoryViewConfig: const CategoryViewConfig(
                                indicatorColor: AppColors.primary,
                                iconColor: AppColors.lightPurple2,
                                iconColorSelected: AppColors.primary,
                                backspaceColor: AppColors.primary,
                                backgroundColor: AppColors.lightPurple),
                            bottomActionBarConfig: const BottomActionBarConfig(
                                backgroundColor: AppColors.primary,
                                buttonColor: AppColors.primary),
                            searchViewConfig: const SearchViewConfig(),
                          ),
                        ),
                      )

                    //chat input filed
                    // _chatInput(),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // app bar widget
  Widget _appBar() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ViewProfileScreen(user: widget.user)));
        },
        child: StreamBuilder(
            stream: APIs.getUserInfo(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              return Row(
                children: [
                  //back button
                  IconButton(
                      // onPressed: () => null,
                      onPressed: () => Navigator.pop(context),
                      icon:
                          const Icon(Icons.arrow_back, color: AppColors.brown)),

                  //user profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * .03),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.height * .05,
                      height: MediaQuery.of(context).size.height * .05,
                      imageUrl:
                          list.isNotEmpty ? list[0].image : widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),

                  //for adding some space
                  const SizedBox(width: 10),

                  //user name & last seen time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text(widget.user.name,
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.brown,
                              fontWeight: FontWeight.w500)),

                      //for adding some space
                      const SizedBox(height: 2),

                      //last seen time of user
                      Text(
                          list.isNotEmpty
                              ? list[0].isOnline
                                  ? 'Online'
                                  : MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive: list[0].lastActive)
                              : MyDateUtil.getLastActiveTime(
                                  context: context,
                                  lastActive: widget.user.lastActive),
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.brown)),
                    ],
                  )
                ],
              );
            }));
  }

  // bottom chat input field
  Widget _chatInput(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .01,
          horizontal: MediaQuery.of(context).size.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: AppColors.primary, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: AppColors.primary),
                        border: InputBorder.none),
                  )),

                  //pick image from gallery button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var i in images) {
                          log('Image Path: ${i.path}');
                          setState(() => _isUploading = true);
                          log('hi');
                          await APIs.sendChatImage(widget.user, File(i.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.image,
                          color: AppColors.primary, size: 26)),

                  //take image from camera button
                  if (!isDesktop)
                    IconButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 70);
                          if (image != null) {
                            log('Image Path: ${image.path}');
                            setState(() => _isUploading = true);

                            await APIs.sendChatImage(
                                widget.user, File(image.path));
                            setState(() => _isUploading = false);
                          }
                        },
                        icon: const Icon(Icons.camera_alt_rounded,
                            color: AppColors.primary, size: 26)),

                  //adding some space
                  SizedBox(width: MediaQuery.of(context).size.width * .02),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                APIs.sendMessage(widget.user, _textController.text, Type.text);
                // if (_list.isEmpty) {
                //   //on first message (add user to my_user collection of chat user)
                //   APIs.sendFirstMessage(
                //       widget.user, _textController.text, Type.text);
                // } else {
                //   //simply send message
                //   APIs.sendMessage(
                //       widget.user, _textController.text, Type.text);
                // }
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: AppColors.primary,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}
