@Entry
@Component
struct TestNavigation {
  // menus(value: Array<NavigationMenuItem> | CustomBuilder): NavigationAttribute

  aboutToAppear() {
    console.log('CustomComponent: aboutToAppear called. Component is about to appear.')
    // 在这里执行初始化数据的操作
  }

  build() {
    Column() {
      this.NavigationTest()
    }
  }

  TooTmp: NavigationMenuItem = {
    'value': "1",
    'action': () => {
    },
    'icon': "resources/rawfile/tab/nav_tab_1.png",
  }
  TooBar: ToolbarItem[] = [this.TooTmp, this.TooTmp, this.TooTmp]

  @Builder
  NavigationTest() {
    Navigation() {
      RelativeContainer() {
        Text('Content')
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
    .titleMode(NavigationTitleMode.Mini)
    .title("标题栏") // 设置title，此时不支持修改文字大小，颜色等样式
    .hideBackButton(false)
    .menus([this.TooTmp, this.TooTmp, this.TooTmp])
    .toolbarConfiguration(this.TooBar)

    // .size({ width: '100%', height: '100%' })
    // .backgroundColor(Color.Orange)
    // .toolbarConfiguration(this.TooBar)
  }
}