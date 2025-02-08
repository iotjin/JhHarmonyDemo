///  WxUserInfoPage.ets
///
///  Created by iotjin on 2025/01/15.
///  description:  用户信息

import { router } from '@kit.ArkUI'
import { BaseNavigation, JhProgressHUD, JhSetCell, KColors } from 'JhCommon'
import { WxContactsModel } from '../models/WxContactsModel';

const _cellH = 55.0;
const _rowSpace = 6.0;

@Entry
@Preview
@Component
struct WxUserInfoPage {
  jumpParams = (router.getParams() as Record<string, string>)['data']
  @State model: WxContactsModel = new WxContactsModel()

  aboutToAppear() {
    console.error('jumpParams', JSON.stringify(this.jumpParams))
    console.error('用户名称：', JSON.stringify(this.jumpParams['name']))

    this.model = this.jumpParams as WxContactsModel
  }

  build() {
    Column() {
      BaseNavigation({
        title: '用户信息',
        bgColor: Color.Transparent,
        rightImgPath: $rawfile("images/ic_more_black.png"),
        rightItemCallBack: () => {
          router.pushUrl({ url: 'pages/two/pages/WxInfoSetPage', params: { data: this.jumpParams } })
        },
      })
      List() {
        this.header()
        this.body()
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring, {
        alwaysEnabled: true
      })
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    Blank().height(0.5).width('100%').backgroundColor(KColors.kLineColor)
    JhSetCell({
      cellHeight: _cellH,
      title: '备注和标签',
      text: this.model.label,
      textAlign: TextAlign.Start,
      clickCallBack: (): void => this.clickCell('备注和标签'),
    })
    JhSetCell({
      cellHeight: _cellH,
      title: '朋友权限',
      text: this.model.isStar ? '' : '不看他的朋友圈和视频动态',
      textAlign: TextAlign.Start,
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('朋友权限'),
    })
    Blank().height(_rowSpace)
    JhSetCell({
      cellHeight: _cellH + 20,
      title: '朋友圈',
      clickCallBack: (): void => this.clickCell('朋友圈'),
    })
    JhSetCell({
      cellHeight: _cellH,
      title: '更多信息',
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('更多信息'),
    })
    Blank().height(_rowSpace)
    Row() {
      Image($rawfile('wechat/contacts/ic_xinxi.png')).width(20)
      Blank().width(5)
      Text('发消息').fontSize(18).fontWeight(FontWeight.Bold).fontColor(KColors.wxTextBlueColor)
    }
    .width('100%')
    .height(_cellH)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(KColors.kCellBgColor)
    .onClick(() => this.clickCell('发消息'))

    Blank().height(0.5).width('100%').backgroundColor(KColors.kLineColor)
    Row() {
      Image($rawfile('wechat/contacts/ic_shipintonghua.png')).width(20)
      Blank().width(5)
      Text('音视频通话').fontSize(18).fontWeight(FontWeight.Bold).fontColor(KColors.wxTextBlueColor)
    }
    .width('100%')
    .height(_cellH)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(KColors.kCellBgColor)
    .onClick(() => this.clickCell('音视频通话'))
  }

  @Builder
  header() {
    Row() {
      Text(this.model.name!.substring(0, 1))
        .fontColor(Color.White)
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .width(66)
        .height(66)
        .margin({ left: 20, top: 3, right: 15 })
        .borderRadius(5)
        .backgroundColor(this.model.color!)

      Column() {
        Row() {
          Text(this.model.name)
            .fontWeight(FontWeight.Bold)
            .fontSize(20)
          Blank().width(5)
          Text() {
            SymbolSpan($r('sys.symbol.person'))
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
              .fontColor([this.model.sex == '0' ? '#2196F3' : '#FF5252'])
          }
        }

        Blank().height(3)
        Text('昵称：' + this.model.namePinyin).fontSize(16).fontColor(Color.Gray)
        Blank().height(3)
        Text('手机号：' + this.model.phone).fontSize(16).fontColor(Color.Gray)
        Blank().height(3)
        Text('地区：' + this.model.region).fontSize(16).fontColor(Color.Gray)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(70)

      if (this.model.isStar) {
        Text() {
          SymbolSpan($r('sys.symbol.star_fill'))
            .fontWeight(FontWeight.Bold)
            .fontSize(20)
            .fontColor([Color.Yellow])
        }
        .layoutWeight(15)
      }
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .padding({ top: 10, bottom: 20 })
    .backgroundColor(KColors.kCellBgColor)
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }
}