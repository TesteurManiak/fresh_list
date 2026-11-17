// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_connections.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NearbySharingState {

 bool get isAdvertising; bool get isDiscovering; IMap<String, Peer> get peers;/// Last list received from a peer, waiting for the user to accept it.
 ReceivedList? get receivedList;
/// Create a copy of NearbySharingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbySharingStateCopyWith<NearbySharingState> get copyWith => _$NearbySharingStateCopyWithImpl<NearbySharingState>(this as NearbySharingState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NearbySharingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbySharingState&&(identical(other.isAdvertising, _this.isAdvertising) || other.isAdvertising == _this.isAdvertising)&&(identical(other.isDiscovering, _this.isDiscovering) || other.isDiscovering == _this.isDiscovering)&&(identical(other.peers, _this.peers) || other.peers == _this.peers)&&(identical(other.receivedList, _this.receivedList) || other.receivedList == _this.receivedList));
}


@override
int get hashCode {
  final _this = this as NearbySharingState;
  return Object.hash(runtimeType,_this.isAdvertising,_this.isDiscovering,_this.peers,_this.receivedList);
}

@override
String toString() {
  final _this = this as NearbySharingState;
  return 'NearbySharingState(isAdvertising: ${_this.isAdvertising}, isDiscovering: ${_this.isDiscovering}, peers: ${_this.peers}, receivedList: ${_this.receivedList})';
}


}

/// @nodoc
abstract mixin class $NearbySharingStateCopyWith<$Res>  {
  factory $NearbySharingStateCopyWith(NearbySharingState value, $Res Function(NearbySharingState) _then) = _$NearbySharingStateCopyWithImpl;
@useResult
$Res call({
 bool isAdvertising, bool isDiscovering, IMap<String, Peer> peers, ReceivedList? receivedList
});




}
/// @nodoc
class _$NearbySharingStateCopyWithImpl<$Res>
    implements $NearbySharingStateCopyWith<$Res> {
  _$NearbySharingStateCopyWithImpl(this._self, this._then);

  final NearbySharingState _self;
  final $Res Function(NearbySharingState) _then;

/// Create a copy of NearbySharingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAdvertising = null,Object? isDiscovering = null,Object? peers = null,Object? receivedList = freezed,}) {
  return _then(NearbySharingState(
isAdvertising: null == isAdvertising ? _self.isAdvertising : isAdvertising // ignore: cast_nullable_to_non_nullable
as bool,isDiscovering: null == isDiscovering ? _self.isDiscovering : isDiscovering // ignore: cast_nullable_to_non_nullable
as bool,peers: null == peers ? _self.peers : peers // ignore: cast_nullable_to_non_nullable
as IMap<String, Peer>,receivedList: freezed == receivedList ? _self.receivedList : receivedList // ignore: cast_nullable_to_non_nullable
as ReceivedList?,
  ));
}

}



/// @nodoc


class _NearbySharingState implements NearbySharingState {
  const _NearbySharingState({this.isAdvertising = false, this.isDiscovering = false, this.peers = const IMap<String, Peer>.empty(), this.receivedList});
  

@override@JsonKey() final  bool isAdvertising;
@override@JsonKey() final  bool isDiscovering;
@override@JsonKey() final  IMap<String, Peer> peers;
/// Last list received from a peer, waiting for the user to accept it.
@override final  ReceivedList? receivedList;

/// Create a copy of NearbySharingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbySharingStateCopyWith<_NearbySharingState> get copyWith => __$NearbySharingStateCopyWithImpl<_NearbySharingState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbySharingState&&(identical(other.isAdvertising, isAdvertising) || other.isAdvertising == isAdvertising)&&(identical(other.isDiscovering, isDiscovering) || other.isDiscovering == isDiscovering)&&(identical(other.peers, peers) || other.peers == peers)&&(identical(other.receivedList, receivedList) || other.receivedList == receivedList));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isAdvertising,isDiscovering,peers,receivedList);
}

