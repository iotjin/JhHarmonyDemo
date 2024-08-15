import { BaseNavigation } from 'JhCommon';

interface TabType {
  text: string,
  imgPath: string,
}

@Entry
@Component
struct TestTabBar {
  @State message: string = 'Hello World'
  @State currentIndex: number = 0
  tabsController: TabsController = new TabsController()
  tabList: TabType[] = [{
    text: '微信',
    imgPath: 'tab/nav_tab_1',
  }, {
    text: '通讯录',
    imgPath: 'tab/nav_tab_2',
  }, {
    text: '发现',
    imgPath: 'tab/nav_tab_3',
  }, {
    text: '我的',
    imgPath: 'tab/nav_tab_4',
  }]

  build() {
    // $r("app.media.startIcon")
    // $rawfile("tab/nav_tab_1_on.png")

    Column() {
      BaseNavigation({ title: "TabBar" }) {
        Tabs({ barPosition: BarPosition.End }) {
          ForEach(this.tabList, (item: TabType, index: number) => {
            TabContent() {
              if (index == 0) {
                ContentPage({ text: '1' })
              } else if (index == 1) {
                ContentPage({ text: '2' })
              } else if (index == 2) {
                ContentPage({ text: '3' })
              } else {
                ContentPage({ text: '4' })
              }
            }
            .tabBar(this.TabBarBuilder(item.text, index, $rawfile(`${item.imgPath}.png`),
              $rawfile(`${item.imgPath}_on.png`)))
          })
        }
        .scrollable(false) //去掉左右滑动的效果
        .animationDuration(0) //去掉左右滑动的动画
        // .barHeight(156)
        .onChange((index: number) => {
          this.currentIndex = index
          this.tabsController.changeIndex(this.currentIndex)
        })
      }
    }
  }

  @Builder
  TabBarBuilder(title: string, index: number, normalImg: Resource, selectedImg: Resource) {
    Column() {
      Image(this.currentIndex == index ? selectedImg : normalImg)
        .width(24)
        .height(24)

      Text(title)
        .fontSize(14)
        .margin({ top: 4 })
        .fontColor(this.currentIndex == index ? '#45C461' : '#999999')
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height(50)
    .padding({ top: 6, bottom: 6 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .id(`tabBar${index}`)
  }
}


@Component
struct ContentPage {
  text: string = ""

  build() {
    RelativeContainer() {
      Text('Content' + this.text)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')

    // Scroll() {
    //   Column() {
    //     Text('111111111')
    //       .width('100%')
    //       .height(600)
    //       .backgroundColor(Color.Orange)
    //     Text('222222222')
    //       .width('100%')
    //       .height(500)
    //       .backgroundColor(Color.Yellow)
    //   }
    // }
  }
}