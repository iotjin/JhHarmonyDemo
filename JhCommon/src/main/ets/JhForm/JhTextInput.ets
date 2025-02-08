///  JhTextInput.ets
///
///  Created by iotjin on 2024/08/19.
///  description: 单行输入框（默认没有边框，宽充满屏幕，文字居左，可设置键盘类型，最大长度，密码模式，清空图标，文字样式）


import { KColors } from '../JhCommon/configs/Colors'

const _maxLength = 50
const _textFontSize = 15.0
const _hintFontSize = 15.0
const _textColor = KColors.kFormInfoColor
const _hintColor = KColors.kFormHintColor
// const _cursorColor = '#007DFF'
const _cursorColor = KColors.kThemeColor
const _lineColor = KColors.kFormLineColor


@Preview
@Component
export struct JhTextInput {
  @Prop public text?: ResourceStr = ''
  @Prop public placeholder?: ResourceStr = '请输入'
  // @Prop public errorText?: ResourceStr | undefined = '' // 错误提示文字,下划线模式使用
  @Prop public textStyle: TextStyle = { fontSize: _textFontSize, fontColor: _textColor }
  @Prop public hintTextStyle: TextStyle = { fontSize: _hintFontSize, fontColor: _hintColor }
  @Prop public inputType: InputType = InputType.Normal // 输入框类型
  @Prop public enterKeyType: EnterKeyType = EnterKeyType.Done // 输入法回车键类型
  @Prop public textAlign: TextAlign = TextAlign.Start // 输入文字对齐方式，默认左对齐
  @Prop public bottomLineColor: ResourceColor = _lineColor // 边框颜色
  @Prop public cursorColor: ResourceColor = _cursorColor // 光标颜色
  @Prop public maxLength: number = _maxLength // 最大长度，默认_maxLength
  @Prop public isShowBorder: boolean = false // 是否显示边框，默认不显示
  @Prop public isPwd: boolean = false // 是否是密码，默认不是
  @Prop public isShowDeleteBtn: boolean = false // 是否显示右侧删除按钮，默认不显示
  // @Prop public showCounter: boolean = false // 是否显示右下角计数器,下划线模式使用
  @Prop public inputFilter: ResourceStr = '' // 通过正则表达式设置输入过滤器
  public inputCallBack?: (value: ResourceStr) => void // 录入改变回调
  public inputDoneCallBack?: (value: ResourceStr, isEditing: boolean) => void // 录入完成回调（失去焦点或者点击键盘右下角按钮触发）
  // private
  @State private passwordState: boolean = false;
  private cancelImage: ResourceStr = $rawfile("JhForm/ic_input_close.svg")
  private openImage: ResourceStr = $rawfile("JhForm/ic_pwd_open.png")
  private closeImage: ResourceStr = $rawfile("JhForm/ic_pwd_close.png")
  private controller: TextInputController = new TextInputController()
  @State private isEditing: boolean = false

  // TextInput官方文档
  // https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-textinput-V5

  aboutToAppear() {
  }

  build() {
    Row() {
      this.inputBuilder()
    }
  }

  isActivated() {
    return this.isEditing && this.text !== ''
  }

  @Builder
  inputBuilder() {
    TextInput({
      text: this.text,
      placeholder: this.placeholder,
      controller: this.controller,
    })
      .padding({
        left: 5,
        top: 8,
        right: 5,
        bottom: 8
      })// 设置内边距
      .fontSize(this.textStyle.fontSize)
      .fontColor(this.textStyle.fontColor)
      .placeholderFont({ size: this.hintTextStyle.fontSize })
      .placeholderColor(this.hintTextStyle.fontColor)
      .style(TextInputStyle.Default)
      .type(this.isPwd ? InputType.Password : this.inputType)
      .enterKeyType(this.enterKeyType)
      .textAlign(this.textAlign)
      .caretColor(this.cursorColor)
      .showPasswordIcon(true)
      .showPassword(this.passwordState)
      .onSecurityStateChange(((isShowPassword: boolean) => {
        // 更新密码显示状态
        this.passwordState = isShowPassword
      }))
      .passwordIcon({ onIconSrc: this.openImage, offIconSrc: this.closeImage })// 自定义密码显示图标
        // 下划线 ,密码类型不支持下划线
        // .showUnderline(true)
        // .underlineColor({
        //   normal: Color.Orange,
        //   typing: Color.Green,
        //   error: Color.Red,
        //   disable: Color.Gray
        // })
        // .showError(this.errorText)
      .backgroundColor(Color.Transparent)
      .borderRadius(0)
      .borderColor(this.bottomLineColor)
      .borderWidth({ bottom: this.isShowBorder ? 1 : 0 })
      .maxLength(this.maxLength)//
        // .showCounter(this.showCounter, { thresholdPercentage: 50, highlightBorder: false })
        //计数器显示效果为用户当前输入字符数/最大字符限制数。最大字符限制数通过maxLength()接口设置。
        //如果用户当前输入字符数达到最大字符限制乘50%（thresholdPercentage）。字符计数器显示。
        //用户设置highlightBorder为false时，配置取消红色边框。不设置此参数时，默认为true。
      .cancelButton(!this.isShowDeleteBtn ? null : {
        style: this.isActivated() ? CancelButtonStyle.INPUT : CancelButtonStyle.INVISIBLE,
        icon: { size: this.isActivated() ? 20 : 0, color: '#C8C8C8', src: this.isActivated() ? this.cancelImage : null },
      })
      .inputFilter(this.inputFilter)// 正则
        // .inputFilter('[a-z]', (e) => {
        //   console.log(JSON.stringify(e))
        // })
      .onChange((value) => {
        this.text = value
        this.inputCallBack?.(value)
      })
      .onEditChange((isEditing) => {
        this.isEditing = isEditing
        this.inputDoneCallBack?.(this.text ?? '', isEditing)
      })
      .onSubmit((_EnterKeyType) => {
        this.isEditing = true
        this.inputDoneCallBack?.(this.text ?? '', true)
      })
  }
}