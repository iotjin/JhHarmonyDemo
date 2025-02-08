///  JhButton.ets
///
///  Created by iotjin on 2024/08/14. 
///  description: 登录/提交 按钮

import { KColors } from '../configs/Colors';

const _fontSize = 18.0; // 文字大小
const _borderWidth = 0.0; // 边框宽度
const _borderRadius = 5.0; // 边框圆角

const _bgColor: ResourceColor = KColors.kThemeColor
const _textColor: ResourceColor = Color.White

@Preview
@Component
export struct JhButton {
  @Prop public text: string = '按钮'
  @Prop public textColor: ResourceColor = _textColor
  @Prop public btnWidth: Dimension | Length = '100%'
  @Prop public btnHeight: Dimension | Length = 48
  @Prop public btnFontSize: Dimension | Length = _fontSize
  @Prop public btnRadius: Dimension | Length = _borderRadius
  @Prop public btnBorderWidth: Dimension | Length = _borderWidth
  @Prop public bgColor: ResourceColor = _bgColor
  @Prop public disabled: boolean = false
  public onPressed?: () => void // disabled状态点击事件失效

  build() {
    Button(this.text)
      .type(ButtonType.Normal)
      .size({ width: this.btnWidth, height: this.btnHeight })
      .backgroundColor(this.bgColor)
      .opacity(this.disabled ? 0.6 : 1.0)
      .borderWidth(this.btnBorderWidth)
      .borderRadius(this.btnRadius)
      .fontSize(this.btnFontSize)
      .fontColor(this.textColor)
      .onClick(() => this.disabled ? null : this.onPressed?.())
  }
}