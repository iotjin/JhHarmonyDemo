import { BaseNavigation, KColors } from 'JhCommon'
import data from '../../res/wx_contacts.json'
import { pinyin } from 'pinyin-pro';
import { util } from '@kit.ArkTS'


@Entry
@Preview
@Component
export struct ListGroupTest2Page {
  @State dataArr: ESObject[] = []
  private value: string[] = ['🔍', '★', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z', '#']
  scroller: Scroller = new Scroller()

  aboutToAppear() {
    this.dataArr = this.loadData()
    // console.error('data', JSON.stringify(this.dataArr))

    const pyStr = pinyin('汉语拼音1', { toneType: 'none' })
    console.log('汉字转拼音：', `汉语拼音1 to ${pyStr}`)
  }

  build() {
    Column() {
      BaseNavigation({
        title: 'ListGroup2 - 通讯录'
      })
      Scroll() {
        Column() {
          this.body()
        }
        .backgroundColor(KColors.wxBgColor)
      }
      .layoutWeight(1)
    }
  }

  @Builder
  body() {
    Row() {
      List({ space: 0, initialIndex: 0, scroller: this.scroller }) { //加载列表
        ForEach(this.dataArr, (item: ESObject, index) => {
          ListItem() {
            Column() {
              if (index == 0 || this.dataArr[index-1].tagIndex != item.tagIndex) {
                Text(item.tagIndex)
                  .width('100%')
                  .fontColor('#333333')
                  .fontSize(14)
                  .backgroundColor(Color.Orange)
                  .padding({
                    top: 5, bottom: 5, left: 15
                  })
              }

              Text(item.name)
                .fontSize(30)
                .padding({
                  top: 15, bottom: 15, left: 15
                })
            }.alignItems(HorizontalAlign.Start)
          }
        }, (item: ESObject) => util.generateRandomUUID(true)) //key随机生成
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .height('100%')
      .divider({
        color: '#E5E5E5',
        strokeWidth: 0.5
      })
      .sticky(StickyStyle.Header | StickyStyle.Footer)

      AlphabetIndexer({ arrayValue: this.value, selected: 0 })
        .selectedColor(0xFFFFFF)// 选中项文本颜色
        .popupColor(0xFFFAF0)// 弹出框文本颜色
        .selectedBackgroundColor(0xCCCCCC)// 选中项背景颜色
        .popupBackground(0xD2B48C)// 弹出框背景颜色
        .usingPopup(false)// 是否显示弹出框
        .selectedFont({ size: 16, weight: FontWeight.Bolder })// 选中项字体样式
        .popupFont({ size: 30, weight: FontWeight.Bolder })// 弹出框内容的字体样式
        .itemSize(22)// 每一项的尺寸大小
        .alignStyle(IndexerAlign.Left)//弹出框在索引条右侧弹出
        .onSelect((index: number) => {
          console.info(this.value[index] + ' Selected!')
          this.onSelectIndexItem(this.value[index]);
        })
    }

  }

  onSelectIndexItem(index: string) {
    for (let i = 0; i < this.dataArr.length; i++) {
      console.log("名字：" + this.dataArr[i].name + " index1:" + this.dataArr[i].tagIndex + " index2:" + index)
      if (this.dataArr[i].tagIndex == index) {
        this.scroller.scrollToIndex(i) //滚动到索引位置
        break;
      }
    }
  }

  clickCell(item: ESObject) {
    console.log('item', JSON.stringify(item))
  }

  loadData() {
    // 原始数据
    const dataArr: ESObject[] = this.getData()

    // 处理数据
    let tempList: ESObject[] = [];
    for (let i = 0; i < dataArr.length; i++) {
      const item: ESObject = dataArr[i]
      const pinyinStr = pinyin(item.name, { toneType: 'none' })
      const tag = pinyinStr.substring(0, 1).toUpperCase();
      item.namePinyin = pinyinStr;
      if (item.isStar == true) {
        item.tagIndex = '★';
      } else if (new RegExp('[A-Z]').test(tag)) {
        item.tagIndex = tag;
      } else {
        item.tagIndex = '#';
      }
      tempList.push(item);
    }

    // 根据A-Z排序
    tempList.sort((a: ESObject, b: ESObject) => {
      if (a['tagIndex'] === b['tagIndex']) {
        return a['name'].localeCompare(b['name']) as number
      }
      if (a['tagIndex'] === "#") {
        return 1
      }
      if (b['tagIndex'] === "#") {
        return -1
      }
      return a['tagIndex'].localeCompare(b['tagIndex']) as number
    });

    // 把星标移到最前
    tempList.forEach((item: ESObject, index) => {
      if (item.isStar == true) {
        tempList.unshift(...tempList.splice(index, 1));
      }
    });

    // 添加 header
    tempList.unshift({
      name: "header",
      tagIndex: "🔍"
    });

    console.log('tempList', JSON.stringify(tempList))
    return tempList
  }

  getData() {
    let dataArr: ESObject[] = data['data']
    return dataArr;
  }
}