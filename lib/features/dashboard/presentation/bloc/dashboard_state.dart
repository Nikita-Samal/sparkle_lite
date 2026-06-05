class DashboardState {
  final bool isLoading;
  final String error;

  DashboardState({
    this.isLoading = false,
    this.error = '',
  });

  DashboardState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}