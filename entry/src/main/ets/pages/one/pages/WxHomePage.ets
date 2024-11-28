///  WxHomePage.ets
///
///  Created by iotjin on 2024/11/07.
///  description: 微信首页

import { promptAction, router } from '@kit.ArkUI'
import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { WxHomeItemType } from '../models/WxHomeModel'
import { WxHomeCell } from '../widgets/WxHomeCell'


@Entry
@Preview
@Component
export struct WxHomePage {
  @State dataArr: WxHomeItemType[] = []
  scroller: ListScroller = new ListScroller()

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.log('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({
        title: '微信',
        leftItem: {},
        rightImgPath: $rawfile("images/ic_nav_add.png"),
        rightItemCallBack: () => {
          console.log('点击了右侧图标')
          this.onClickRightItem()
        },
      })
      Scroll() {
        Column() {
          this.body()
        }
        .backgroundColor(KColors.wxBgColor)
      }
      .layoutWeight(1)
    }
  }

  @Builder
  body() {
    List({ scroller: this.scroller }) {
      ForEach(this.dataArr, (item: WxHomeItemType, index: number) => {
        ListItem() {
          WxHomeCell({
            model: item,
            onClickCell: () => {
              this.clickCell(item)
            },
          })
        }
        .swipeAction({
          end: {
            builder: () => {
              this.itemSwipeEnd(item.type)
            },
            actionAreaDistance: 0, // 设置组件长距离滑动删除距离阈值。 默认56
            onAction: () => {
              animateTo({ duration: 1000 }, () => {
              })
            },
          }
        })
      })
    }
    .layoutWeight(1)
    .divider({
      strokeWidth: 0.5,
      startMargin: 70,
      endMargin: 0,
      color: KColors.kLineColor
    })
  }

  @Builder
  itemSwipeEnd(type: string) {
    if (type == '0') {
      Row()
    }
    if (type == '1') {
      Row() {
        Text('删除')
          .fontSize(14)
          .fontWeight(400)
          .fontColor(Color.White)
      }
      .width('25%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Red)
      .onClick(() => {
        JhProgressHUD.showToast('删除')
        this.scroller.closeAllSwipeActions()
      })
    }
    if (type == '2') {
      Row() {
        Row() {
          Text('标为未读')
            .fontSize(14)
            .fontColor(Color.White)
        }
        .width('50%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#74736D')
        .onClick(() => {
          JhProgressHUD.showToast('标为未读')
          this.scroller.closeAllSwipeActions()
        })

        Row() {
          Text('删除')
            .fontSize(14)
            .fontWeight(400)
            .fontColor(Color.White)
        }
        .width('50%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Red)
        .onClick(() => {
          JhProgressHUD.showToast('删除')
          this.scroller.closeAllSwipeActions()
        })
      }
      .width('50%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Red)
      .onClick(() => {
        JhProgressHUD.showToast('删除')
        this.scroller.closeAllSwipeActions()
      })
    }
    if (type == '3') {
      Row() {
        Row() {
          Text('不再关注')
            .fontSize(14)
            .fontColor(Color.White)
        }
        .width('50%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#74736D')
        .onClick(() => {
          JhProgressHUD.showToast('不再关注')
          this.scroller.closeAllSwipeActions()
        })

        Row() {
          Text('删除')
            .fontSize(14)
            .fontWeight(400)
            .fontColor(Color.White)
        }
        .width('50%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Red)
        .onClick(() => {
          JhProgressHUD.showToast('删除')
          this.scroller.closeAllSwipeActions()
        })
      }
      .width('50%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Red)
      .onClick(() => {
        JhProgressHUD.showToast('删除')
        this.scroller.closeAllSwipeActions()
      })
    }
  }

  /* openCustomDialog API12+

    创建并弹出dialogContent对应的自定义弹窗，使用Promise异步回调。

    https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-arkui-uicontext-V5#opencustomdialog12
   */

  /* promptAction.openCustomDialog API11+

    打开自定义弹窗

   https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-promptaction-V5#promptactionopencustomdialog11
   */

  private customDialogId: number = 0

  onClickRightItem() {
    promptAction.openCustomDialog({
      builder: () => {
        this.customDialogComponent()
      },
      width: '160vp',
      height: this.popData.length * 50 + 6,
      offset: { dx: -10, dy: 56 },
      alignment: DialogAlignment.TopEnd,
      // backgroundColor: '#2D2D2D',
      backgroundColor: Color.Transparent,
      cornerRadius: 5,
    }).then((dialogId: number) => {
      this.customDialogId = dialogId
    })
  }

  @Builder
  customDialogComponent() {
    Column() {
      Row() {
        Image($rawfile('images/popMenus/ic_menu_up_arrow.png')).height(6)
        Blank().width(10)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      List() {
        ForEach(this.popData, (item: ESObject, index: number) => {
          ListItem() {
            Row() {
              Blank().width(15)
              Image(item['icon']).width(22)
              Blank().width(15)
              Text(item['text'])
                .fontColor(Color.White)
                .fontSize(16)
            }
            .width('100%')
            .height(50)
            .alignItems(VerticalAlign.Center)
          }
          .onClick(() => {
            promptAction.closeCustomDialog(this.customDialogId)
            this.clickPopCell(item['text'])
          })
        })
      }
      .enableScrollInteraction(false)
      .layoutWeight(1)
      .divider({
        strokeWidth: 1,
        startMargin: 50,
        endMargin: 0,
        color: '#E6E6E6',
      })
      .backgroundColor('#2D2D2D')
      .borderRadius(5)
    }
  }

  clickCell(item: WxHomeItemType) {
    console.log('点击cell', JSON.stringify(item))
    if (item.title == 'Demo 列表') {
      router.pushUrl({ url: 'pages/demos/DemoListPage' })
    } else if (item.title == '微信运动') {
      router.pushUrl({ url: 'pages/one/pages/WxMotionPage' })
    } else if (item.title == '订阅号消息') {
      router.pushUrl({ url: 'pages/one/pages/WxSubscriptionNumberListPage' })
    } else if (item.title == 'QQ邮箱提醒') {
      router.pushUrl({ url: 'pages/one/pages/WxQQMessagePage' })
    } else {
      router.pushUrl({ url: 'pages/demos/DemoListPage' })
    }
  }

  clickPopCell(text: string) {
    console.log('点击', JSON.stringify(text))
    if (text == '添加朋友') {
      router.pushUrl({ url: 'pages/two/pages/WxAddFriendPage' })
    }
  }

  getData() {
    let dataArr: WxHomeItemType[] = [
      {
        'title': 'Demo 列表',
        'subtitle': '点击跳转demo列表',
        'img': 'images/ic_demo1.png',
        'time': '',
        'isNew': false,
        'type': '0',
      },
      {
        'title': '微信运动',
        'subtitle': '[应用消息]',
        'img': 'wechat/home/wechat_motion.png',
        'time': '22:23',
        'isNew': true,
        'type': '1',
      },
      {
        'title': '订阅号消息',
        'subtitle': '新闻联播开始啦',
        'img': 'wechat/home/ic_subscription_number.png',
        'time': '19:00',
        'isNew': true,
        'type': '1',
      },
      {
        'title': 'QQ邮箱提醒',
        'subtitle': '您有一封新的邮件，请前往查收',
        'img': 'wechat/home/Ic_email.png',
        'time': '17:30',
        'isNew': false,
        'type': '3',
      },
      {
        'title': '张三',
        'subtitle': '欢迎欢迎',
        'img': 'images/picture/touxiang_1.jpeg',
        'time': '17:30',
        'isNew': false,
        'type': '2',
      },
      {
        'title': '李四',
        'subtitle': 'hello',
        'img': 'images/picture/touxiang_2.jpeg',
        'time': '17:30',
        'isNew': false,
        'type': '2',
      },
      {
        'title': '王五',
        'subtitle': '[图片]',
        'img': 'images/picture/touxiang_3.jpeg',
        'time': '17:30',
        'isNew': false,
        'type': '2',
      },
      {
        'title': '赵六',
        'subtitle': '[动画表情]',
        'img': 'images/picture/touxiang_4.jpeg',
        'time': '17:30',
        'isNew': false,
        'type': '2',
      },
      {
        'title': '微信团队',
        'subtitle': '安全登录提醒',
        'img': 'wechat/home/ic_about.png',
        'time': '2020/8/8',
        'isNew': false,
        'type': '1',
      },
    ];
    return dataArr;
  }

  popData: ESObject = [
    {
      'text': '发起群聊',
      'icon': $rawfile('images/popMenus/ic_chat.png'),
    },
    {
      'text': '添加朋友',
      'icon': $rawfile('images/popMenus/ic_add.png'),
    },
    {
      'text': '扫一扫',
      'icon': $rawfile('images/popMenus/ic_scan.png'),
    },
    {
      'text': '收付款',
      'icon': $rawfile('images/popMenus/ic_pay.png'),
    },
  ];
}