import RxSwift

protocol SummaryInteractorProtocol: class {
    func validateAndExecuteTransfer(transferModel: TransferModel) -> Completable
}

class SummaryInteractor: SummaryInteractorProtocol {
    func validateAndExecuteTransfer(transferModel: TransferModel) -> Completable {
        return TransferService.instance.validateTransfer(transferModel: transferModel)
            .andThen(TransferService.instance.executeTransfer(transferModel: transferModel))
    }
}
 
