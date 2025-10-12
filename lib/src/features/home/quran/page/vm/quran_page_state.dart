import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

sealed class QuranPageState extends Equatable {
  final PartitionMode partitionMode;
  final int partitionId;
  final List<int> currentPartitionPages;
  final int totalPartitions;
  final Map<int, PageContentDto> pages;
  final int initialPageIndex;
  final Set<int> loadingPages;

  const QuranPageState({
    required this.partitionMode,
    required this.partitionId,
    required this.currentPartitionPages,
    required this.totalPartitions,
    required this.pages,
    required this.initialPageIndex,
    required this.loadingPages,
  });
  QuranPageState copyWith({
    PartitionMode? partitionMode,
    int? partitionId,
    List<int>? currentPartitionPages,
    int? totalPartitions,
    Map<int, PageContentDto>? pages,
    int? initialPageIndex,
    Set<int>? loadingPages,
  });

  @override
  List<Object?> get props => [
    partitionMode,
    partitionId,
    currentPartitionPages,
    pages,
    loadingPages,
    totalPartitions,
  ];
}

// initial
class QuranPageInitial extends QuranPageState {
  const QuranPageInitial()
    : super(
        partitionMode: PartitionMode.surah,
        partitionId: 1,
        totalPartitions: 114,
        currentPartitionPages: const [],
        pages: const {},
        initialPageIndex: 0,
        loadingPages: const {},
      );

  @override
  QuranPageLoaded copyWith({
    PartitionMode? partitionMode,
    int? partitionId,
    List<int>? currentPartitionPages,
    Map<int, PageContentDto>? pages,
    int? initialPageIndex,
    Set<int>? loadingPages,
    int? totalPartitions,
  }) {
    return QuranPageLoaded(
      partitionMode: partitionMode ?? this.partitionMode,
      partitionId: partitionId ?? this.partitionId,
      currentPartitionPages:
          currentPartitionPages ?? this.currentPartitionPages,
      totalPartitions: totalPartitions ?? this.totalPartitions,
      pages: pages ?? this.pages,
      initialPageIndex: initialPageIndex ?? this.initialPageIndex,
      loadingPages: loadingPages ?? this.loadingPages,
    );
  }
}

// loaded / normal state
class QuranPageLoaded extends QuranPageState {
  const QuranPageLoaded({
    required super.partitionMode,
    required super.partitionId,
    required super.currentPartitionPages,
    required super.totalPartitions,
    required super.pages,
    required super.initialPageIndex,
    required super.loadingPages,
  });

  @override
  QuranPageLoaded copyWith({
    PartitionMode? partitionMode,
    int? partitionId,
    List<int>? currentPartitionPages,
    Map<int, PageContentDto>? pages,
    int? initialPageIndex,
    Set<int>? loadingPages,
    int? totalPartitions,
    PageController? pageController,
    ItemScrollController? verticalController,
  }) {
    return QuranPageLoaded(
      partitionMode: partitionMode ?? this.partitionMode,
      partitionId: partitionId ?? this.partitionId,
      currentPartitionPages:
          currentPartitionPages ?? this.currentPartitionPages,
      totalPartitions: totalPartitions ?? this.totalPartitions,
      pages: pages ?? this.pages,
      initialPageIndex: initialPageIndex ?? this.initialPageIndex,
      loadingPages: loadingPages ?? this.loadingPages,
    );
  }
}
