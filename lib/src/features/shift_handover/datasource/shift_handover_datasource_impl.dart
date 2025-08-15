import '../../../base/datasource/exports.dart';
import '../data/enums/note_type.dart';
import '../data/models/shift_report_do.dart';

part 'mock/shift_handover_mock.dart';

abstract interface class ShiftHandoverDataSource {
  static const String endpoint = "shift-handover";

  /// Calls the shift handover API endpoints.
  FutureRequestResult<ShiftReportDO> getShiftReport(String caregiverId);
}

final class ShiftHandoverDataSourceImpl extends DataSource implements ShiftHandoverDataSource {
  ShiftHandoverDataSourceImpl({
    required super.client,
    required super.cacheManager,
    required super.connectivityMonitor,
  });

  final responseMock = ResponseMock.success;

  @override
  FutureRequestResult<ShiftReportDO> getShiftReport(String caregiverId) async =>
      switch (responseMock) {
        //! Failure
        ResponseMock.failure => Future.delayed(
          const Duration(milliseconds: 500),
          () => Left(Exception('Failure')),
        ),
        //$ No internet
        ResponseMock.noInternet => Future.delayed(
          const Duration(milliseconds: 500),
          () => Left(Exception('No internet connection')),
        ),
        //? No data
        ResponseMock.noData => Future.delayed(
          const Duration(milliseconds: 500),
          () => Right(ShiftReportDO.empty()),
        ),
        //+ Success
        ResponseMock.success => await performDecodingRequest(
          decodableModel: ShiftReportDO.empty(),
          method: RestfulMethods.get,
          path: "${ShiftHandoverDataSource.endpoint}/$caregiverId",
          mockingData: _mockShiftReport(notesCount: AppEnvironment.testing ? 1 : 5),
          mockIt: true,
          simulateFailure: false,
        ),
      };
}

enum ResponseMock { noInternet, noData, success, failure }
