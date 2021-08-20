import UIKit

let cellHeight : CGFloat = 200

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageLoader.gifImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DLTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DLTableViewCell", for: indexPath) as! DLTableViewCell
        let string = ImageLoader.gifImages[indexPath.row]
        DLWebImageView.setWebImage(view: cell.imageV).url(url: string).failImage(failImage: UIImage.init(named: "liveSquare.png")).scaleType(scaleType: .scaleOriginal).state(state: .highlighted).showLoading(showLoading: true).failBlock {
            
        }.completionBlock(completionBlock: { (image) in
            
        }).resume()
        return cell
    }
        
    var tableView = UITableView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.rowHeight = cellHeight
        tableView.register(DLTableViewCell.self, forCellReuseIdentifier: "DLTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
//        UIButton.init().setTitle("", for: .normal)
    }

}

