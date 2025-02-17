///  WxFriendsCirclePage.ets
///
///  Created by iotjin on 2024/11/28.
///  description: 朋友圈

import { router } from '@kit.ArkUI';
import { BaseNavigation, JhPickerTool, JhProgressHUD, KColors } from 'JhCommon'
import { WxFriendsCircleModel } from '../models/WxFriendsCircleModel';
import { WxFriendsCircleCell } from '../widgets/WxFriendsCircleCell'
import { WxContactsModel } from '../../two/models/WxContactsModel';
import resData from '../../res/wx_friends_circle.json'


@Entry
@Preview
@Component
struct WxFriendsCirclePage {
  @State dataArr: WxFriendsCircleModel[] = []
  scroller: Scroller = new Scroller()
  navH: number = 56
  imgNormalHeight: number = 300
  @State imgAllHeight: number = 0
  @State scrollMinOffSet: number = 0
  @State navOpacity: number = 0.0
  @State rightImg: Resource = $rawfile("wechat/discover/ic_camera_white.png")

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
        title: '朋友圈',
        bgColor: `rgba(237,237,237,${this.navOpacity})`,
        rightImgPath: this.rightImg,
        rightItemCallBack: () => {
          this.clickNav()
        },
      })
    }
    .backgroundColor(Color.White)
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
        ForEach(this.dataArr, (item: WxFriendsCircleModel, index: number) => {
          ListItem() {
            WxFriendsCircleCell({
              model: item,
              onClickCell: () => {
                this.clickCell(item.name!)
              },
              onClickHeadPortrait: () => {
                this.jumpInfo()
              },
              onClickComment: () => {
                this.clickCell('评论')
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
    .hitTestBehavior(HitTestMode.Transparent)
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
      this.rightImg = $rawfile("wechat/discover/ic_camera_white.png")
    }
    if (this.navOpacity == 1) {
      this.rightImg = $rawfile("wechat/discover/ic_camera_black.png")
    }
  }

  @Builder
  header() {
    Stack() {
      Image($rawfile('wechat/discover/friends/wx_bg0.jpeg'))
        .objectFit(ImageFit.Cover)
        .width('100%')
        .height(this.imgAllHeight)

      RelativeContainer() {
        Row() {
          Text('小于')
            .fontColor(Color.White)
            .fontSize(18)
            .fontWeight(600)
          Blank().width(20)
          Image($rawfile('images/lufei.png'))
            .width(75)
            .height(75)
            .borderRadius(10)
            .onClick(() => this.jumpInfo())
        }
        .margin({ right: 20 })
        .alignRules({
          bottom: {
            anchor: "__container__",
            align: VerticalAlign.Top
          },
          right: {
            anchor: "__container__",
            align: HorizontalAlign.End
          },
        })
        .id("test")
      }
      .width("100%")
      .height(30)
      .backgroundColor(Color.White)
    }
    .align(Alignment.BottomEnd)
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  jumpInfo() {
    let model = new WxContactsModel();
    model.id = 123;
    model.name = '小于';
    model.namePinyin = '小于';
    model.phone = '17372826674';
    model.sex = '0';
    model.region = '淮北市';
    model.label = '';
    model.color = '#c579f2';
    model.avatarUrl = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    model.isStar = false;
    router.pushUrl({ url: 'pages/two/pages/WxUserInfoPage', params: { data: model } })
  }

  clickNav() {
    JhPickerTool.showBottomSheet({
      title: '请选择操作',
      data: ['拍摄', '从手机相册选择'],
      clickCallback: (index, text) => {
        console.error('index', index)
        console.error('text', text)
      }
    })
  }

  getData() {
    // 原始数据
    const dataArr: ESObject[] = resData['data']
    dataArr.forEach((item: ESObject, index) => {
      for (let i = 0; i < item.images.length; i++) {
        item.images[i] = $rawfile(item.images[i]);
      }
    })
    return dataArr
  }
}