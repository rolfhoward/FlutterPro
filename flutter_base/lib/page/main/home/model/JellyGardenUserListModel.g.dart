// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JellyGardenUserListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JellyGardenUserListModel _$JellyGardenUserListModelFromJson(
        Map<String, dynamic> json) =>
    JellyGardenUserListModel(
      json['endRow'] as int,
      json['firstPage'] as int,
      json['hasNextPage'] as bool,
      json['hasPreviousPage'] as bool,
      json['isFirstPage'] as bool,
      json['isLastPage'] as bool,
      json['lastPage'] as int,
      json['navigateFirstPage'] as int,
      json['navigateLastPage'] as int,
      json['navigatePages'] as int,
      json['nextPage'] as int,
      json['pageNum'] as int,
      json['pageSize'] as int,
      json['pages'] as int,
      json['prePage'] as int,
      json['size'] as int,
      json['startRow'] as int,
      json['total'] as int,
      (json['list'] as List<dynamic>?)
          ?.map((e) => JellyGardenUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JellyGardenUserListModelToJson(
        JellyGardenUserListModel instance) =>
    <String, dynamic>{
      'endRow': instance.endRow,
      'firstPage': instance.firstPage,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'isFirstPage': instance.isFirstPage,
      'isLastPage': instance.isLastPage,
      'lastPage': instance.lastPage,
      'navigateFirstPage': instance.navigateFirstPage,
      'navigateLastPage': instance.navigateLastPage,
      'navigatePages': instance.navigatePages,
      'nextPage': instance.nextPage,
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'pages': instance.pages,
      'prePage': instance.prePage,
      'size': instance.size,
      'startRow': instance.startRow,
      'total': instance.total,
      'list': instance.list,
    };

JellyGardenUserModel _$JellyGardenUserModelFromJson(
        Map<String, dynamic> json) =>
    JellyGardenUserModel(
      json['id'] as int?,
      json['nickName'] as String?,
      json['password'] as String?,
      (json['registerDate'] as num?)?.toDouble(),
      json['sex'] as int?,
      json['username'] as String?,
      json['photo'] as String?,
    );

Map<String, dynamic> _$JellyGardenUserModelToJson(
        JellyGardenUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'password': instance.password,
      'registerDate': instance.registerDate,
      'sex': instance.sex,
      'username': instance.username,
      'photo': instance.photo,
    };
