import 'package:equatable/equatable.dart';


class ProfileInfoState extends Equatable {
  const ProfileInfoState();
    @override
  List<Object?> get props => [];
}



class ProfileInfoInitialState extends ProfileInfoState {
    final String? errorMessage;

  const ProfileInfoInitialState(
    {required this.errorMessage}
  );
}

class ProfileInfoLoadingState extends ProfileInfoState {
    const ProfileInfoLoadingState();

}


class PickedImageSuccessState extends ProfileInfoState {
    final String? localImagePath;

    const PickedImageSuccessState(
     {required this.localImagePath,}
    );

}

class PickedImageErrorState extends ProfileInfoState {
      final String? errorMessage;

    const PickedImageErrorState(
          {required this.errorMessage}

    );

}
class UploadImageSuccessState extends ProfileInfoState {
  final String? imageUrl;

    const UploadImageSuccessState(
     {required this.imageUrl,}
    );

}

class UploadImageErrorState extends ProfileInfoState {
      final String? errorMessage;

    const UploadImageErrorState(
          {required this.errorMessage}

    );

}
class SaveChildInfoSuccessState extends ProfileInfoState {
  final String? messag;

    const SaveChildInfoSuccessState(
     {required this.messag,}
    );

}

class SaveChildInfoErrorState extends ProfileInfoState {
      final String? errorMessage;

    const SaveChildInfoErrorState(
          {required this.errorMessage}

    );

}
class UploadChildDataSuccessState extends ProfileInfoState {
  final String? messag;

    const UploadChildDataSuccessState(
     {required this.messag,}
    );

}

class UploadChildDataErrorState extends ProfileInfoState {
      final String? errorMessage;

    const UploadChildDataErrorState(
          {required this.errorMessage}

    );

}
class UpdateChildDataSuccessState extends ProfileInfoState {
  final String message;

  const UpdateChildDataSuccessState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class UpdateChildDataErrorState extends ProfileInfoState {
  final String? errorMessage;

  const UpdateChildDataErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}

class GetChildrenSuccessState extends ProfileInfoState {
  final List<Map<String, dynamic>>? children;

    const GetChildrenSuccessState(
     {required this.children,}
    );

}

class GetChildrenErrorState extends ProfileInfoState {
      final String? errorMessage;

    const GetChildrenErrorState(
          {required this.errorMessage}

    );

}
class GetChildSuccessState extends ProfileInfoState {
  final Map<String, dynamic> child;

  const GetChildSuccessState({
    required this.child,
  });

  @override
  List<Object?> get props => [child];
}

class GetChildErrorState extends ProfileInfoState {
      final String? errorMessage;

    const GetChildErrorState(
          {required this.errorMessage}

    );

}
class UpdateChildProgressSuccessState extends ProfileInfoState {
  final String message;

  const UpdateChildProgressSuccessState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class UpdateChildProgressErrorState extends ProfileInfoState {
  final String? errorMessage;

  const UpdateChildProgressErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}


