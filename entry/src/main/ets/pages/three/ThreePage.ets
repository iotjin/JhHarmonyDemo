import { BaseNavigation, KColors } from 'JhCommon';
import { WxDiscoverPage } from './pages/WxDiscoverPage';

@Entry
@Component
export struct ThreePage {
  @State message: string = 'Three'

  build() {
    Column() {
      WxDiscoverPage()
      // this.body()
    }
    .height('100%')
    .width('100%')
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    Column() {
      BaseNavigation({ title: "Three", leftItem: {} })
      RelativeContainer() {
        Text(this.message)
          .id('ThreePage')
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