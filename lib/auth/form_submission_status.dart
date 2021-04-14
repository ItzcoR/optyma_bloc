abstract class FormSubmissionStatus{
  const FormSubmissionStatus();
}

class InitialFormSatus extends FormSubmissionStatus{
  const InitialFormSatus();
}

class FormSubmitting extends FormSubmissionStatus{}

class SubmissionSuccess extends FormSubmissionStatus{}

class SubmissionFailed extends FormSubmissionStatus{
  final Exception exception;
  
  SubmissionFailed(this.exception);
}
