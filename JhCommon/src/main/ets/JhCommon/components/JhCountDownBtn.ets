///  JhCountDownBtn.ets
///
///  Created by iotjin on 2025/01/23. 
///  description:  倒计时按钮


import { KColors } from "../configs/Colors";


const _normalText = '获取验证码'; // 默认按钮文字
const _resendAfterText = '重新获取'; // 重新获取文字
const _normalTime = 10; // 默认倒计时时间
const _fontSize = 13.0; // 文字大小
const _borderWidth = 0.8; // 边框宽度
const _borderRadius = 1.0; // 边框圆角


@Preview
@Component
export struct JhCountDownBtn {
  public getVCode?: () => Promise<boolean> // 验证码获取回调
  @Prop public getCodeText: string = _normalText
  @Prop public resendAfterText: string = _resendAfterText
  @Prop public textColor?: ResourceColor = KColors.kThemeColor
  @Prop public bgColor?: ResourceColor = Color.Transparent
  @Prop public fontSize: number = _fontSize
  @Prop public btnBorderColor?: ResourceColor = KColors.kThemeColor
  @Prop public btnBorderRadius: number = _borderRadius
  @Prop public showBorder: boolean = false
  //
  @State private timer: number = -1
  @State private countDownNum: number = _normalTime

  aboutToDisappear() {
    // 组件销毁时清除定时器
    if (this.timer !== -1) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  build() {
    Button() {
      Text(this.getCodeText)
        .fontSize(this.fontSize)
        .fontColor(this.textColor)
    }
    .type(ButtonType.Normal)
    .size({ width: 120, height: 32 })
    .backgroundColor(this.bgColor)
    .borderRadius(this.btnBorderRadius)
    .borderWidth(this.showBorder ? _borderWidth : 0)
    .borderColor(this.btnBorderColor)
    .onClick(() => this.onGetVCode())
  }

  // 点击获取验证码
  private async onGetVCode() {
    if (this.getVCode) {
      const isSuccess = await this.getVCode()
      if (isSuccess) {
        this.startCountdown()
      }
    }
  }

  // 开始倒计时
  private startCountdown() {
    if (this.timer !== -1) {
      return
    }

    this.getCodeText = `${this.resendAfterText}(${this.countDownNum}s)`
    this.timer = setInterval(() => {
      if (this.countDownNum > 1) {
        this.countDownNum--
        this.getCodeText = `${this.resendAfterText}(${this.countDownNum}s)`
      } else {
        this.getCodeText = _normalText
        this.countDownNum = _normalTime
        clearInterval(this.timer)
        this.timer = -1
      }
    }, 1000)
  }
}