import 'package:flutter/foundation.dart';

import '../../../data/repositories/property_repository.dart';
import '../../../domain/models/property.dart';

class PropertyDetailViewModel extends ChangeNotifier {
  final PropertyRepository _repository;

  PropertyDetailViewModel(this._repository);

  Property? _property;
  bool _isLoading = false;
  bool _isBookmarked = false;

  Property? get property => _property;
  bool get isLoading => _isLoading;
  bool get isBookmarked => _isBookmarked;

  Future<void> loadProperty(String id) async {
    _isLoading = true;
    notifyListeners();

    _property = await _repository.getPropertyById(id);

    _isLoading = false;
    notifyListeners();
  }

  void toggleBookmark() {
    _isBookmarked = !_isBookmarked;
    notifyListeners();
  }
}
