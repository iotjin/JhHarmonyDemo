import { BaseNavigation } from 'JhCommon';

@Entry
@Component
export struct ThreePage {
  @State message: string = 'Three'

  build() {
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