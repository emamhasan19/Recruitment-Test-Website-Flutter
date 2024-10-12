import 'package:equatable/equatable.dart';

enum BaseStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == BaseStatus.loading;
  bool get isSuccess => this == BaseStatus.success;
  bool get isFailure => this == BaseStatus.failure;
}

class BaseState<T> extends Equatable {
  const BaseState({
    this.status = BaseStatus.initial,
    this.data,
    this.error,
  });

  final BaseStatus status;
  final T? data;
  final String? error;

  BaseState copyWith({
    BaseStatus? status,
    T? data,
    String? error,
  }) {
    return BaseState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
