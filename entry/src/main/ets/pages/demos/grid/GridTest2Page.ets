import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct GridTest2Page {
  @State dataArr: ESObject[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 8; i++) {
      let map: Record<string, ESObject> = {};
      map['text'] = `这是功能${i}`;
      map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
      map['pushName'] = `PageName${i}`;
      dataArr.push(map);
    }
    return dataArr;
  }

  build() {
    Column() {
      BaseNavigation({ title: 'GridTest2 - 自定义cell' })
      Scroll() {
        Column() {
          this.header('header')
          this.body()
          this.header('footer')
        }
        .backgroundColor('#F8F8F8')
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
  }

  @Builder
  cell(item: ESObject) {
    Column() {
      Image(item['imageUrl']).width(50).height(50)
      Blank().height(10)
      Text(item['text'])
        .fontSize(13)
        .fontColor('#aabbcc')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .padding(15)
    .backgroundColor('#F2F3F7')
    .borderRadius(5)
    .onClick(() => {
      console.error('data', JSON.stringify(item))
    })
  }
}