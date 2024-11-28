import { router } from '@kit.ArkUI';
import { BaseNavigation, KColors } from 'JhCommon';
import { WxHomePage } from './pages/WxHomePage';

@Preview
@Entry
@Component
export struct OnePage {
  @State message: string = 'One'

  build() {
    Column() {
      WxHomePage()
      // this.body()
    }
    .height('100%')
    .width('100%')
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    Column() {
      BaseNavigation({ title: "One", leftItem: {} })
      Button('DemoList').onClick(() => {
        router.pushUrl({ url: 'pages/demos/DemoListPage' })
      })
      RelativeContainer() {
        Text(this.message)
          .id('OnePage')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
      .height('100%')
      .width('100%')
    }
  }
}