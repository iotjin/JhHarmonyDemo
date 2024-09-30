import { BaseNavigation, JhButton, JhLoginTextInput } from 'JhCommon'

@Entry
@Preview
@Component
struct FormLoginTextInputTestPage {
  @State name: string = ''
  @State pwd: string = ''
  @State errorText: string = ''

  build() {
    Column() {
      BaseNavigation({ title: 'JhLoginTextInput' }) {
        Scroll() {
          Column() {
            this._body()
          }
        }
      }
    }
  }

  @Builder
  _body() {
    JhLoginTextInput({
      text: 'text赋初值',
      placeholder: '请输入'
    })
    JhLoginTextInput({
      placeholder: '输入时显示删除按钮'
    })
    JhLoginTextInput({
      placeholder: '输入时不显示删除按钮',
      isShowDeleteBtn: false
    })
    JhLoginTextInput({
      placeholder: '密码样式',
      isPwd: true
    })
    JhLoginTextInput({
      placeholder: '默认限制长度30',
    })
    JhLoginTextInput({
      placeholder: '限制长度10,a-zA-Z0-9',
      maxLength: 10,
      inputFilter: '[a-zA-Z0-9]'
    })
    JhLoginTextInput({
      placeholder: '限制长度5,数字输入类型',
      maxLength: 5,
      inputType: InputType.Number
    })
    JhLoginTextInput({
      placeholder: '左侧添加icon',
      leftIcon: $rawfile("svg/ic_login_user.svg")
    })
    JhLoginTextInput({
      placeholder: '左侧自定义',
      leftWidget: () => {
        this.leftBuilder()
      }
    })
    JhLoginTextInput({
      placeholder: '右侧自定义',
      rightWidget: () => {
        this.rightBuilder()
      }
    })
    JhLoginTextInput({
      placeholder: '取消下划线高亮和动画',
      borderAnimation: false,
      borderHighlight: false
    })

    Blank().height(8)
    JhLoginTextInput({
      text: this.name,
      labelText: '用户名',
      placeholder: '请输入用户名',
      leftIcon: $rawfile("svg/ic_login_user.svg"),
      inputCallBack: (value) => {
        this.name = value as string
      },
    })
    Blank().height(8)
    JhLoginTextInput({
      text: this.pwd,
      labelText: '密码',
      placeholder: '请输入密码',
      leftIcon: $rawfile("svg/ic_login_pwd.svg"),
      isPwd: true,
      inputCallBack: (value) => {
        this.pwd = value as string
      },
    })

    Blank().height(30)
    JhButton({
      text: '登 录',
      onPressed: (): void => this.clickLogin()
    })
      .margin(15)
  }

  @Builder
  leftBuilder() {
    Text('+86')
    // Row() {
    // }
    // .width('100%')
    // .height('100%')
    // .backgroundColor(Color.Yellow)
  }

  @Builder
  rightBuilder() {
    Row() {
    }
    .width('100')
    .height('100%')
    .backgroundColor(Color.Orange)
  }

  clickLogin() {
    console.log('name:', JSON.stringify(this.name))
    console.log('pwd:', JSON.stringify(this.pwd))
  }
}