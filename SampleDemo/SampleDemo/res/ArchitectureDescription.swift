// Responsibility of View:
/// The View is passive. It waits for the Presenter to give it content to display. it never asks the Presenter for data.
/// Methods defined for a View should allow a Presenter to communicate at a higher level of abstraction, expressed in terms of its content, and not how that content is to be displayed.
/// The Presenter does not know about the existence of UILabel, UIButton, etc. The Presenter only knows about the content it maintains and when it should be displayed.
/// It is up to the View to determine how the content is displayed.


// Responsibility of Presenter:
/// The Presenter mainly consists of logic to drive the UI.
/// It gathers input from user interactions so it can update the UI
/// Sends requests to services.
/// Maps Service Model to ViewModel and updates View via ViewState(ViewModel)


// Responsibility of Wireframe:
/// Wireframe describes flow of one use case.
/// It has one ore multiple entry points
/// It has one flow model, which will be updated by presenters in order to keep information of the whole use case


// Responsibility of Service:
/// Service contains the business logic to manipulate model objects (Entities/Data) to carry out a specific task.
/// The work done in an Service should be independent of any UI.
/// The same Service could be used in multiple Presenters.


// Responsibility of Repository:

// Responsibility of RestService:

// Responsibility of ServiceLocator:

// Responsibility of Data Classes(DTO):

// Responsibility of RestService:
