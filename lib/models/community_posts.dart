class File {
  final String fileLoc;
  final String originalName;
  final String extname;
  final String type;
  final int size;

  File({
    required this.fileLoc,
    required this.originalName,
    required this.extname,
    required this.type,
    required this.size,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      fileLoc: json['fileLoc'],
      originalName: json['originalName'],
      extname: json['extname'],
      type: json['type'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileLoc': fileLoc,
      'originalName': originalName,
      'extname': extname,
      'type': type,
      'size': size,
    };
  }
}

class User {
  final int id;
  final String fullName;
  final String profilePic;
  final int isPrivateChat;
  final String? expireDate;
  final String? status;
  final String? pauseDate;
  final String userType;
  final Map<String, dynamic> meta;

  User({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.isPrivateChat,
    this.expireDate,
    this.status,
    this.pauseDate,
    required this.userType,
    required this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      isPrivateChat: json['is_private_chat'],
      expireDate: json['expire_date'],
      status: json['status'],
      pauseDate: json['pause_date'],
      userType: json['user_type'],
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'is_private_chat': isPrivateChat,
      'expire_date': expireDate,
      'status': status,
      'pause_date': pauseDate,
      'user_type': userType,
      'meta': meta,
    };
  }
}

class LikeType {
  final String reactionType;
  final int feedId;
  final Map<String, dynamic> meta;

  LikeType({
    required this.reactionType,
    required this.feedId,
    required this.meta,
  });

  factory LikeType.fromJson(Map<String, dynamic> json) {
    return LikeType(
      reactionType: json['reaction_type'],
      feedId: json['feed_id'],
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reaction_type': reactionType,
      'feed_id': feedId,
      'meta': meta,
    };
  }
}

class Post {
  final int? id;
  final int? schoolId;
  final int? userId;
  final int? courseId;
  final int? communityId;
  final int? groupId;
  final String? feedTxt;
  final String? status;
  final String? slug;
  final String? title;
  final String? activityType;
  final int? isPinned;
  final String? fileType;
  final List<File>? files;
  final int? likeCount;
  final int? commentCount;
  final int? shareCount;
  final int? shareId;
  final Map<String, dynamic>? metaData;
  final String? createdAt;
  final String? updatedAt;
  final String? feedPrivacy;
  final int? isBackground;
  final String? bgColor;
  final String? pollId;
  final String? lessonId;
  final int? spaceId;
  final String? videoId;
  final String? streamId;
  final String? blogId;
  final String? scheduleDate;
  final String? timezone;
  final int? isAnonymous;
  final String? meetingId;
  final String? sellerId;
  final String? publishDate;
  final bool? isFeedEdit;
  final String? name;
  final String? pic;
  final int? uid;
  final int? isPrivateChat;
  final dynamic group;
  final dynamic poll;
  final dynamic like;
  final dynamic follow;
  final dynamic savedPosts;
  final List<dynamic>? comments;
  final Map<String, dynamic>? meta;
  final User? user;
  final List<LikeType>? likeType; // New field

  Post({
    required this.id,
    required this.schoolId,
    required this.userId,
    this.courseId,
    required this.communityId,
    this.groupId,
    required this.feedTxt,
    required this.status,
    required this.slug,
    required this.title,
    required this.activityType,
    required this.isPinned,
    required this.fileType,
    required this.files,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.shareId,
    required this.metaData,
    required this.createdAt,
    required this.updatedAt,
    required this.feedPrivacy,
    required this.isBackground,
    this.bgColor,
    this.pollId,
    this.lessonId,
    required this.spaceId,
    this.videoId,
    this.streamId,
    this.blogId,
    this.scheduleDate,
    required this.timezone,
    required this.isAnonymous,
    this.meetingId,
    this.sellerId,
    required this.publishDate,
    required this.isFeedEdit,
    required this.name,
    required this.pic,
    required this.uid,
    required this.isPrivateChat,
    this.group,
    this.poll,
    this.like,
    this.follow,
    this.savedPosts,
    required this.comments,
    required this.meta,
    required this.user,
    this.likeType, // Initialize as optional
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      schoolId: json['school_id'],
      userId: json['user_id'],
      courseId: json['course_id'],
      communityId: json['community_id'],
      groupId: json['group_id'],
      feedTxt: json['feed_txt'],
      status: json['status'],
      slug: json['slug'],
      title: json['title'],
      activityType: json['activity_type'],
      isPinned: json['is_pinned'],
      fileType: json['file_type'],
      files: (json['files'] as List?)
          ?.map((fileJson) => File.fromJson(fileJson))
          .toList(),
      likeCount: json['like_count'],
      commentCount: json['comment_count'],
      shareCount: json['share_count'],
      shareId: json['share_id'],
      metaData: json['meta_data'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      feedPrivacy: json['feed_privacy'],
      isBackground: json['is_background'],
      bgColor: json['bg_color'],
      pollId: json['poll_id'],
      lessonId: json['lesson_id'],
      spaceId: json['space_id'],
      videoId: json['video_id'],
      streamId: json['stream_id'],
      blogId: json['blog_id'],
      scheduleDate: json['schedule_date'],
      timezone: json['timezone'],
      isAnonymous: json['is_anonymous'],
      meetingId: json['meeting_id'],
      sellerId: json['seller_id'],
      publishDate: json['publish_date'],
      isFeedEdit: json['is_feed_edit'],
      name: json['name'],
      pic: json['pic'],
      uid: json['uid'],
      isPrivateChat: json['is_private_chat'],
      group: json['group'],
      poll: json['poll'],
      like: json['like'],
      follow: json['follow'],
      savedPosts: json['savedPosts'],
      comments: List.from(json['comments']),
      meta: json['meta'],
      user: User.fromJson(json['user']),
      likeType: (json['likeType'] as List?)
          ?.map((likeJson) => LikeType.fromJson(likeJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'user_id': userId,
      'course_id': courseId,
      'community_id': communityId,
      'group_id': groupId,
      'feed_txt': feedTxt,
      'status': status,
      'slug': slug,
      'title': title,
      'activity_type': activityType,
      'is_pinned': isPinned,
      'file_type': fileType,
      'files': (files ?? []).map((file) => file.toJson()).toList(),
      'like_count': likeCount,
      'comment_count': commentCount,
      'share_count': shareCount,
      'share_id': shareId,
      'meta_data': metaData,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'feed_privacy': feedPrivacy,
      'is_background': isBackground,
      'bg_color': bgColor,
      'poll_id': pollId,
      'lesson_id': lessonId,
      'space_id': spaceId,
      'video_id': videoId,
      'stream_id': streamId,
      'blog_id': blogId,
      'schedule_date': scheduleDate,
      'timezone': timezone,
      'is_anonymous': isAnonymous,
      'meeting_id': meetingId,
      'seller_id': sellerId,
      'publish_date': publishDate,
      'is_feed_edit': isFeedEdit,
      'name': name,
      'pic': pic,
      'uid': uid,
      'is_private_chat': isPrivateChat,
      'group': group,
      'poll': poll,
      'like': like,
      'follow': follow,
      'savedPosts': savedPosts,
      'comments': comments,
      'meta': meta,
      'user': user?.toJson(),
      'likeType': likeType?.map((like) => like.toJson()).toList(),
    };
  }
}
