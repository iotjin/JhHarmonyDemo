import { BaseNavigation } from 'JhCommon';

@Entry
@Component
export struct TwoPage {
  @State message: string = 'Two'

  build() {
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