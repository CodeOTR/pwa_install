class JS {
  final String? name;
  const JS([this.name]);
}

allowInterop<F extends Function>(F f){
  throw UnimplementedError();
}