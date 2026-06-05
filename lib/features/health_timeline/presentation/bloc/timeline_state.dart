class HealthTimelineState {
  final String selectedFilter;

  const HealthTimelineState({
    this.selectedFilter = "All",
  });

  HealthTimelineState copyWith({
    String? selectedFilter,
  }) {
    return HealthTimelineState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}