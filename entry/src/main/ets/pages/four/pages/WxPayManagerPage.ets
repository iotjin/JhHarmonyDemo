///  WxPayManagerPage.ets
///
///  Created by iotjin on 2025/01/02.
///  description:  微信 支付管理

import { BaseNavigation, JhProgressHUD, JhSetCell, KColors } from 'JhCommon'

const _cellH = 55.0;
const _rowSpace = 6.0;

@Entry
@Preview
@Component
struct WxPayManagerPage {
  @State switchSelected: boolean = false
  @State switchSelected2: boolean = true

  build() {
    Column() {
      BaseNavigation({ title: $r('app.string.wxPayManager'), bgColor: Color.Transparent })
      this.body()
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      ListItem() {
        Column() {
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '实名认证',
            text: '已认证',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('实名认证'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '修改支付密码',
            clickCallBack: (): void => this.clickCell('修改支付密码'),
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '忘记支付密码',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('忘记支付密码'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '指纹支付',
            hiddenLine: true,
            hiddenArrow: true,
            rightWidget: () => {
              this.rightBuilder(this.switchSelected, false)
            }
          })
          Text('开启后，转账或消费时，可使用 Touch ID 验证指纹快速完成付款')
            .padding({
              left: 20,
              top: 5,
              right: 25,
              bottom: 15
            })
            .fontColor(Color.Gray)
            .fontSize(15)
          JhSetCell({
            cellHeight: _cellH,
            titleWidth: 200,
            title: '允许通过手机号向我转账',
            hiddenLine: true,
            hiddenArrow: true,
            rightWidget: () => {
              this.rightBuilder(this.switchSelected2, true)
            }
          })
          Text() {
            Span('他人可进入“收付款 > 向银行卡手机号转账”，向你的微信绑定手机号转账，收款将存入零钱。开启即同意')
              .fontColor(Color.Gray)
              .fontSize(15)
            Span('服务协议')
              .fontColor(Color.Blue)
              .fontSize(15)
              .onClick(() => {
                this.clickCell('服务协议')
              })
          }
          .padding({
            left: 20,
            top: 5,
            right: 25,
            bottom: 15
          })

          JhSetCell({
            cellHeight: _cellH,
            title: '扣费服务',
            clickCallBack: (): void => this.clickCell('扣费服务'),
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '转账到账时间',
            text: '实时到账',
            clickCallBack: (): void => this.clickCell('转账到账时间'),
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '红包退款方式',
            text: '退回原支付方式',
            clickCallBack: (): void => this.clickCell('红包退款方式'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '服务管理',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('服务管理'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '注销微信支付',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('注销微信支付'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            titleWidth: 150,
            title: '微信收款商家版',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('微信收款商家版'),
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
  rightBuilder(value: boolean, isTwo: boolean) {
    Toggle({ type: ToggleType.Switch, isOn: value })//
      // .selectedColor('#007DFF')
      .selectedColor(KColors.kThemeColor)
      .switchPointColor(Color.White)
      .onChange((isOn: boolean) => {
        console.error('Component status:' + isOn)
        if (isTwo) {
          this.switchSelected2 = isOn
        } else {
          this.switchSelected = isOn
        }
      })
  }

  clickCell(title: string) {
    console.error('点击cell', title)
    JhProgressHUD.showText(`点击 ${title}`)
  }
}