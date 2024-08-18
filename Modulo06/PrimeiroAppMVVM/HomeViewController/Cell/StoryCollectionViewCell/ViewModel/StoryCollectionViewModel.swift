//

import UIKit

class StoryCollectionViewModel {
    
    public func hidenButton(_ indexPath: IndexPath) -> Bool {
        indexPath.row == 0 ? false : true
    }
}
