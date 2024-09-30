///  JhLoginTextInput.ets
///
///  Created by iotjin on 2024/08/19. 
///  description: 登录输入框（默认下划线，左侧icon, 自定义widget，labelText, 密码模式）

import { KColors } from '../JhCommon/configs/Colors'
import { JhTextInput } from './JhTextInput'

const _maxLength = 30
const _textFontSize = 15.0
const _hintFontSize = 15.0
const _textColor = KColors.kFormInfoColor
const _hintColor = KColors.kFormHintColor
const _themeColor = KColors.kThemeColor
const _lineColor = KColors.kFormLineColor

const _cellHeight = 55 // 设置label高度为55，否则是45
const _inputHeight = 44


@Preview
@Component
export struct JhLoginTextInput {
  @Prop public labelText?: ResourceStr = '' // top提示文字, 不设置不显示
  @Prop public labelTextStyle: TextStyle = { fontSize: _hintFontSize, fontColor: _hintColor }
  @Prop public leftIcon: ResourceStr = '' //左侧图标，推荐svg, 不设置时不显示 eg: $rawfile("svg/ic_login_user.svg")
  @Prop public borderAnimation: boolean = true // 下划线动画，默认true
  @Prop public borderHighlight: boolean = true // 下划线高亮，默认true
  @BuilderParam leftWidget?: () => void // 左侧自定义组件，默认隐藏，优先级高于leftIcon，宽高为_inputHeight
  @BuilderParam rightWidget?: () => void // 右侧自定义组件，默认隐藏，高度为_inputHeight，设置宽度会压缩录入框的宽度
  // JhTextInput 属性
  @Prop public text?: ResourceStr = ''
  @Prop public placeholder?: ResourceStr = '请输入'
  @Prop public errorText?: ResourceStr | undefined = '' // 错误提示文字
  @Prop public textStyle: TextStyle = { fontSize: _textFontSize, fontColor: _textColor }
  @Prop public hintTextStyle: TextStyle = { fontSize: _hintFontSize, fontColor: _hintColor }
  @Prop public inputType: InputType = InputType.Normal // 输入框类型
  @Prop public enterKeyType: EnterKeyType = EnterKeyType.Done // 输入法回车键类型
  @Prop public textAlign: TextAlign = TextAlign.Start // 输入文字对齐方式，默认左对齐
  @Prop public maxLength: number = _maxLength // 最大长度，默认_maxLength
  @Prop public isShowBorder: boolean = false // 是否显示边框，默认不显示
  @Prop public isPwd: boolean = false // 是否是密码，默认不是
  @Prop public isShowDeleteBtn: boolean = true // 是否显示右侧删除按钮，默认不显示
  @Prop public inputFilter: ResourceStr = '' // 通过正则表达式设置输入过滤器
  public inputCallBack?: (value: ResourceStr) => void // 录入改变回调
  public inputDoneCallBack?: (value: ResourceStr, isEditing: boolean) => void // 录入完成回调（失去焦点或者点击键盘右下角按钮触发）
  // private
  @State private isEditing: boolean = false
  @State private activeColor: ResourceColor = _themeColor

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

      Row() {
        // left
        if (this.isShowLeftWidget()) {
          Row() {
            if (this.leftWidget) {
              this.leftWidget()
            } else {
              Image(this.leftIcon)
                .fillColor(this.isEditing ? this.activeColor : _hintColor)
                .width(_inputHeight / 2)
                .height(_inputHeight / 2)
            }
          }
          .justifyContent(FlexAlign.Center)
          .margin({ top: this.getTopMargin() })
          .padding({ left: 5, bottom: 5 })
          .width(_inputHeight)
          .height(_inputHeight)
        }

        // center
        Row() {
          this.inputBuilder()
        }
        .layoutWeight(1)

        // right
        Row() {
          if (this.rightWidget) {
            this.rightWidget()
          }
        }
        .height(this.isActivated() ? this.getCellHeight() : _inputHeight)
        .margin({ top: this.isActivated() ? 0 : this.getTopMargin() })
      }

      // label text
      if (this.isActivated()) {
        Text(this.labelText)
          .fontColor(this.isEditing ? this.activeColor : this.labelTextStyle.fontColor)
          .fontSize(this.labelTextStyle.fontSize)
          .margin({ left: this.isShowLeftWidget() ? _inputHeight : 0 })
          .position({ x: 0, y: this.isActivated() ? 0 : this.getTopMargin() + 8 })
          .translate({ x: 0, y: -0 })
          .animation({ duration: 100, curve: Curve.Linear })
      }

      // bottom line
      this.lineBuilder()
    }
    // .align(Alignment.TopStart)
    .width('100%')
    .height(this.getCellHeight())
  }

  isShowLeftWidget() {
    return this.leftIcon || this.leftWidget
  }

  isActivated() {
    return this.isEditing || this.text !== ''
  }

  getCellHeight() {
    return this.labelText ? _cellHeight : _cellHeight - 10
  }

  getTopMargin() {
    return this.getCellHeight() - _inputHeight
  }

  @Builder
  inputBuilder() {
    JhTextInput({
      text: this.text,
      placeholder: this.placeholder,
      // placeholder: this.isEditing ? '' : this.placeholder,
      textStyle: this.textStyle,
      hintTextStyle: this.hintTextStyle,
      inputType: this.inputType,
      enterKeyType: this.enterKeyType,
      textAlign: this.textAlign,
      cursorColor: this.activeColor,
      bottomLineColor: this.activeColor,
      maxLength: this.maxLength,
      isShowBorder: this.isShowBorder,
      isPwd: this.isPwd,
      isShowDeleteBtn: this.isShowDeleteBtn,
      inputFilter: this.inputFilter,
      inputCallBack: (value: ResourceStr) => {
        this.text = value
        this.inputCallBack?.(value)
      },
      inputDoneCallBack: (value: ResourceStr, isEditing: boolean) => {
        this.isEditing = isEditing
        this.inputDoneCallBack?.(value, isEditing)
      },
    })
      .width('100%')
      .height(_inputHeight)
      .margin({ top: this.getTopMargin() })
  }

  @Builder
  lineBuilder() {
    Line()
      .width('100%')
      .height(1)
      .backgroundColor(this.borderHighlight ? this.activeColor : _lineColor)
      .position({ x: 0, y: this.getCellHeight() - 1 })
      .scale({ x: this.isEditing ? 1 : 0, centerX: 0 })
      .animation(this.borderAnimation ? { duration: 100, curve: Curve.Linear } : null)
    if (!this.isEditing) {
      Line()
        .width('100%')
        .height(1)
        .backgroundColor(_lineColor)
        .position({ x: 0, y: this.getCellHeight() - 1 })
    }
  }
}