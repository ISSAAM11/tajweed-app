import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

sealed class QuranPageState extends Equatable {
  final String surahName;
  final String surahNameSimple;
  final PartitionMode partitionMode;
  final int partitionId;
  final int currentPage;
  final int totalPartitions;
  final PageContentDto? page;
  final int initialPageIndex;
  final Set<int> loadingPages;

  const QuranPageState({
    required this.surahName,
    required this.surahNameSimple,
    required this.partitionMode,
    required this.partitionId,
    required this.currentPage,
    required this.totalPartitions,
    required this.page,
    required this.initialPageIndex,
    required this.loadingPages,
  });
  QuranPageState copyWith({
    String? surahName,
    String? surahNameSimple,
    PartitionMode? partitionMode,
    int? partitionId,
    int? currentPage,
    int? totalPartitions,
    PageContentDto? page,
    int? initialPageIndex,
    Set<int>? loadingPages,
  });

  @override
  List<Object?> get props => [
    surahName,
    surahNameSimple,
    partitionMode,
    partitionId,
    currentPage,
    page,
    loadingPages,
    totalPartitions,
  ];
}

// initial
class QuranPageInitial extends QuranPageState {
  const QuranPageInitial()
    : super(
        surahName: '',
        surahNameSimple: '',
        partitionMode: PartitionMode.surah,
        partitionId: 1,
        totalPartitions: 114,
        currentPage: 0,
        page: null,
        initialPageIndex: 0,
        loadingPages: const {},
      );

  @override
  QuranPageLoaded copyWith({
    String? surahName,
    String? surahNameSimple,
    PartitionMode? partitionMode,
    int? partitionId,
    int? currentPage,
    PageContentDto? page,
    int? initialPageIndex,
    Set<int>? loadingPages,
    int? totalPartitions,
  }) {
    return QuranPageLoaded(
      surahName: surahName ?? this.surahName,
      surahNameSimple: surahNameSimple ?? this.surahNameSimple,
      partitionMode: partitionMode ?? this.partitionMode,
      partitionId: partitionId ?? this.partitionId,
      currentPage: currentPage ?? this.currentPage,
      totalPartitions: totalPartitions ?? this.totalPartitions,
      page: page ?? this.page,
      initialPageIndex: initialPageIndex ?? this.initialPageIndex,
      loadingPages: loadingPages ?? this.loadingPages,
    );
  }
}

// loaded / normal state
class QuranPageLoaded extends QuranPageState {
  const QuranPageLoaded({
    required super.surahName,
    required super.surahNameSimple,
    required super.partitionMode,
    required super.partitionId,
    required super.currentPage,
    required super.totalPartitions,
    required super.page,
    required super.initialPageIndex,
    required super.loadingPages,
  });

  @override
  QuranPageLoaded copyWith({
    String? surahName,
    String? surahNameSimple,
    PartitionMode? partitionMode,
    int? partitionId,
    int? currentPage,
    PageContentDto? page,
    int? initialPageIndex,
    Set<int>? loadingPages,
    int? totalPartitions,
    PageController? pageController,
    ItemScrollController? verticalController,
  }) {
    return QuranPageLoaded(
      surahName: surahName ?? this.surahName,
      surahNameSimple: surahNameSimple ?? this.surahNameSimple,
      partitionMode: partitionMode ?? this.partitionMode,
      partitionId: partitionId ?? this.partitionId,
      currentPage: currentPage ?? this.currentPage,
      totalPartitions: totalPartitions ?? this.totalPartitions,
      page: page ?? this.page,
      initialPageIndex: initialPageIndex ?? this.initialPageIndex,
      loadingPages: loadingPages ?? this.loadingPages,
    );
  }
}
