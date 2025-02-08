import { BaseNavigation, JhColorUtils } from 'JhCommon'


@Entry
@Preview
@Component
struct GridTest3Page {
  scroller: Scroller = new Scroller()
  @State dataArr: ESObject[] = []
  @State maxRow: number = 2
  @State maxColumn: number = 5
  @State cellMargin: number = 5

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getRow() {
    return "1fr ".repeat(this.maxRow).trim()
  }

  getColumnWidth() {
    // return `calc((100% - 20vp) / 5)`
    return `calc((100% - ${this.cellMargin * (this.maxColumn - 1)}vp) / ${this.maxColumn})`
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 18; i++) {
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
      BaseNavigation({ title: 'GridTest3 - 横向滚动' })
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
    Column() {
      Grid(this.scroller) {
        ForEach(this.dataArr, (item: ESObject, index: number) => {
          GridItem() {
            // this.cell(item, index)
            Text(index.toString())
              .fontColor(Color.White)

          }
          .width(this.getColumnWidth())
          .backgroundColor(JhColorUtils.randomColor())
          .onClick(() => {
            console.error('data', JSON.stringify(item))
          })

          // .aspectRatio(1)
        })
      }
      .rowsTemplate(this.getRow())
      .height(300)
      .width('100%')
      .backgroundColor(Color.Yellow)
      .borderRadius(5)
      .columnsGap(this.cellMargin)
      .padding({ bottom: 15 })
      .scrollBar(BarState.Off) // 关闭滚动条

      // 自定义滚动条
      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Horizontal, // 横向滚动
        state: BarState.On // 持续显示
      }) {
        Row()
          .height(5)
          .width(20)
          .backgroundColor(Color.Orange)
          .borderRadius(3)
      }
      .width(50)
      .height(5)
      .backgroundColor('#e5e5e5')
      .borderRadius(3)
      .offset({ y: -10 })

    }
    .padding(10)
    .width('100%')
    .layoutWeight(1)
    .backgroundColor('#f5f5f5')
  }

  @Builder
  cell(item: ESObject, index: number) {
    Column() {
      Image(item['imageUrl']).width(30).height(30)
      Blank().height(10)
      Text(item['text'])
        .fontSize(13)
        .fontColor('#aabbcc')
        .textAlign(TextAlign.Center)
    }
    .padding(15)
    .backgroundColor('#F2F3F7')
    .borderRadius(5)
    .onClick(() => {
      console.error('data', JSON.stringify(item))
    })
  }
}