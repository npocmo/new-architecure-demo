public class ServiceLocator {
    public static let instance = ServiceLocator()
    
    let restService: RestServiceProtocol
    let balanceService: BalanceServiceProtocol
    let transferService: TransferServiceProtocol
    
    private init() {
        restService = RestService()
        
        balanceService = BalanceService(restSevice: restService)
        transferService = TransferService(restService: restService)
    }
}
