import { LengthMetrics } from "@kit.ArkUI";
import { CitySelectModel } from "./CitySelectModel";


const _cellHeight = 50

@Preview
@Component
export struct CitySelectCell {
  index: number = 0;
  model: CitySelectModel = new CitySelectModel();
  searchController: SearchController = new SearchController()
  public onClickCell?: (model: CitySelectModel) => void // 点击cell
  public onClickTopCell?: (model: ESObject) => void // 点击cell

  build() {
    if (this.index == 0) {
      this.header()
    } else {
      Row() {
        Column() {
          Text(this.model.name)
            .fontSize(15)
            .fontColor(Color.Black)
            .margin({ left: 15 })
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .height('100%')
        .layoutWeight(1)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Top)
      .width('100%')
      .height(_cellHeight)
      .backgroundColor(Color.White)
      .onClick(() => this.onClickCell?.(this.model))
    }

  }

  @Builder
  header() {
    Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(10), cross: LengthMetrics.px(10) } }) {
      ForEach(this.topData, (item: ESObject, index: number) => {
        Button(item.name)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .fontColor(Color.Gray)
          .onClick(() => {
            this.onClickTopCell?.(item)
          })
      })
    }.margin({ bottom: 15 })
  }

  topData: ESObject = [
    { 'name': '北京市' },
    { 'name': '广州市' },
    { 'name': '成都市' },
    { 'name': '深圳市' },
    { 'name': '杭州市' },
    { 'name': '武汉市' },
  ];
}
