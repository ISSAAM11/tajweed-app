import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/page_models.dart';

sealed class QuranPageState extends Equatable {
  final PartitionMode partitionMode;
  final int partitionId;
  final List<int> currentPartitionPages;
  final Map<int, PageContentDto> pages;
  final int verticalIndex;
  final Set<int> loadingPages;
  // Controllers
  final PageController pageController;
  final ItemScrollController verticalController;

  const QuranPageState({
    required this.partitionMode,
    required this.partitionId,
    required this.currentPartitionPages,
    required this.pages,
    required this.verticalIndex,
    required this.loadingPages,
    required this.pageController,
    required this.verticalController,
  });
  QuranPageState copyWith({
    PartitionMode? partitionMode,
    int? partitionId,
    List<int>? currentPartitionPages,
    Map<int, PageContentDto>? pages,
    int? verticalIndex,
    Set<int>? loadingPages,
    PageController? pageController,
    ItemScrollController? verticalController,
  });

  @override
  List<Object?> get props => [
    partitionMode,
    partitionId,
    currentPartitionPages,
    pages,
    verticalIndex,
    loadingPages,
  ];
}

// initial
class QuranPageInitial extends QuranPageState {
  QuranPageInitial()
    : super(
        partitionMode: PartitionMode.surah,
        partitionId: 1,
        currentPartitionPages: const [],
        pages: const {},
        verticalIndex: 0,
        loadingPages: const {},
        pageController: PageController(),
        verticalController: ItemScrollController(),
      );

  @override
  QuranPageLoaded copyWith({
    PartitionMode? partitionMode,
    int? partitionId,
    List<int>? currentPartitionPages,
    Map<int, PageContentDto>? pages,
    int? verticalIndex,
    Set<int>? loadingPages,
    PageController? pageController,
    ItemScrollController? verticalController,
  }) {
    return QuranPageLoaded(
      partitionMode: partitionMode ?? this.partitionMode,
      partitionId: partitionId ?? this.partitionId,
      currentPartitionPages:
          currentPartitionPages ?? this.currentPartitionPages,
      pages: pages ?? this.pages,
      verticalIndex: verticalIndex ?? this.verticalIndex,
      loadingPages: loadingPages ?? this.loadingPages,
      pageController: pageController ?? this.pageController,
      verticalController: verticalController ?? this.verticalController,
    );
  }
}

// loaded / normal state
class QuranPageLoaded extends QuranPageState {
  const QuranPageLoaded({
    required super.partitionMode,
    required super.partitionId,
    required super.currentPartitionPages,
    required super.pages,
    required super.verticalIndex,
    required super.loadingPages,
    required super.pageController,
    required super.verticalController,
  });

  @override
  QuranPageLoaded copyWith({
    PartitionMode? partitionMode,
    int? partitionId,
    List<int>? currentPartitionPages,
    Map<int, PageContentDto>? pages,
    int? verticalIndex,
    Set<int>? loadingPages,
    PageController? pageController,
    ItemScrollController? verticalController,
  }) {
    return QuranPageLoaded(
      partitionMode: partitionMode ?? this.partitionMode,
      partitionId: partitionId ?? this.partitionId,
      currentPartitionPages:
          currentPartitionPages ?? this.currentPartitionPages,
      pages: pages ?? this.pages,
      verticalIndex: verticalIndex ?? this.verticalIndex,
      loadingPages: loadingPages ?? this.loadingPages,
      pageController: pageController ?? this.pageController,
      verticalController: verticalController ?? this.verticalController,
    );
  }
}
