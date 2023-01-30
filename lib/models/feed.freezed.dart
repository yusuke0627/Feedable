// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Feed {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  DateTime get publishedDate => throw _privateConstructorUsedError;
  String get blogName => throw _privateConstructorUsedError;
  bool get bookmarked => throw _privateConstructorUsedError;
  bool get alreadyRead => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedCopyWith<Feed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCopyWith<$Res> {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) then) =
      _$FeedCopyWithImpl<$Res, Feed>;
  @useResult
  $Res call(
      {String title,
      String url,
      DateTime publishedDate,
      String blogName,
      bool bookmarked,
      bool alreadyRead});
}

/// @nodoc
class _$FeedCopyWithImpl<$Res, $Val extends Feed>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? publishedDate = null,
    Object? blogName = null,
    Object? bookmarked = null,
    Object? alreadyRead = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      publishedDate: null == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      blogName: null == blogName
          ? _value.blogName
          : blogName // ignore: cast_nullable_to_non_nullable
              as String,
      bookmarked: null == bookmarked
          ? _value.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      alreadyRead: null == alreadyRead
          ? _value.alreadyRead
          : alreadyRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FeedCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$$_FeedCopyWith(_$_Feed value, $Res Function(_$_Feed) then) =
      __$$_FeedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String url,
      DateTime publishedDate,
      String blogName,
      bool bookmarked,
      bool alreadyRead});
}

/// @nodoc
class __$$_FeedCopyWithImpl<$Res> extends _$FeedCopyWithImpl<$Res, _$_Feed>
    implements _$$_FeedCopyWith<$Res> {
  __$$_FeedCopyWithImpl(_$_Feed _value, $Res Function(_$_Feed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? publishedDate = null,
    Object? blogName = null,
    Object? bookmarked = null,
    Object? alreadyRead = null,
  }) {
    return _then(_$_Feed(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      null == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == blogName
          ? _value.blogName
          : blogName // ignore: cast_nullable_to_non_nullable
              as String,
      null == bookmarked
          ? _value.bookmarked
          : bookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      null == alreadyRead
          ? _value.alreadyRead
          : alreadyRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Feed implements _Feed {
  const _$_Feed(this.title, this.url, this.publishedDate, this.blogName,
      this.bookmarked, this.alreadyRead);

  @override
  final String title;
  @override
  final String url;
  @override
  final DateTime publishedDate;
  @override
  final String blogName;
  @override
  final bool bookmarked;
  @override
  final bool alreadyRead;

  @override
  String toString() {
    return 'Feed(title: $title, url: $url, publishedDate: $publishedDate, blogName: $blogName, bookmarked: $bookmarked, alreadyRead: $alreadyRead)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeedCopyWith<_$_Feed> get copyWith =>
      __$$_FeedCopyWithImpl<_$_Feed>(this, _$identity);
}

abstract class _Feed implements Feed {
  const factory _Feed(
      final String title,
      final String url,
      final DateTime publishedDate,
      final String blogName,
      final bool bookmarked,
      final bool alreadyRead) = _$_Feed;

  @override
  String get title;
  @override
  String get url;
  @override
  DateTime get publishedDate;
  @override
  String get blogName;
  @override
  bool get bookmarked;
  @override
  bool get alreadyRead;
  @override
  @JsonKey(ignore: true)
  _$$_FeedCopyWith<_$_Feed> get copyWith => throw _privateConstructorUsedError;
}
