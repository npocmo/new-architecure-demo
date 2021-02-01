enum AmountInputViewState {
    case
    loading,
    dataLoaded(balance: Balance),
    availableAmountFetchFailed
}
