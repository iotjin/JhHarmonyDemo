import { BaseNavigation, KColors } from 'JhCommon';
import { WxContactsPage } from './pages/WxContactsPage';

@Entry
@Component
export struct TwoPage {
  @State message: string = 'Two'

  aboutToAppear() {
    console.log('TwoPage aboutToAppear')
  }

  build() {
    Column() {
      WxContactsPage()
      // this.body()
    }
    .height('100%')
    .width('100%')
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    Column() {
      BaseNavigation({ title: "Two", leftItem: {} })
      RelativeContainer() {
        Text(this.message)
          .id('TwoPage')
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