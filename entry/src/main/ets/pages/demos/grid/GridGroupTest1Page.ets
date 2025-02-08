import { BaseNavigation } from 'JhCommon'
import { JhCommonUtils } from 'JhCommon';


@Entry
@Preview
@Component
struct GridGroupTest1Page {
  @State dataArr: ESObject[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getData() {
    let dataArr: ESObject[] = [];
    const groupCount = JhCommonUtils.getRandomInt(10, 20)
    for (let i = 0; i < groupCount; i++) {
      let map: Record<string, ESObject> = {}
      map['groupName'] = `Group ${i}`
      let groups: ESObject = [];
      const maxCount = JhCommonUtils.getRandomInt(2, 8)
      for (let j = 0; j < maxCount; j++) {
        let item: Record<string, ESObject> = {}
        item['text'] = `功能${i}-${j}`
        item['subtitle'] = `subtitle-${i}-${j}`
        item['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png'
        groups.push(item)
      }
      map['groups'] = groups;
      dataArr.push(map);
    }
    return dataArr;
  }

  build() {
    Column() {
      BaseNavigation({ title: 'GridGroup1 - 分组' })
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
    List({ space: 0 }) {
      ForEach(this.dataArr, (item: ESObject, index: number) => {
        ListItemGroup({ header: this.itemHead(item['groupName']) }) {
          ListItem() {
            Grid() {
              ForEach(item['groups'], (groupItem: string, index2: number) => {
                GridItem() {
                  this.cell(groupItem, index2)
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
          }
        }
        .divider({ strokeWidth: 1, color: Color.Blue }) // 每行之间的分界线
      })
    }
    .layoutWeight(1)
    .sticky(StickyStyle.Header | StickyStyle.Footer)
    .scrollBar(BarState.Off)
  }

  @Builder
  itemHead(text: string) {
    Text(text)
      .fontSize(20)
      .backgroundColor(0xAABBCC)
      .width("100%")
      .padding(10)
  }

  @Builder
  cell(item: ESObject, index: number) {
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