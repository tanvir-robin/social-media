class Comment {
  final int id;
  final int schoolId;
  final int feedId;
  final int userId;
  final int replyCount;
  final int likeCount;
  final String commentText;
  final int? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? file;
  final int? privateUserId;
  final bool isAuthorAndAnonymous;
  final String? gift;
  final int? sellerId;
  final int? giftedCoins;
  final List<Comment> replies;
  final User? privateUser;
  final User user;
  final List<dynamic> totalLikes;
  final List<dynamic> reactionTypes;
  final dynamic commentLike;
  List<Comment>? replieComments = [];
  bool showReplies = false;

  Comment({
    this.replieComments,
    required this.id,
    required this.schoolId,
    required this.feedId,
    required this.userId,
    required this.replyCount,
    required this.likeCount,
    required this.commentText,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
    this.file,
    this.privateUserId,
    required this.isAuthorAndAnonymous,
    this.gift,
    this.sellerId,
    this.giftedCoins,
    required this.replies,
    this.privateUser,
    required this.user,
    required this.totalLikes,
    required this.reactionTypes,
    this.commentLike,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      schoolId: json['school_id'],
      feedId: json['feed_id'],
      userId: json['user_id'],
      replyCount: json['reply_count'],
      likeCount: json['like_count'],
      commentText: json['comment_txt'],
      parentId: json['parrent_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      file: json['file'],
      privateUserId: json['private_user_id'],
      isAuthorAndAnonymous: json['is_author_and_anonymous'] == 1,
      gift: json['gift'],
      sellerId: json['seller_id'],
      giftedCoins: json['gifted_coins'],
      replies: (json['replies'] as List)
          .map((reply) => Comment.fromJson(reply))
          .toList(),
      privateUser: json['private_user'] != null
          ? User.fromJson(json['private_user'])
          : null,
      user: User.fromJson(json['user']),
      totalLikes: json['totalLikes'] ?? [],
      reactionTypes: json['reaction_types'] ?? [],
      commentLike: json['commentlike'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'feed_id': feedId,
      'user_id': userId,
      'reply_count': replyCount,
      'like_count': likeCount,
      'comment_txt': commentText,
      'parrent_id': parentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'file': file,
      'private_user_id': privateUserId,
      'is_author_and_anonymous': isAuthorAndAnonymous ? 1 : 0,
      'gift': gift,
      'seller_id': sellerId,
      'gifted_coins': giftedCoins,
      'replies': replies.map((reply) => reply.toJson()).toList(),
      'private_user': privateUser?.toJson(),
      'user': user.toJson(),
      'totalLikes': totalLikes,
      'reaction_types': reactionTypes,
      'commentlike': commentLike,
    };
  }
}

class User {
  final int id;
  final String fullName;
  final String profilePic;
  final String userType;
  final Map<String, dynamic> meta;

  User({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.userType,
    required this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      userType: json['user_type'],
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'user_type': userType,
      'meta': meta,
    };
  }
}
