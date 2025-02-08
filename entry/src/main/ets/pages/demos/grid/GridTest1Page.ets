import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct GridTest1Page {
  @State dataArr: ESObject[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 30; i++) {
      dataArr.push(`${i}`);
    }
    return dataArr;
  }

  build() {
    Column() {
      BaseNavigation({ title: 'GridTest1 - 假数据' })
      Scroll() {
        Column() {
          this.header('header')
          this.body()
          this.header('footer')
        }
        .backgroundColor(Color.Yellow)
      }
      .layoutWeight(1)
    }
  }

  @Builder
  header(text: string) {
    Row() {
      Text(text).fontColor(Color.White)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Orange)
  }

  @Builder
  body() {
    Grid() {
      ForEach(this.dataArr, (item: ESObject, index: number) => {
        GridItem() {
          this.cell(item)
        }
      })
    }
    .columnsTemplate("1fr 1fr 1fr") // 设置3列，每列均分
    .columnsGap(5) // 设置列间距
    .rowsGap(5) // 设置行间距
    .margin({
      top: 5,
      bottom: 5,
      left: 5,
      right: 5
    })
    .width('100% - 10')
    .layoutWeight(1)
    .backgroundColor(Color.Yellow)
  }

  @Builder
  cell(item: ESObject) {
    Text(item)
      .fontSize(20)
      .backgroundColor("#aabbcc")
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(100)// .height(`calc(100% / 5)`)
      .onClick(() => {
        console.error('data', JSON.stringify(item))
      })
  }
}