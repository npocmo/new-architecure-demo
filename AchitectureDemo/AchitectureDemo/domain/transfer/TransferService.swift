import RxSwift
import Foundation

class TransferService {
    static let instance = TransferService()
    
    private let restSevice = RestService.instance
    
    private init() { }
    
    func validateTransfer(transferModel: TransferModel) -> Completable {
        return Completable.empty()
    }
    
    func executeTransfer(transferModel: TransferModel) -> Completable {
        return Completable.empty()
    }
}

