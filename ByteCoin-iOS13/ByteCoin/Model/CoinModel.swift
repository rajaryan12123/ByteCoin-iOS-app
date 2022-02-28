// Bytecoin
//
//  Created by Raj Aryan on 15/02/2022.
//

import Foundation
struct coinModel {
    let rate: Double
    let asset_id_base: String
    var rateString: String {
        return String(format: "%.1f", rate)
    }
}
