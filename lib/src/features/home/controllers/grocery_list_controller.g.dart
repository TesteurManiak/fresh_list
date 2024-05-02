// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchGroceriesHash() => r'867c32d0f9cf7f37e85b4d23bc7be1bae6381a0c';

/// See also [watchGroceries].
@ProviderFor(watchGroceries)
final watchGroceriesProvider =
    AutoDisposeStreamProvider<List<Grocery>>.internal(
  watchGroceries,
  name: r'watchGroceriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchGroceriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchGroceriesRef = AutoDisposeStreamProviderRef<List<Grocery>>;
String _$groceryListControllerHash() =>
    r'bb1c4761fd729c98404de7a67e5843cc84021019';

/// See also [GroceryListController].
@ProviderFor(GroceryListController)
final groceryListControllerProvider = AutoDisposeAsyncNotifierProvider<
    GroceryListController, List<Grocery>>.internal(
  GroceryListController.new,
  name: r'groceryListControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groceryListControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GroceryListController = AutoDisposeAsyncNotifier<List<Grocery>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
