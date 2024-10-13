
enum SubmissionStatus {
  initial,
  loading,
  success,
  timeoutError,
  error;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isTimeoutError => this == timeoutError;
  bool get isError => this == error;
}
