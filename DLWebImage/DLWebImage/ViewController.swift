//
//  ViewController.swift
//  DLWebImage
//
//  Created by qing on 2021/8/11.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DLTableViewCell
        if cell == nil {
            cell = DLTableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.imageV.dl_imageView(url: dataSource[indexPath.row], placeholderImage: nil, failImage: UIImage.init(named: "liveSquare.png"), scaleType: .scaleAdaption)
        return cell ?? DLTableViewCell.init()
    }
    
    var download = DLDownloader.init()
    
    var imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 400))
    
    var tableView = UITableView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.rowHeight = 300
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        imageView.dl_imageView(url: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F374%2F780%2F501%2F559858dc54b34a979c8816a8377fcf01.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631252918&t=4238fc8629da5d12dc1bf2dc35459e11")
    }
    
    var dataSource : [String] = [
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F727%2F102%2F313%2F04dea7677ce3419cbd41ea0b6a3e1049.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=c5eb489ce64e0660c185401a42b00cad",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F374%2F780%2F501%2F559858dc54b34a979c8816a8377fcf01.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=9434e70fdd1ec86c39bf36054c2dc876",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201407%2F01%2F20140701142814_cAkaN.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=28fd96e27cf152f83e40ef21ec04328c",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F94o3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F9345d688d43f8794ccbb1a6ad31b0ef41bd53a29.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=01d2af926c596cab6702ee1f3221b844",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach2.scimg.cn%2Fforum%2F..%2Fmonth_1309%2F22%2F36e6c16bc7a19addc75bb1abcc18f72c_orig.jpg&refer=http%3A%2F%2Fattach2.scimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631420034&t=0425fa4d8207447a4c2e5d3795dcd83c",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F106%2F069%2F371%2F3f53bff8412e46deb6e59af671bb1529.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=a6e35eedd2f18bcfdf0611b184e98438",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F00.minipic.eastday.com%2F20170116%2F20170116135130_9680fa9657b52d487e6b6a79659202e1_7.jpeg&refer=http%3A%2F%2F00.minipic.eastday.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=ec0a08301a07e6e0c7dc55e3b7940565",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201504%2F02%2F153728xb7jhx43434y7334.png&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=fc0c32dc2988f928fecf2aad4b6aa406",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F635%2F857%2F844%2F32109222fb8e4e369e41bbfae9b4ef75.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=0c740ca5af6eddbd4717596a1ced0490",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg10-build.jiwu.com%2Falbum%2Fmanual%2F2021%2F01%2F12%2F112356252665.jpg&refer=http%3A%2F%2Fimg10-build.jiwu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=c086b8a4fb64223bdedab5047bc75a03",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201410%2F25%2F220832wlwzqq6ble9ql6rd.jpg&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=5f635736816ee38e7bfdce60e5437072",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F623%2F064%2F163%2Fce3f1a0a55164e0a8957acde6683aef2.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=95de38caed51759532c59852f2da11b0",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F9fo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F80cb39dbb6fd526692319160a918972bd40736af.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=665306f171fe540b15fcbc494feb98ee",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F162%2F902%2F112%2Fdada762475b647a3bb7bd9a4c322012f.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419814&t=cdb8a1b8a4cb47accb4a04fc2d4f1e56",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb1-q.mafengwo.net%2Fs17%2FM00%2F5F%2F50%2FCoUBXl9fDTmAeIssABwa3GjpstQ427.jpg&refer=http%3A%2F%2Fb1-q.mafengwo.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419966&t=aee10f6630898209e62c1c5e96cf99d4",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F01.minipic.eastday.com%2F20170424%2F20170424103058_e8935c8c0d7b32aabafac7ac5a12f3cf_1.jpeg&refer=http%3A%2F%2F01.minipic.eastday.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419966&t=8349afbd4f8d4cc7552c53d565a10546",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F950%2F386%2F903%2Fcf973148b90844b3b5ecf20c7c214cd8.jpg&refer=http%3A%2F%2Fyouimg1.c-ctrip.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419966&t=f97a36322fc95b89d38c45fb2823a303",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201608%2F24%2F20160824215804_fHJ4x.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631419966&t=a7fb3fb29c1813ded16434b1f07fc46a",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F94o3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F9213b07eca806538ecdf12e492dda144ad348214.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631420034&t=fcbbf9ae9b2309a332e5e25ea9da807c",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach2.scimg.cn%2Fforum%2F201412%2F28%2F154355t7vcdzy21e7d18ce.jpg&refer=http%3A%2F%2Fattach2.scimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631420034&t=46deed9b14346b247903599cc73de885",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb1-q.mafengwo.net%2Fs12%2FM00%2FBE%2FD8%2FwKgED1zoDieAWM28ACIRvamhW_E93.jpeg&refer=http%3A%2F%2Fb1-q.mafengwo.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631420034&t=acb55c7a3af5319b7af170bf15b40429",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Ffile.mtchome.com%2Fp%2F2014%2F08-08%2F9ff1949a6bc3db92358f259d2ea858a5.jpg&refer=http%3A%2F%2Ffile.mtchome.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631420034&t=974be9afc7ecc275e56f59024abe530a",
    ]

}

