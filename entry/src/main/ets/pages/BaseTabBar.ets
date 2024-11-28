import { OnePage } from './one/OnePage';
import { TwoPage } from './two/TwoPage';
import { ThreePage } from './three/ThreePage';
import { FourPage } from './four/FourPage';

export interface TabType {
  text: string,
  imgPath: string,
  showBadge?: boolean,
}

@Preview
@Entry
@Component
export struct BaseTabBar {
  @State currentIndex: number = 0
  tabsController: TabsController = new TabsController()
  tabList: TabType[] = [{
    imgPath: 'tab/nav_tab_1',
    text: '微信',
  }, {
    text: '通讯录',
    imgPath: 'tab/nav_tab_2',
  }, {
    text: '发现',
    imgPath: 'tab/nav_tab_3',
    showBadge: true
  }, {
    text: '我的',
    imgPath: 'tab/nav_tab_4',
  }]

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        ForEach(this.tabList, (item: TabType, index: number) => {
          TabContent() {
            if (index == 0) {
              OnePage()
            } else if (index == 1) {
              TwoPage()
            } else if (index == 2) {
              ThreePage()
            } else {
              FourPage()
            }
          }
          .tabBar(this.TabBarBuilder(item.text, index, $rawfile(`${item.imgPath}.png`),
            $rawfile(`${item.imgPath}_on.png`), item.showBadge))
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
    .backgroundColor("#eeeeee")
    .width('100%')
    .height('100%')
  }

  @Builder
  TabBarBuilder(title: string, index: number, normalImg: Resource, selectedImg: Resource, showBadge?: boolean) {
    Column() {
      // Image(this.currentIndex == index ? selectedImg : normalImg)
      //   .width(24)
      //   .height(24)

      Badge({
        value: '',
        position: { x: 24 - 2.5, y: -2.5 },
        style: { badgeSize: showBadge && this.currentIndex != index ? 6 : 0, badgeColor: '#FA2A2D' }
      }) {
        Image(this.currentIndex == index ? selectedImg : normalImg)
          .width(24)
          .height(24)
      }

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