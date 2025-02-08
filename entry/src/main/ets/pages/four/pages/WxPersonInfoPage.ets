///  WxPersonInfoPage.ets
///
///  Created by iotjin on 2025/01/03.
///  description:  微信 个人信息

import { BaseNavigation, JhSetCell, KColors } from 'JhCommon'

const _cellH = 55.0;
const _rowSpace = 6.0;

@Entry
@Preview
@Component
struct WxPersonInfoPage {
  build() {
    Column() {
      BaseNavigation({ title: $r('app.string.wxPersonInfo'), bgColor: Color.Transparent })
      this.body()
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      ListItem() {
        Column() {
          JhSetCell({
            cellHeight: 75,
            title: '头像',
            rightWidget: () => {
              this.rightBuilder1()
            },
            clickCallBack: (): void => {
              console.error('点击头像')
            },
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '名字',
            text: 'jin'
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '拍一拍',
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '微信号',
            text: 'abc'
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '我的二维码',
            rightWidget: () => {
              this.rightBuilder2()
            }
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '更多',
            hiddenLine: true
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '我的地址',
            hiddenLine: true,
          })
          Blank().height(15)
        }
      }
    }
    .layoutWeight(1)
    .edgeEffect(EdgeEffect.Spring, {
      alwaysEnabled: true
    })
  }

  @Builder
  rightBuilder1() {
    Image('https://gitee.com/iotjh/Picture/raw/master/lufei.png')
      .width(55)
      .height(55)
      .borderRadius(5)
  }

  @Builder
  rightBuilder2() {
    Image($rawfile('wechat/mine/ic_setting_myQR.png'))
      .width(20)
      .height(20)
      .margin({ right: 15 })
  }
}