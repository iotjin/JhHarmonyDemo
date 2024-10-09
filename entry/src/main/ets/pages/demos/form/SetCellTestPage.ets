import { BaseNavigation, JhSetCell } from 'JhCommon'

@Entry
@Preview
@Component
struct SetCellTestPage {
  @State name: string = ''
  @State pwd: string = ''
  @State errorText: string = ''

  build() {
    Column() {
      BaseNavigation({ title: 'JhSetCell' }) {
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
    JhSetCell({
      title: '左标题',
      clickCallBack: () => {
        console.log('点击cell')
      },
    })
    JhSetCell({
      title: '左标题',
      text: '右侧文字',
      clickCallBack: () => {
        console.log('点击cell')
      },
    })
    JhSetCell({
      title: '左标题左标题左标题',
      text: '右侧文字',
      titleWidth: 150,
    })
    JhSetCell({
      leftIcon: $rawfile("images/demos/ic_set.png"),
      title: '设置',
      text: '右侧文字'
    })
    JhSetCell({
      leftIcon: $rawfile("images/demos/ic_set.png"),
      title: '关于',
      text: '有新版本',
      textStyle: { fontColor: Color.Red, fontSize: 15 }
    })
    JhSetCell({
      leftIcon: $rawfile("images/demos/ic_set.png"),
      title: '左侧文字红色',
      titleStyle: { fontColor: Color.Red, fontSize: 15 }
    })
    JhSetCell({
      title: '左标题',
      text: 'text靠左',
      textAlign: TextAlign.Start
    })
    JhSetCell({
      title: '左标题',
      text: '隐藏箭头',
      hiddenArrow: true
    })
    JhSetCell({
      title: '左侧宽200',
      text: '左侧自定义',
      titleWidth: 200,
      leftWidget: () => {
        this.rightBuilder()
      }
    })
    JhSetCell({
      title: '左标题',
      text: '右侧自定义',
      titleWidth: 100,
      rightWidget: () => {
        this.rightBuilder()
      }
    })
    JhSetCell({
      title: '设置图标大小/背景色/高度',
      bgColor: Color.Yellow,
      cellHeight: 80,
      titleWidth: 200,
      leftIcon: $rawfile("images/demos/ic_set.png"),
      leftImgWH: 40,
    })
    JhSetCell({
      title: '隐藏底部线',
      hiddenLine: true
    })
  }

  @Builder
  rightBuilder() {
    Row() {
    }
    .width('100')
    .height('100%')
    .backgroundColor(Color.Orange)
  }
}