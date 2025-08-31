part of 'action_delete_cubit.dart';

class ActionDeleteState extends Equatable {
  final bool isActive;
  final String path;

  const ActionDeleteState({this.isActive = false, this.path = ''});

  ActionDeleteState copyWith({bool? isActive, String? path}) {
    return ActionDeleteState(
      isActive: isActive ?? this.isActive,
      path: path ?? this.path,
    );
  }

  @override
  List<Object> get props => [isActive, path];
}

class ActionDeleteInitial extends ActionDeleteState {
  const ActionDeleteInitial({super.isActive, super.path});

  @override
  ActionDeleteInitial copyWith({bool? isActive, String? path}) {
    return ActionDeleteInitial(
      isActive: isActive ?? this.isActive,
      path: path ?? this.path,
    );
  }
}

class ActionDeleteLoading extends ActionDeleteState {
  const ActionDeleteLoading({super.isActive, super.path});

  @override
  ActionDeleteLoading copyWith({bool? isActive, String? path}) {
    return ActionDeleteLoading(
      isActive: isActive ?? this.isActive,
      path: path ?? this.path,
    );
  }
}

class ActionDeleteSuccess extends ActionDeleteState {
  const ActionDeleteSuccess({super.isActive, super.path});

  @override
  ActionDeleteSuccess copyWith({bool? isActive, String? path}) {
    return ActionDeleteSuccess(
      isActive: isActive ?? this.isActive,
      path: path ?? this.path,
    );
  }
}

class ActionDeleteFailed extends ActionDeleteState {
  final String error;

  const ActionDeleteFailed(this.error, {super.isActive, super.path});

  @override
  List<Object> get props => [error, isActive, path];

  @override
  ActionDeleteFailed copyWith({bool? isActive, String? path, String? error}) {
    return ActionDeleteFailed(
      error ?? this.error,
      isActive: isActive ?? this.isActive,
      path: path ?? this.path,
    );
  }
}
