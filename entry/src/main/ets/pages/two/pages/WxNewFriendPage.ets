///  WxAddFriendPage.ets
///
///  Created by iotjin on 2025/01/14.
///  description:  新的朋友

import { router } from '@kit.ArkUI'
import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { WxNewFriendModel } from '../models/WxNewFriendModel'
import { WxNewFriendCell } from '../widgets/WxNewFriendCell'


@Entry
@Preview
@Component
struct WxNewFriendPage {
  @State dataArr: WxNewFriendModel[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({
        title: '新的朋友',
        bgColor: Color.Transparent,
        rate: 28,
        rightText: '添加朋友',
        rightItemCallBack: () => {
          router.pushUrl({ url: 'pages/two/pages/WxAddFriendPage' })
        },
      })
      this.body()
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      this.header()
      ForEach(this.dataArr, (item: WxNewFriendModel, index: number) => {
        ListItem() {
          WxNewFriendCell({
            model: item,
            onClickCell: () => {
              this.clickCell(item.title!)
            },
            onClickBtn: () => {
              this.clickCell('接收')
            },
          })
        }
      })
    }
    .layoutWeight(1)
    .edgeEffect(EdgeEffect.Spring, {
      alwaysEnabled: true
    })
    .divider({
      strokeWidth: 0.5,
      startMargin: 0,
      endMargin: 0,
      color: KColors.kLineColor
    })
  }

  @Builder
  header() {
    Column() {
      Search({ value: '', placeholder: '微信号/手机号' })
        .borderRadius(5)
        .margin(10)
        .backgroundColor(Color.White)
        .onSubmit((value: string) => {
          console.log('搜索框 onSubmit 文字：', JSON.stringify(value))
        })
        .onChange((value: string) => {
          console.log('搜索框 onChange 文字：', JSON.stringify(value))
        })
      Column() {
        Column() {
          Text() {
            SymbolSpan($r('sys.symbol.phone_fill'))
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
              .fontColor([Color.Green])
          }

          Blank().height(10)
          Text('添加手机联系人').fontColor(Color.Gray)
        }
        .padding(10)
        .width('100%')
        .backgroundColor(Color.White)

        Text('三天前')
          .textAlign(TextAlign.Start)
          .width('100%')
          .height(35)
          .fontColor(Color.Gray)
      }

    }
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  getData() {
    let dataArr: WxNewFriendModel[] = [
      {
        'title': '张三',
        'subtitle': '欢迎欢迎',
        'img': 'images/picture/touxiang_1.jpeg',
        'isAdd': true,
      },
      {
        'title': '李四',
        'subtitle': 'hello',
        'img': 'images/picture/touxiang_2.jpeg',
        'isAdd': false,
      },
      {
        'title': '王五',
        'subtitle': '[图片]',
        'img': 'images/picture/touxiang_3.jpeg',
        'isAdd': false,
      },
      {
        'title': '赵六',
        'subtitle': '[动画表情]',
        'img': 'images/picture/touxiang_4.jpeg',
        'isAdd': true,
      },
      {
        'title': '哈哈哈',
        'subtitle': '',
        'img': 'images/picture/touxiang_5.jpeg',
        'isAdd': false,
      },
      {
        'title': '@',
        'subtitle': 'hi',
        'img': 'images/picture/touxiang_6.jpg',
        'isAdd': false,
      },
    ];
    return dataArr;
  }
}