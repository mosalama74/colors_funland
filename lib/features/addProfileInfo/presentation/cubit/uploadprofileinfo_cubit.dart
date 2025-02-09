import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'uploadprofileinfo_state.dart';

class UploadprofileinfoCubit extends Cubit<UploadprofileinfoState> {
  UploadprofileinfoCubit() : super(UploadprofileinfoInitial());
}
