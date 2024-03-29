import 'package:bloc/bloc.dart';

import 'package:flutter_nexmuv/app/blocs/crypto/crypto_event.dart';
import 'package:flutter_nexmuv/app/blocs/crypto/crypto_state.dart';
import 'package:flutter_nexmuv/app/models/crypto_model.dart';
import 'package:flutter_nexmuv/app/repositories/crypto_repository.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final ICryptoRepository repository;

  List<CryptoModel> _crypto = [];
  get crypto => _crypto;

  CryptoBloc({required this.repository}) : super(InitialCryptoState()) {
    on((event, emit) async {
      emit(LoadingCryptoState());

      if (event is LoadCryptoEvent) {
        _crypto = await repository.load(event.symbol);
      }

      emit(LoadedCryptoState(_crypto));
    });
  }
}
