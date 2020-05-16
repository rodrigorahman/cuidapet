import 'package:mobx/mobx.dart';

enum StoreState { initial, loading, loaded, error }

class StoreUtils {
  static statusCheck(ObservableFuture future) {
    if (future == null) {
      return StoreState.initial;
    }
    print(future.status);

    switch (future.status) {
      case FutureStatus.pending:
        return StoreState.loading;
      case FutureStatus.rejected:
        print(future.result);
        return StoreState.error;
      case FutureStatus.fulfilled:
        return StoreState.loaded;
      default:
        return StoreState.initial;
    }
  }
}
