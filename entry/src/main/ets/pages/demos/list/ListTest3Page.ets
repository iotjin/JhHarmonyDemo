import { BaseNavigation } from 'JhCommon'


@Entry
@Preview
@Component
struct ListTest1Page {
  @State dataArr: ESObject[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    console.error('data', JSON.stringify(this.dataArr))
  }

  getData() {
    let dataArr: ESObject[] = [];
    for (let i = 0; i < 35; i++) {
      let map: Record<string, ESObject> = {};
      map['title'] = `title${i}`;
      map['content'] = `这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容${i}`;
      map['phone'] = `${i}${i}${i} xxxxxxx`;
      map['imageUrl'] = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
      map['place'] = `place${i}`;
      map['state'] = `流转中${i}`;
      dataArr.push(map);
    }
    return dataArr;
  }

  build() {
    Column() {
      BaseNavigation({ title: 'ListTest3 - 自定义cell1' })
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
    List() {
      ForEach(this.dataArr, (item: ESObject, index: number) => {
        ListItem() {
          this.cell(item)
        }
      })
    }
    .layoutWeight(1)
    .divider({
      strokeWidth: 1,
      startMargin: 15,
      endMargin: 15,
      color: Color.Orange,
    })
  }

  @Builder
  cell(item: ESObject) {
    Column() {
      Row() {
        Text(item['place']).fontSize(18)
        Row() {
          Text(item['state']).fontSize(15)
          Blank().width(10)
          Image(item['imageUrl']).width(30).height(30)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(6)
      Text(item['phone']).fontSize(15)
      Blank().height(6)
      Text(item['content']).fontSize(15)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(15)
  }
}