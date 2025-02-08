import { BaseNavigation, KColors } from 'JhCommon'

interface TimeTable {
  title: string;
  projects: string[];
}

@Entry
@Preview
@Component
struct ListGroupTest1Page {
  @State dataArr: TimeTable[] = [
    {
      title: '星期一',
      projects: ['语文', '数学', '英语']
    },
    {
      title: '星期二',
      projects: ['物理', '化学', '生物']
    },
    {
      title: '星期三',
      projects: ['历史', '地理', '政治']
    },
    {
      title: '星期四',
      projects: ['美术', '音乐', '体育']
    },
    {
      title: '星期五',
      projects: ['语文', '数学', '英语']
    },
    {
      title: '星期六',
      projects: ['历史', '地理', '政治']
    }
  ]

  aboutToAppear() {
    console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({ title: 'ListGroup1 - 分组' })
      Scroll() {
        Column() {
          this.header('header')
          this.body()
          this.header('footer')
        }
        .backgroundColor(KColors.wxBgColor)
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
    List({ space: 20 }) {
      ForEach(this.dataArr, (item: ESObject, index: number) => {
        ListItemGroup({ header: this.itemHead(item.title), footer: this.itemFoot(item.projects.length) }) {
          ForEach(item.projects, (project: string, index2: number) => {
            ListItem() {
              this.cell(project, index2)
            }
          }, (item: string) => item)
        }
        .divider({ strokeWidth: 1, color: Color.Blue }) // 每行之间的分界线
      })
    }
    .layoutWeight(1)
    .sticky(StickyStyle.Header | StickyStyle.Footer)
    .scrollBar(BarState.Off)

    // .divider({
    //   strokeWidth: 1,
    //   startMargin: 15,
    //   endMargin: 15,
    //   color: Color.Orange,
    // })
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
  itemFoot(num: number) {
    Text('共' + num + "节课")
      .fontSize(16)
      .backgroundColor(0xAABBCC)
      .width("100%")
      .padding(5)
  }

  @Builder
  cell(item: ESObject, index: number) {
    Text(item)
      .width("100%")
      .height(100)
      .fontSize(20)
      .textAlign(TextAlign.Center)
      .backgroundColor(0xFFFFFF)

  }
}