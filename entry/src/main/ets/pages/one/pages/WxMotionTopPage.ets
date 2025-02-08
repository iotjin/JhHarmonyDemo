///  WxMotionTopPage.ets
///
///  Created by iotjin on 2025/01/21.
///  description:   微信运动排行榜


import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { WxMotionTopModel } from '../models/WxMotionTopModel';
import { WxMotionTopCell } from '../widgets/WxMotionTopCell'
import resData from '../../res/wx_motion_top.json'


@Entry
@Preview
@Component
struct WxMotionTopPage {
  @State dataArr: WxMotionTopModel[] = []
  scroller: Scroller = new Scroller()
  navH: number = 56
  imgNormalHeight: number = 300
  @State imgAllHeight: number = 0
  @State scrollMinOffSet: number = 0
  @State navOpacity: number = 0.0
  @State rightImg: Resource = $rawfile("images/ic_more_white.png")

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))

    this.imgAllHeight = this.imgNormalHeight
    this.scrollMinOffSet = this.imgNormalHeight - this.navH
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      this.header()
      this.body()
      BaseNavigation({
        title: '排行榜',
        bgColor: `rgba(237,237,237,${this.navOpacity})`,
        rightImgPath: this.rightImg,
        rightItemCallBack: () => {
          this.clickCell('更多')
        },
      })
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List({ scroller: this.scroller }) {
      ListItem() {
        Row()
          .width('100%')
          .height(this.imgNormalHeight)
      }

      if (this.dataArr.length == 0) {
        ListItem() {
          Text('暂无数据')
            .width('100%')
            .padding({ top: 50 })
            .textAlign(TextAlign.Center)
            .fontSize(18)
        }
      } else {
        ForEach(this.dataArr, (item: WxMotionTopModel, index: number) => {
          ListItem() {
            WxMotionTopCell({
              model: item,
              onClickCell: () => {
                this.clickCell(item.name!)
              },
            })
          }
        })
      }
    }
    .layoutWeight(1)
    .edgeEffect(EdgeEffect.Spring, {
      alwaysEnabled: true
    })
    .onDidScroll(() => {
      this.handleScroll()
    })
  }

  handleScroll() {
    const y = this.scroller.currentOffset().yOffset
    // console.error('滑动距离 ', y)
    if (y < this.scrollMinOffSet) {
      this.imgAllHeight = this.imgNormalHeight + (-y)
    } else {
      this.imgAllHeight = this.navH
    }
    // console.error('this.imgAllHeight', this.imgAllHeight)

    // nav 透明度
    let navOpacity: number = y / this.navH
    if (navOpacity < 0) {
      navOpacity = 0.0
    } else if (navOpacity > 1) {
      navOpacity = 1.0
    }
    this.navOpacity = navOpacity

    // console.error('navOpacity', navOpacity)

    this.setRightImg()
  }

  setRightImg() {
    if (this.navOpacity == 0) {
      this.rightImg = $rawfile("images/ic_more_white.png")
    }
    if (this.navOpacity == 1) {
      this.rightImg = $rawfile("images/ic_more_black.png")
    }
  }

  @Builder
  header() {
    Image($rawfile('wechat/home/ic_top.jpg'))
      .objectFit(ImageFit.Cover)
      .width('100%')
      .height(this.imgAllHeight)
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  getData() {
    // 原始数据
    const dataArr: ESObject[] = resData['data']
    dataArr.forEach((item: ESObject, index) => {
      if (item['isOwn'] == true) {
        dataArr.unshift(...dataArr.splice(index, 1))
      }
    })
    return dataArr
  }
}