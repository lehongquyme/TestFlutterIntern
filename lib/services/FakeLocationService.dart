
import 'package:testflutterintern/services/provider/api_services.dart';
import '../models/address.dart';

class FakeLocationService extends ApiServices {
  @override
  Future<List<Address>> search(String query) async {
    return [
      Address(
        title: 'Fake Place',
        fullAddress: '123 Fake Street',
        lat: 10.0,
        lon: 106.0,
      ),
    ];
  }
}
