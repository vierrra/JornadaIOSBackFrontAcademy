//

import UIKit

class HomeViewController: UIViewController {
    
    private var screen: HomeScreen?
    private var homeViewModel: HomeViewModel = HomeViewModel()
    private let flag: Bool = false
    
    override func loadView() {
        screen = HomeScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTypeRequest(flag: flag)
    }
    
    private func fetchTypeRequest(flag: Bool) {
        if flag {
            //homeViewModel.fetchHomeDataAlamofire()
            homeViewModel.fetchHomeDataURLSession()
            homeViewModel.delegate(delegate: self)
        } else {
            homeViewModel.fetchHomeDataMock()
            screen?.configProtocolsCollection(self, dataSource: self)
        }
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func success() {
        //Sempre usar " DispatchQueue.main.async" quando utilizarmos URLSession"
        //Com alamofire não precisamos, pois ele já o utiliza por debaixo dos panos
        DispatchQueue.main.async {
            self.screen?.configProtocolsCollection(self, dataSource: self)
        }
    }
}

extension HomeViewController: UIPencilInteractionDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCardCollectionViewCell.identifier, for: indexPath) as? StoryCardCollectionViewCell
            cell?.setupCell(homeViewModel.getListStories)
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCardCollectionViewCell.identifier, for: indexPath) as? PostCardCollectionViewCell
            cell?.setupCell(homeViewModel.getListPosts)
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return homeViewModel.sizeForItemAt(indexPath, frame: collectionView.frame )
    }
}

