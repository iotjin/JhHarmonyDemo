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
  @Prop public disabled: boolean = false
  public onPressed?: () => void // disabled状态点击事件失效

  build() {
    Button(this.text)
      .type(ButtonType.Normal)
      .size({ width: '100%', height: 48 })
      .backgroundColor(_bgColor)
      .opacity(this.disabled ? 0.6 : 1.0)
      .borderWidth(_borderWidth)
      .borderRadius(_borderRadius)
      .fontSize(_fontSize)
      .fontColor(_textColor)
      .onClick(() => this.disabled ? null : this.onPressed?.())
  }
}