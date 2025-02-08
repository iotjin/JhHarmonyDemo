///  WxInfoSetPage.ets
///
///  Created by iotjin on 2025/01/16. 
///  description:  资料设置


import { router } from '@kit.ArkUI';
import { BaseNavigation, JhProgressHUD, JhSetCell, KColors } from 'JhCommon'
import { WxContactsModel } from '../models/WxContactsModel';

const _cellH = 55.0;
const _rowSpace = 6.0;

@Entry
@Preview
@Component
struct WxInfoSetPage {
  jumpParams = (router.getParams() as Record<string, string>)['data']
  @State model: WxContactsModel = new WxContactsModel()
  @State switchSelected: boolean = false
  @State switchSelected2: boolean = false

  aboutToAppear() {
    console.error('jumpParams', JSON.stringify(this.jumpParams))
    console.error('用户名称：', JSON.stringify(this.jumpParams['name']))

    this.model = this.jumpParams as WxContactsModel
    this.switchSelected = this.model.isStar!;
  }

  build() {
    Column() {
      BaseNavigation({ title: '资料设置', bgColor: Color.Transparent })
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
            cellHeight: _cellH,
            title: '备注和标签',
            text: this.model.label,
            clickCallBack: (): void => this.clickCell('备注和标签'),
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '朋友权限',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('朋友权限'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            titleWidth: 150,
            title: this.model.sex == '0' ? '把他推荐给朋友' : '把她推荐给朋友',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell(this.model.sex == '0' ? '把他推荐给朋友' : '把她推荐给朋友'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '设为星标朋友',
            hiddenLine: true,
            hiddenArrow: true,
            rightWidget: () => {
              this.rightBuilder(this.switchSelected, false)
            },
            clickCallBack: (): void => this.clickCell('设为星标朋友'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            title: '加入黑名单',
            hiddenArrow: true,
            rightWidget: () => {
              this.rightBuilder(this.switchSelected2, true)
            },
            clickCallBack: (): void => this.clickCell('加入黑名单'),
          })
          JhSetCell({
            cellHeight: _cellH,
            title: '投诉',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('投诉'),
          })
          Blank().height(_rowSpace)
          Text('删除')
            .fontSize(18)
            .fontColor(Color.Red)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('100%')
            .height(_cellH)
            .backgroundColor(KColors.kCellBgColor)
            .onClick(() => this.clickCell('删除'))
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

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }
}