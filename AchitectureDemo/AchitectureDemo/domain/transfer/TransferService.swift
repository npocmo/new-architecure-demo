import RxSwift
import Foundation

protocol TransferServiceProtocol {
    func validateTransfer(transferModel: TransferModel) -> Completable
    func executeTransfer(transferModel: TransferModel) -> Completable
}

class TransferService: TransferServiceProtocol {
    
    let restService: RestServiceProtocol
    
    init(restService: RestServiceProtocol) {
        self.restService = restService
    }
    
    func validateTransfer(transferModel: TransferModel) -> Completable {
        return Completable.empty()
    }
    
    func executeTransfer(transferModel: TransferModel) -> Completable {
        return Completable.empty()
    }
}

