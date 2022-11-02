
abstract class NavigationServiceInterface {
  /// Pop the stack
  Future<void> back();

  /// Takes the user to the first screen of the app once they have been authenticated and completed onboarding
  Future<void> goToHome();

  /// A screen that the user sees if they sign in and have not finished onboarding
  Future<void> goToIncompleteOnboarding();

  /// Return to Decision View and clear the stack
  Future<void> backToDecisionView();

}