@override
String toString() {
    return 'NearbySharingState(isAdvertising: $isAdvertising, isDiscovering: $isDiscovering, peers: $peers, receivedList: $receivedList)';
}


}

/// @nodoc
abstract mixin class _$NearbySharingStateCopyWith<$Res> implements $NearbySharingStateCopyWith<$Res> {
  factory _$NearbySharingStateCopyWith(_NearbySharingState value, $Res Function(_NearbySharingState) _then) = __$NearbySharingStateCopyWithImpl;
@override @useResult
$Res call({
 bool isAdvertising, bool isDiscovering, IMap<String, Peer> peers, ReceivedList? receivedList
});




}
/// @nodoc
class __$NearbySharingStateCopyWithImpl<$Res>
    implements _$NearbySharingStateCopyWith<$Res> {
  __$NearbySharingStateCopyWithImpl(this._self, this._then);

  final _NearbySharingState _self;
  final $Res Function(_NearbySharingState) _then;

/// Create a copy of NearbySharingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAdvertising = null,Object? isDiscovering = null,Object? peers = null,Object? receivedList = freezed,}) {
  return _then(_NearbySharingState(
isAdvertising: null == isAdvertising ? _self.isAdvertising : isAdvertising // ignore: cast_nullable_to_non_nullable
as bool,isDiscovering: null == isDiscovering ? _self.isDiscovering : isDiscovering // ignore: cast_nullable_to_non_nullable
as bool,peers: null == peers ? _self.peers : peers // ignore: cast_nullable_to_non_nullable
as IMap<String, Peer>,receivedList: freezed == receivedList ? _self.receivedList : receivedList // ignore: cast_nullable_to_non_nullable
as ReceivedList?,
  ));
}


}

/// @nodoc
mixin _$Peer {

 String get name; PeerState get state;
/// Create a copy of Peer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeerCopyWith<Peer> get copyWith => _$PeerCopyWithImpl<Peer>(this as Peer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Peer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Peer&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.state, _this.state) || other.state == _this.state));
}


@override
int get hashCode {
  final _this = this as Peer;
  return Object.hash(runtimeType,_this.name,_this.state);
}

@override
String toString() {
  final _this = this as Peer;
  return 'Peer(name: ${_this.name}, state: ${_this.state})';
}


}

/// @nodoc
abstract mixin class $PeerCopyWith<$Res>  {
  factory $PeerCopyWith(Peer value, $Res Function(Peer) _then) = _$PeerCopyWithImpl;
@useResult
$Res call({
 String name, PeerState state
});




}
/// @nodoc
class _$PeerCopyWithImpl<$Res>
    implements $PeerCopyWith<$Res> {
  _$PeerCopyWithImpl(this._self, this._then);

  final Peer _self;
  final $Res Function(Peer) _then;

/// Create a copy of Peer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? state = null,}) {
  return _then(Peer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as PeerState,
  ));
}

}



/// @nodoc


class _Peer implements Peer {
  const _Peer({required this.name, required this.state});
  

@override final  String name;
@override final  PeerState state;

/// Create a copy of Peer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeerCopyWith<_Peer> get copyWith => __$PeerCopyWithImpl<_Peer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Peer&&(identical(other.name, name) || other.name == name)&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,state);
}

@override
String toString() {
    return 'Peer(name: $name, state: $state)';
}


}

/// @nodoc
abstract mixin class _$PeerCopyWith<$Res> implements $PeerCopyWith<$Res> {
  factory _$PeerCopyWith(_Peer value, $Res Function(_Peer) _then) = __$PeerCopyWithImpl;
@override @useResult
$Res call({
 String name, PeerState state
});




}
/// @nodoc
class __$PeerCopyWithImpl<$Res>
    implements _$PeerCopyWith<$Res> {
  __$PeerCopyWithImpl(this._self, this._then);

  final _Peer _self;
  final $Res Function(_Peer) _then;

/// Create a copy of Peer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? state = null,}) {
  return _then(_Peer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as PeerState,
  ));
}


}

// dart format on
