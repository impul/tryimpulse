import Vapor
import BlockObserver

var blockObserver = BlockObserver(assets: [.ethereum, .ripple])

public func routes(_ router: Router) throws {
    //http://localhost:8080/add/0xB29f7E1AB952CF2770D56712e4667680F55359eb/ethereum
    router.get("add", String.parameter, String.parameter) { req -> [String: String] in
        let parametrs = req.parameters.values
        let address = parametrs[0].value
        guard let coin = coin(name: parametrs[1].value) else {
            return ["error": "Unsupported coin"]
        }
        blockObserver.addObserver(for: address, asset: coin)
        return ["info": "Observer for \(address) added"]
    }
    
    router.get("remove", String.parameter, String.parameter) { req -> [String: String] in
        let parametrs = req.parameters.values
        let address = parametrs[0].value
        guard let coin = coin(name: parametrs[1].value) else {
            return ["error": "Unsupported coin"]
        }
        blockObserver.removeObserver(for: address, asset: coin)
        return ["info": "Observer for \(address) removed"]
    }

    router.get("transactions") { req -> [[String: String]] in
        return blockObserver.transactions.map {
            return ["txId": $0.txId,
                    "asset": coinString(name: $0.asset),
                    "address": $0.receiverAddress]
        }
    }
    
    func coin(name: String) -> Asset? {
        switch name {
        case "ethereum":
            return .ethereum
        case "ripple":
            return .ripple
        default: return nil
        }
    }
    
    func coinString(name: Asset) -> String {
        switch name {
        case .ethereum:
            return "ethereum"
        case .ripple:
            return "ripple"
        }
    }
}
