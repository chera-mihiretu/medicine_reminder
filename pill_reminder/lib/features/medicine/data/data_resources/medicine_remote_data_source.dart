abstract class MedicineRemoteDataSource {}

class MedicineRemoteDataSourceImpl implements MedicineRemoteDataSource {
  final Firebase medicineApiClient;

  MedicineRemoteDataSourceImpl({required this.medicineApiClient});
}
