import 'package:agripure_mobile/agripure/farmer/domain/entity/farmer.dart';

abstract class FarmerInterface {
  Future<List<Farmer>> fetchProducts();
  Future<Farmer> getProduct(String id);
}
