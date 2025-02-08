import { BaseNavigation, JhButton, JhFormInputCell } from 'JhCommon'

@Entry
@Preview
@Component
struct FormInputCellTestPage {
  @State name: string = ''
  @State pwd: string = ''

  build() {
    Column() {
      BaseNavigation({ title: 'JhFormInputCell' }) {
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
    JhFormInputCell({
      placeholder: '默认样式，不设置左标题，可换行',
      inputCallBack: (value) => {
        console.log(value as string)
      },
    })
    JhFormInputCell({
      placeholder: '单行，显示右侧删除按钮',
      isTextArea: false
    })
    JhFormInputCell({
      placeholder: '单行，密文',
      isTextArea: false,
      isPwd: true
    })
    Blank().height(8)
    JhFormInputCell({
      text: 'text赋初值',
      labelText: '顶部文字',
      placeholder: '请输入',
      // rightWidget: () => {
      //   this.rightBuilder()
      // }
    })
    Blank().height(8)
    JhFormInputCell({
      labelText: '顶部文字',
      placeholder: '请输入',
      // rightWidget: () => {
      //   this.rightBuilder()
      // }
    })
    JhFormInputCell({
      title: '左标题',
    })
    JhFormInputCell({
      title: '左标题',
      text: 'text赋初值,不可编辑',
    }).enabled(false)
    JhFormInputCell({
      title: '左标题',
      placeholder: '标题加红星',
      showRedStar: true,
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: '红色标题',
      titleStyle: { fontColor: Color.Red, fontSize: 15 }
    })
    JhFormInputCell({
      title: '左标题',
      text: '红色文字',
      textStyle: { fontColor: Color.Red, fontSize: 15 }
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: '红色提示文字',
      hintTextStyle: { fontColor: Color.Red, fontSize: 15 }
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: 'text靠右',
      textAlign: TextAlign.End
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: '限制长度10,a-zA-Z0-9',
      maxLength: 10,
      inputFilter: '[a-zA-Z0-9]'
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: '限制长度5,数字输入类型',
      maxLength: 5,
      inputType: InputType.Number
    })

    JhFormInputCell({
      title: '左标题',
      placeholder: '左侧自定义',
      leftWidget: () => {
        this.rightBuilder()
      }
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: '右侧自定义',
      rightWidget: () => {
        this.rightBuilder()
      }
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: '下划线高亮和动画',
      borderAnimation: true,
      borderHighlight: true
    })
    JhFormInputCell({
      text: '右下角显示计数器(多行生效，限制长度50，配合maxLength使用)',
      showCounter: true,
      maxLength: 50
    })
    JhFormInputCell({
      title: '左标题',
      placeholder: '隐藏下划线',
      hiddenLine: true,
    })

    Blank().height(30)
    JhButton({
      text: '提 交',
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