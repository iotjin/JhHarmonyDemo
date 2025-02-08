import { BaseNavigation, JhButton, JhFormSelectCell } from 'JhCommon'

@Entry
@Preview
@Component
struct FormSelectCellTestPage {
  @State name: string = ''
  @State pwd: string = ''
  @State errorText: string = ''

  build() {
    Column() {
      BaseNavigation({ title: 'JhFormSelectCell' }) {
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
    JhFormSelectCell({
      selectCallBack: () => {
        console.log('点击cell')
      },
    })
    Blank().height(8)
    JhFormSelectCell({
      text: 'text赋初值',
      labelText: '顶部文字',
      placeholder: '请选择'
    })
    Blank().height(8)
    JhFormSelectCell({
      text: '这是多行这是多行这是多行这是多行这是多行这是多行这是多行这是多行',
      labelText: '顶部文字',
      placeholder: '请选择'
    })
    JhFormSelectCell({
      title: '左标题',
    })
    JhFormSelectCell({
      title: '左标题',
      text: 'text赋初值',
    })
    JhFormSelectCell({
      title: '左标题',
      text: '这是多行这是多行这是多行这是多行这是多行这是多行这是多行这是多行',
      placeholder: '请选择'
    })
    JhFormSelectCell({
      showRedStar: true,
      title: '左标题',
      placeholder: '标题加红星',
    })
    JhFormSelectCell({
      title: '左标题',
      placeholder: '红色标题',
      titleStyle: { fontColor: Color.Red, fontSize: 15 }
    })
    JhFormSelectCell({
      title: '左标题',
      text: '红色文字',
      textStyle: { fontColor: Color.Red, fontSize: 15 }
    })
    JhFormSelectCell({
      title: '左标题',
      text: 'text靠右',
      textAlign: TextAlign.End
    })
    JhFormSelectCell({
      title: '左标题',
      placeholder: '左侧自定义',
      leftWidget: () => {
        this.rightBuilder()
      }
    })
    JhFormSelectCell({
      title: '左标题',
      placeholder: '右侧自定义',
      rightWidget: () => {
        this.rightBuilder()
      }
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