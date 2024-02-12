abstract base class Usecase<InputParam, OutputParam> {
  Future<OutputParam> call(InputParam input);
}
