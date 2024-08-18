//

import UIKit

class StoryCardViewModel {
    
    private var listStories: [Stories]
    
    init(listStories: [Stories]) {
        self.listStories = listStories
    }
    
    public var numberOfItems: Int {
        listStories.count
    }
    
    public func loadCurrentStory(_ indexPath: IndexPath) -> Stories {
        listStories[indexPath.row]
    }
}
