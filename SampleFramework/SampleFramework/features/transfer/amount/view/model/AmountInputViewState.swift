enum AmountInputViewState {
    case
    loading,
    updateAvailableAmount(balance: AmountInputBalanceViewModel),
    availableAmountFetchFailed
}
