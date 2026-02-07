import 'package:flutter/foundation.dart';

import '../../../data/repositories/property_repository.dart';
import '../../../domain/models/property.dart';

class HomeViewModel extends ChangeNotifier {
  final PropertyRepository _repository;

  HomeViewModel(this._repository) {
    loadProperties();
  }

  List<Property> _properties = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _hasError = false;
  PropertyType? _activeFilter;
  int _currentPage = 0;
  static const int _pageSize = 10;

  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;
  bool get hasError => _hasError;
  PropertyType? get activeFilter => _activeFilter;

  Future<void> loadProperties() async {
    _isLoading = true;
    _hasError = false;
    _currentPage = 0;
    notifyListeners();

    try {
      if (_activeFilter != null) {
        _properties = await _repository.getFilteredProperties(
          PropertyFilter(type: _activeFilter),
        );
        _hasMore = false;
      } else {
        _properties = await _repository.getProperties(
          page: 0,
          pageSize: _pageSize,
        );
        _hasMore = _properties.length >= _pageSize;
      }
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || _activeFilter != null) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      _currentPage++;
      final newProperties = await _repository.getProperties(
        page: _currentPage,
        pageSize: _pageSize,
      );
      _properties = [..._properties, ...newProperties];
      _hasMore = newProperties.length >= _pageSize;
    } catch (e) {
      _currentPage--;
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> applyFilter(PropertyType? type) async {
    if (_activeFilter == type) return;
    _activeFilter = type;
    await loadProperties();
  }

  Future<void> refresh() async {
    await loadProperties();
  }
}
