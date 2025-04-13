// Mocks generated by Mockito 5.4.5 from annotations
// in pill_reminder/test/mock/mock_generator.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart'
    as _i12;
import 'package:flutter_local_notifications/src/initialization_settings.dart'
    as _i13;
import 'package:flutter_local_notifications/src/notification_details.dart'
    as _i15;
import 'package:flutter_local_notifications/src/platform_specifics/android/schedule_mode.dart'
    as _i17;
import 'package:flutter_local_notifications/src/types.dart' as _i18;
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart'
    as _i14;
import 'package:hive_flutter/hive_flutter.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i10;
import 'package:pill_reminder/cores/error/failure.dart' as _i7;
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart'
    as _i11;
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart'
    as _i3;
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart'
    as _i8;
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart'
    as _i5;
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart'
    as _i22;
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart'
    as _i20;
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart'
    as _i4;
import 'package:pill_reminder/features/notification/domain/usecases/show_full_screen_notification_usecase.dart'
    as _i21;
import 'package:pill_reminder/features/notification/domain/usecases/show_notification_usecase.dart'
    as _i19;
import 'package:timezone/timezone.dart' as _i16;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMedicineModel_1 extends _i1.SmartFake implements _i3.MedicineModel {
  _FakeMedicineModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNotificationRepository_2 extends _i1.SmartFake
    implements _i4.NotificationRepository {
  _FakeNotificationRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMedicineRepository_3 extends _i1.SmartFake
    implements _i5.MedicineRepository {
  _FakeMedicineRepository_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MedicineRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMedicineRepository extends _i1.Mock
    implements _i5.MedicineRepository {
  MockMedicineRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.MedicineEntity>>>
      getMedicines() => (super.noSuchMethod(
            Invocation.method(
              #getMedicines,
              [],
            ),
            returnValue: _i6.Future<
                    _i2.Either<_i7.Failure, List<_i8.MedicineEntity>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.MedicineEntity>>(
              this,
              Invocation.method(
                #getMedicines,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.MedicineEntity>>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.MedicineEntity>> getMedicine(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMedicine,
          [id],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i8.MedicineEntity>>.value(
                _FakeEither_0<_i7.Failure, _i8.MedicineEntity>(
          this,
          Invocation.method(
            #getMedicine,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.MedicineEntity>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> addMedicine(
          _i8.MedicineEntity? medicine) =>
      (super.noSuchMethod(
        Invocation.method(
          #addMedicine,
          [medicine],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #addMedicine,
            [medicine],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> updateMedicine(
          _i8.MedicineEntity? medicine) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateMedicine,
          [medicine],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #updateMedicine,
            [medicine],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> deleteMedicine(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteMedicine,
          [id],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #deleteMedicine,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);
}

/// A class which mocks [Box].
///
/// See the documentation for Mockito's code generation for more information.
class MockBox<E> extends _i1.Mock implements _i9.Box<E> {
  MockBox() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Iterable<E> get values => (super.noSuchMethod(
        Invocation.getter(#values),
        returnValue: <E>[],
      ) as Iterable<E>);

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  bool get isOpen => (super.noSuchMethod(
        Invocation.getter(#isOpen),
        returnValue: false,
      ) as bool);

  @override
  bool get lazy => (super.noSuchMethod(
        Invocation.getter(#lazy),
        returnValue: false,
      ) as bool);

  @override
  Iterable<dynamic> get keys => (super.noSuchMethod(
        Invocation.getter(#keys),
        returnValue: <dynamic>[],
      ) as Iterable<dynamic>);

  @override
  int get length => (super.noSuchMethod(
        Invocation.getter(#length),
        returnValue: 0,
      ) as int);

  @override
  bool get isEmpty => (super.noSuchMethod(
        Invocation.getter(#isEmpty),
        returnValue: false,
      ) as bool);

  @override
  bool get isNotEmpty => (super.noSuchMethod(
        Invocation.getter(#isNotEmpty),
        returnValue: false,
      ) as bool);

  @override
  Iterable<E> valuesBetween({
    dynamic startKey,
    dynamic endKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #valuesBetween,
          [],
          {
            #startKey: startKey,
            #endKey: endKey,
          },
        ),
        returnValue: <E>[],
      ) as Iterable<E>);

  @override
  E? getAt(int? index) => (super.noSuchMethod(Invocation.method(
        #getAt,
        [index],
      )) as E?);

  @override
  Map<dynamic, E> toMap() => (super.noSuchMethod(
        Invocation.method(
          #toMap,
          [],
        ),
        returnValue: <dynamic, E>{},
      ) as Map<dynamic, E>);

  @override
  dynamic keyAt(int? index) => super.noSuchMethod(Invocation.method(
        #keyAt,
        [index],
      ));

  @override
  _i6.Stream<_i9.BoxEvent> watch({dynamic key}) => (super.noSuchMethod(
        Invocation.method(
          #watch,
          [],
          {#key: key},
        ),
        returnValue: _i6.Stream<_i9.BoxEvent>.empty(),
      ) as _i6.Stream<_i9.BoxEvent>);

  @override
  bool containsKey(dynamic key) => (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [key],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<void> put(
    dynamic key,
    E? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            key,
            value,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> putAt(
    int? index,
    E? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #putAt,
          [
            index,
            value,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> putAll(Map<dynamic, E>? entries) => (super.noSuchMethod(
        Invocation.method(
          #putAll,
          [entries],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<int> add(E? value) => (super.noSuchMethod(
        Invocation.method(
          #add,
          [value],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i6.Future<Iterable<int>> addAll(Iterable<E>? values) => (super.noSuchMethod(
        Invocation.method(
          #addAll,
          [values],
        ),
        returnValue: _i6.Future<Iterable<int>>.value(<int>[]),
      ) as _i6.Future<Iterable<int>>);

  @override
  _i6.Future<void> delete(dynamic key) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [key],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> deleteAt(int? index) => (super.noSuchMethod(
        Invocation.method(
          #deleteAt,
          [index],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> deleteAll(Iterable<dynamic>? keys) => (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [keys],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> compact() => (super.noSuchMethod(
        Invocation.method(
          #compact,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<int> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i6.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> deleteFromDisk() => (super.noSuchMethod(
        Invocation.method(
          #deleteFromDisk,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> flush() => (super.noSuchMethod(
        Invocation.method(
          #flush,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [MedicineLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMedicineLocalDataSource extends _i1.Mock
    implements _i11.MedicineLocalDataSource {
  MockMedicineLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> updateMedicine(_i3.MedicineModel? medicine) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateMedicine,
          [medicine],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> addMedicine(_i3.MedicineModel? medicine) =>
      (super.noSuchMethod(
        Invocation.method(
          #addMedicine,
          [medicine],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<_i3.MedicineModel> getMedicine(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getMedicine,
          [id],
        ),
        returnValue: _i6.Future<_i3.MedicineModel>.value(_FakeMedicineModel_1(
          this,
          Invocation.method(
            #getMedicine,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.MedicineModel>);

  @override
  _i6.Future<List<_i3.MedicineModel>> getMedicines() => (super.noSuchMethod(
        Invocation.method(
          #getMedicines,
          [],
        ),
        returnValue:
            _i6.Future<List<_i3.MedicineModel>>.value(<_i3.MedicineModel>[]),
      ) as _i6.Future<List<_i3.MedicineModel>>);

  @override
  _i6.Future<bool> deleteMedicine(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteMedicine,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [FlutterLocalNotificationsPlugin].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterLocalNotificationsPlugin extends _i1.Mock
    implements _i12.FlutterLocalNotificationsPlugin {
  MockFlutterLocalNotificationsPlugin() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool?> initialize(
    _i13.InitializationSettings? initializationSettings, {
    _i14.DidReceiveNotificationResponseCallback?
        onDidReceiveNotificationResponse,
    _i14.DidReceiveBackgroundNotificationResponseCallback?
        onDidReceiveBackgroundNotificationResponse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #initialize,
          [initializationSettings],
          {
            #onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
            #onDidReceiveBackgroundNotificationResponse:
                onDidReceiveBackgroundNotificationResponse,
          },
        ),
        returnValue: _i6.Future<bool?>.value(),
      ) as _i6.Future<bool?>);

  @override
  _i6.Future<_i14.NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() => (super.noSuchMethod(
            Invocation.method(
              #getNotificationAppLaunchDetails,
              [],
            ),
            returnValue: _i6.Future<_i14.NotificationAppLaunchDetails?>.value(),
          ) as _i6.Future<_i14.NotificationAppLaunchDetails?>);

  @override
  _i6.Future<void> show(
    int? id,
    String? title,
    String? body,
    _i15.NotificationDetails? notificationDetails, {
    String? payload,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #show,
          [
            id,
            title,
            body,
            notificationDetails,
          ],
          {#payload: payload},
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> cancel(
    int? id, {
    String? tag,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [id],
          {#tag: tag},
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> cancelAll() => (super.noSuchMethod(
        Invocation.method(
          #cancelAll,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> zonedSchedule(
    int? id,
    String? title,
    String? body,
    _i16.TZDateTime? scheduledDate,
    _i15.NotificationDetails? notificationDetails, {
    required _i17.AndroidScheduleMode? androidScheduleMode,
    String? payload,
    _i18.DateTimeComponents? matchDateTimeComponents,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #zonedSchedule,
          [
            id,
            title,
            body,
            scheduledDate,
            notificationDetails,
          ],
          {
            #androidScheduleMode: androidScheduleMode,
            #payload: payload,
            #matchDateTimeComponents: matchDateTimeComponents,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> periodicallyShow(
    int? id,
    String? title,
    String? body,
    _i14.RepeatInterval? repeatInterval,
    _i15.NotificationDetails? notificationDetails, {
    required _i17.AndroidScheduleMode? androidScheduleMode,
    String? payload,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #periodicallyShow,
          [
            id,
            title,
            body,
            repeatInterval,
            notificationDetails,
          ],
          {
            #androidScheduleMode: androidScheduleMode,
            #payload: payload,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> periodicallyShowWithDuration(
    int? id,
    String? title,
    String? body,
    Duration? repeatDurationInterval,
    _i15.NotificationDetails? notificationDetails, {
    _i17.AndroidScheduleMode? androidScheduleMode =
        _i17.AndroidScheduleMode.exact,
    String? payload,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #periodicallyShowWithDuration,
          [
            id,
            title,
            body,
            repeatDurationInterval,
            notificationDetails,
          ],
          {
            #androidScheduleMode: androidScheduleMode,
            #payload: payload,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<List<_i14.PendingNotificationRequest>>
      pendingNotificationRequests() => (super.noSuchMethod(
            Invocation.method(
              #pendingNotificationRequests,
              [],
            ),
            returnValue:
                _i6.Future<List<_i14.PendingNotificationRequest>>.value(
                    <_i14.PendingNotificationRequest>[]),
          ) as _i6.Future<List<_i14.PendingNotificationRequest>>);

  @override
  _i6.Future<List<_i14.ActiveNotification>> getActiveNotifications() =>
      (super.noSuchMethod(
        Invocation.method(
          #getActiveNotifications,
          [],
        ),
        returnValue: _i6.Future<List<_i14.ActiveNotification>>.value(
            <_i14.ActiveNotification>[]),
      ) as _i6.Future<List<_i14.ActiveNotification>>);
}

/// A class which mocks [ShowNotificationUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockShowNotificationUsecase extends _i1.Mock
    implements _i19.ShowNotificationUsecase {
  MockShowNotificationUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.NotificationRepository get notificationRepository => (super.noSuchMethod(
        Invocation.getter(#notificationRepository),
        returnValue: _FakeNotificationRepository_2(
          this,
          Invocation.getter(#notificationRepository),
        ),
      ) as _i4.NotificationRepository);

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> execute(
          _i20.NotificationEntity? notification) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [notification],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [notification],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);
}

/// A class which mocks [ShowFullScreenNotificationUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockShowFullScreenNotificationUsecase extends _i1.Mock
    implements _i21.ShowFullScreenNotificationUsecase {
  MockShowFullScreenNotificationUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.NotificationRepository get notificationRepository => (super.noSuchMethod(
        Invocation.getter(#notificationRepository),
        returnValue: _FakeNotificationRepository_2(
          this,
          Invocation.getter(#notificationRepository),
        ),
      ) as _i4.NotificationRepository);

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> execute(
          _i20.NotificationEntity? notification) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [notification],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [notification],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);
}

/// A class which mocks [GetAllMedicineUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllMedicineUsecase extends _i1.Mock
    implements _i22.GetAllMedicineUsecase {
  MockGetAllMedicineUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MedicineRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMedicineRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.MedicineRepository);

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.MedicineEntity>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i8.MedicineEntity>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.MedicineEntity>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.MedicineEntity>>>);
}

/// A class which mocks [NotificationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationRepository extends _i1.Mock
    implements _i4.NotificationRepository {
  MockNotificationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, bool>> showNotification(
          _i20.NotificationEntity? notification) =>
      (super.noSuchMethod(
        Invocation.method(
          #showNotification,
          [notification],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, bool>>.value(
            _FakeEither_0<_i7.Failure, bool>(
          this,
          Invocation.method(
            #showNotification,
            [notification],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, bool>>);
}
