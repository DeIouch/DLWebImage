//
//  ImageLoader.swift
//  Kingfisher
//
//  Created by onevcat on 2018/11/18.
//
//  Copyright (c) 2019 Wei Wang <onevcat@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

struct ImageLoader {
    static let sampleImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Loading"
        return (1...10).map { "\(prefix)/kingfisher-\($0).jpg" }
    }()
    
    static let orientationImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Orientation"
        return (1...16).map { "\(prefix)/\($0).jpg" }
    }()

    static let highResolutionImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution"
        return (1...20).map { "\(prefix)/\($0).jpg" }
    }()
    
    static let gifImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/GIF"
        return (1...3).map { "\(prefix)/\($0).gif" }
    }()

    static let progressiveImageURL: String = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Progressive"
        return "\(prefix)/progressive.jpg"
    }()
    
    static func roseImage(index: Int) -> String {
        return "https://github.com/onevcat/Flower-Data-Set/raw/master/rose/rose-\(index).jpg"
    }
    
    static let gifImages : [String] = {
        return [
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_match%2F0%2F13369314328%2F0&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=a60dd48f494e7cf3abbcde1275659731",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs6.sinaimg.cn%2Fbmiddle%2F99547121tc7856425e2a5%26690&refer=http%3A%2F%2Fs6.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=1316f4091dce274a3d9416bbca349467",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs2.sinaimg.cn%2Fmw690%2F001Z8pknzy6ZC0csf1T91%26690&refer=http%3A%2F%2Fs2.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=e5433deb5ba68f95d1ad0580f5b88258",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs13.sinaimg.cn%2Fbmiddle%2F4d4367ee44960933f5e6c&refer=http%3A%2F%2Fs13.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=1106572a57c66fa43ebb8f7abbf6a4b3",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg2.ph.126.net%2F6YayeYWaX4vIq4KfBaizsg%3D%3D%2F3407536068159551018.gif&refer=http%3A%2F%2Fimg2.ph.126.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=066867ec350c97e093051fc0e8b065bd",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.blog.163.com%2Fphoto%2FG4QQRYsRnzuDmxYYjHOmBA%3D%3D%2F5373638780383610447.jpg&refer=http%3A%2F%2Fimg.blog.163.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=679ef27c164efd39caee00e4ed7d491e",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsz.photo.store.qq.com%2Frurl2%3D88a0f1e9934d23b0a3a3f748cd654b2b9bf3b41e1016b9d34716e644c7900c3cdf2a0a48456739c824de332523f92ce44f48910867a9aaf3b553fa4450b3e31e75b8d78cdd11e473f457a9a23e1d7602bc9eae0e&refer=http%3A%2F%2Fsz.photo.store.qq.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=2702c4fd5cadc194d9c3427c5ca44036",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs8.sinaimg.cn%2Fmw690%2F60d27f6dtdebf979e0937%26690&refer=http%3A%2F%2Fs8.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=d1ded01571aea6ed54e5d867dc19d538",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs5.sinaimg.cn%2Fmw690%2Fa2e87d46gcf27909bc164%26690&refer=http%3A%2F%2Fs5.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=2a455024bf6f5cd0060ef295f4a948a2",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgw.alicdn.com%2Fimgextra%2Fi1%2F359059263%2FTB238X5bXXXXXbdXXXXXXXXXXXX_%21%21359059263.gif&refer=http%3A%2F%2Fgw.alicdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=ee76a86206ac8b49a12424ec5a8a1a6d",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171205%2Fee1e0faafcb64c1d950ad5fc5c61358f.gif&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=5b7f8507643c52ad9aecc2c7248fa044",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs16.sinaimg.cn%2Forignal%2F4c213f0244ffa5000952f%26000&refer=http%3A%2F%2Fs16.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=6dea44a7449b998e6210b94a371bdcb4",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbangimg1.dahe.cn%2Fforum%2Fpw%2FMon_1303%2F569_783056_95e07ee260f3419.gif&refer=http%3A%2F%2Fbangimg1.dahe.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=41eb326b021f7cd17fc41e305f5beafe",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs10.sinaimg.cn%2Fmiddle%2F8c65c572tc6871c79d949%26690&refer=http%3A%2F%2Fs10.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=112709dca594b155d607f7aaf24030d6",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs9.sinaimg.cn%2Fbmiddle%2F60d27f6dtc7c330ff1498%26690.gif&refer=http%3A%2F%2Fs9.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=5df05865b405914905d8a70fa04f14a7",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_mini%2Cc_zoom%2Cw_640%2Fimages%2F20170926%2F2afa88c7c35f45adba550252dcc09026.gif&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=23c72b14d3b414ebfc3cb349ffc22803",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs11.sinaimg.cn%2Forignal%2F4845e15e02f020a5f854a&refer=http%3A%2F%2Fs11.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=7d822bd0342d5747e59d8682e039f5ea",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180626%2Fb13028b6c8e84e40b10652b39bccf4ef.gif&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=147052894e61caa620652c397d5d8153",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20181021%2F9e2e0b94dff34e87807dc38dde2989e2.gif&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=550f46b3544b79d2c64cad5a46543a6c",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhiphotos.baidu.com%2Ffeed%2Fpic%2Fitem%2Fa686c9177f3e6709d15fec3632c79f3df9dc559f.jpg&refer=http%3A%2F%2Fhiphotos.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=2466ea0ebcf06702bdd88834f939a1b1",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs10.sinaimg.cn%2Fmiddle%2Fae16441e4c635fc796839%26690&refer=http%3A%2F%2Fs10.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=f676feaf26a4e792fab9b1495ef9a6cf",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs14.sinaimg.cn%2Forignal%2F4d895efdt7a491e3dbf2d%26690&refer=http%3A%2F%2Fs14.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632043042&t=edf1df35d703ea1ba4391b10caf9575e",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs8.sinaimg.cn%2Fbmiddle%2F4a90f018g6211c276d7f7&refer=http%3A%2F%2Fs8.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632044166&t=4605438ab1d7bade502f5d7b723d0dd7",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhiphotos.baidu.com%2Ffeed%2Fpic%2Fitem%2Fa686c9177f3e6709d15fec3632c79f3df9dc559f.jpg&refer=http%3A%2F%2Fhiphotos.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632044166&t=5f6764a8cd40fe8f6f4dbbe65223e2e3",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhiphotos.baidu.com%2Ffeed%2Fpic%2Fitem%2Fb8014a90f603738d787e1144be1bb051f819eca4.jpg&refer=http%3A%2F%2Fhiphotos.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632044166&t=4fb66fae0358b935c75a5c16635afe1e",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fa6.photo.zhixiaorenurl.com%2F17%2F756629%2F1049108607m1722okjn335c1pd9qbj94hgcf51d.gif&refer=http%3A%2F%2Fa6.photo.zhixiaorenurl.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632044166&t=87e36c3351dc931fe35b4da409fe02bf",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs7.sinaimg.cn%2Fbmiddle%2F62a54ffcg85c23fc094d6%26690&refer=http%3A%2F%2Fs7.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632044166&t=9cca2c9c6a49fa0013f572118a37c1dc",
        ]
    }()
    
    static let normalImages : [String] = {
        return [
            "https://img2.baidu.com/it/u=2437460665,2118492077&fm=26&fmt=auto&gp=0.jpg",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdown.52pk.com%2Fuploads%2F131111%2F4993_172854_1.png&refer=http%3A%2F%2Fdown.52pk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042300&t=a76c93ae35efbc51166115fd1379a7b6",
            "https://img14.360buyimg.com/pop/jfs/t1/186653/38/772/47902/608bc1c0E2239be8c/154b009d85761e85.jpg",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg95.699pic.com%2Fphoto%2F40164%2F5628.gif_wh300.gif%21%2Fgifto%2Ftrue&refer=http%3A%2F%2Fimg95.699pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=2f6ca8b0d9227a85f32c7dfdd38d5aad",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg95.699pic.com%2Fphoto%2F40105%2F9856.gif_wh300.gif%21%2Fgifto%2Ftrue&refer=http%3A%2F%2Fimg95.699pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=f4749a2170301b07f1912f0dce76af9e",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg95.699pic.com%2Fphoto%2F40104%2F8671.gif_wh300.gif%21%2Fgifto%2Ftrue&refer=http%3A%2F%2Fimg95.699pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=952b9a38494307f2bec7efd712a604a2",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg95.699pic.com%2Fphoto%2F40191%2F7081.gif_wh300.gif%21%2Fgifto%2Ftrue&refer=http%3A%2F%2Fimg95.699pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=84d91789364b0a1947745d614dacbe63",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg95.699pic.com%2Fphoto%2F40167%2F6496.gif_wh300.gif%21%2Fgifto%2Ftrue&refer=http%3A%2F%2Fimg95.699pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=eb8505ea1a56439ee8cb5bb25c211864",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.wangchao.net.cn%2Ffengjing%2F1327205317794.jpg&refer=http%3A%2F%2Fimage.wangchao.net.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=a00cf1533048b4f84b44afa11caaa55e",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F-Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F4034970a304e251fae75ad03a786c9177e3e534e.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=759999b52ee0c6733a2f3b4a405abdad",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg11.51tietu.net%2Fpic%2F2016-071418%2F20160714181543xyu10ukncwf221991.jpg&refer=http%3A%2F%2Fimg11.51tietu.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=6a91f6db0de22d3a603fb8d0ba4b995f",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi0.sinaimg.cn%2FIT%2F2009%2F1116%2F2009111674122.jpg&refer=http%3A%2F%2Fi0.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=614ef608b9b6388b11cb17c58f673bd7",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi04.c.aliimg.com%2Fimg%2Fibank%2F2013%2F211%2F016%2F791610112_758613609.jpg&refer=http%3A%2F%2Fi04.c.aliimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=c58ba751e77919e459540a567d691e0a",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fa0.att.hudong.com%2F61%2F50%2F19300001236771131415509562158_950.jpg&refer=http%3A%2F%2Fa0.att.hudong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=c914d9464d752bf56948ecf11a66a3db",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201605%2F10%2F20160510001106_2YjCN.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=9e5f3853606637d8b303f53d3ea15471",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic3.16pic.com%2F00%2F34%2F99%2F16pic_3499409_b.jpg&refer=http%3A%2F%2Fpic3.16pic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=15fe3f0a592b795c9d56966441d543e6",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic21.nipic.com%2F20120521%2F10129138_140135304133_2.jpg&refer=http%3A%2F%2Fpic21.nipic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=a5e67eb72e343594eea522b9d47beb47",
            "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/exp/w=500/sign=e3bb7f5ed262853592e0d221a0ee76f2/18d8bc3eb13533fafa609682afd3fd1f40345b43.jpg",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fmmbiz.qpic.cn%2Fmmbiz_jpg%2FQ5UugZ38lXDRtlURosChNia7QFEqpWczkeqOkCMdibEaNUdMVzJLwY3KRALopZJdHXjTgfrW6hcxCB3s8wwsH7rw%2F640%3Fwx_fmt%3Djpeg&refer=http%3A%2F%2Fmmbiz.qpic.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=32e0dd77606b87eeac72b752d5c978eb",
            "https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/7dd98d1001e939014de2b3c97eec54e737d19660.jpg",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbig5.wallcoo.com%2Fpaint%2Fdream%2Fimages%2Fml0020.jpg&refer=http%3A%2F%2Fbig5.wallcoo.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=7bced16b163fbfc167257f860190634c",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic27.nipic.com%2F20130201%2F9922772_230422638000_2.jpg&refer=http%3A%2F%2Fpic27.nipic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=64a7fc461e55bb4888ee69b010536ab3",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx3.sinaimg.cn%2Flarge%2F547f46d9ly4gsqmhfbuf1j20u00g2whd.jpg&refer=http%3A%2F%2Fwx3.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=98314b5f68d047b2896508335ffdfe84",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwx3.sinaimg.cn%2Flarge%2F005IXVOwly4gt3e7wqovnj30go0b5ta5.jpg&refer=http%3A%2F%2Fwx3.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=5cf18daf0c21c9450f4f6bea7b69e186",
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1108%2F09%2Fc5%2F8597586_8597586_1312885301234_mthumb.jpg&refer=http%3A%2F%2Fimg.pconline.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632042376&t=732a55bb6cf759f24291cde0390474e4",
        ]
    }()
    
    static let bigImages : [String] = {
        return [
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
    }()
    
}
