///  WxQQMessagePage.ets
///
///  Created by iotjin on 2025/01/17. 
///  description:  QQ邮箱提醒


import { BaseNavigation, JhProgressHUD, JhSetCell, KColors } from 'JhCommon'
import { WxQQMessageModel } from '../models/WxQQMessageModel';
import { WxQQMessageCell } from '../widgets/WxQQMessageCell'


@Entry
@Preview
@Component
struct WxQQMessagePage {
  @State dataArr: WxQQMessageModel[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({
        title: 'QQ邮箱提醒',
        bgColor: Color.Transparent,
        rightImgPath: $rawfile("images/ic_more_black.png"),
        rightItemCallBack: () => {
          this.clickCell('更多')
        },
      })
      this.body()
      this.footer()
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      if (this.dataArr.length == 0) {
        ListItem() {
          Text('暂无数据')
            .width('100%')
            .padding({ top: 50 })
            .textAlign(TextAlign.Center)
            .fontSize(18)
        }
      } else {
        ForEach(this.dataArr, (item: WxQQMessageModel, index: number) => {
          ListItem() {
            WxQQMessageCell({
              model: item,
              onClickCell: () => {
                this.clickCell(item.title!)
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
    .divider({
      strokeWidth: 10,
      startMargin: 0,
      endMargin: 0,
      color: Color.Transparent
      // color: KColors.kLineColor
    })
  }

  @Builder
  footer() {
    Row() {
      Button('写邮件')
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .onClick(() => this.clickCell('写邮件'))
      Divider().vertical(true).height(22).strokeWidth(2).margin({ left: 8, right: 8 })
      Button(`QQ邮箱（${this.dataArr.length}）`)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .onClick(() => this.clickCell('QQ邮箱'))
    }
    .width('100%')
    .height(60)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  getData() {
    let dataArr: WxQQMessageModel[] = [
      {
        'title': '消息1',
        'subtitle': '您收到一封新的邮件',
      },
      {
        'title': '消息2',
        'subtitle': '您收到一封新的邮件',
      },
    ];
    return dataArr;
  }
}