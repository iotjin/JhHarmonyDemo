///  WxContactsPage.ets
///
///  Created by iotjin on 2024/11/20.
///  description: 微信通讯录

import { router } from '@kit.ArkUI'
import { pinyin } from 'pinyin-pro';
import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { WxContactsModel } from '../models/WxContactsModel'
import { WxContactsCell } from '../widgets/WxContactsCell'
import data from '../../../pages/res/wx_contacts.json'


@Entry
@Preview
@Component
export struct WxContactsPage {
  @State dataArr: ESObject[] = []
  // @State tagIndexList: string[] = ['🔍', '★', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
  //   'H', 'I', 'J', 'K', 'L', 'M', 'N',
  //   'O', 'P', 'Q', 'R', 'S', 'T', 'U',
  //   'V', 'W', 'X', 'Y', 'Z', '#']
  @State tagIndexList: string[] = []
  // scroller: Scroller = new Scroller()
  scroller: ListScroller = new ListScroller()
  searchController: SearchController = new SearchController()
  @State selectedIndex: number = 0
  @State isShowTagPopup: boolean = false
  @State contactsCount: string = ''

  aboutToAppear() {
    this.dataArr = this.loadData()
    // console.error('data', JSON.stringify(this.dataArr))

    let tempList: string[] = [];
    for (let i = 0; i < this.dataArr.length; i++) {
      const item: ESObject = this.dataArr[i];
      tempList.push(item['groupName'])
    }
    this.tagIndexList = tempList;
  }

  build() {
    Column() {
      BaseNavigation({
        isGradient: true,
        title: '通讯录',
        leftItem: {},
        rightImgPath: $rawfile("images/ic_addFriend.png"),
        rightItemCallBack: () => {
          this.searchController.stopEditing()
          router.pushUrl({ url: 'pages/two/pages/WxAddFriendPage' })
        },
      })
      this.body()
    }
  }

  @Builder
  body() {
    Stack({ alignContent: Alignment.End }) {
      List({ space: 0, initialIndex: 0, scroller: this.scroller }) {
        ForEach(this.dataArr, (groupItem: ESObject, index: number) => {
          ListItemGroup({ header: this.itemHeader(groupItem.groupName) }) {
            ForEach(groupItem.data, (cellItem: string, index2: number) => {
              ListItem() {
                WxContactsCell({
                  index: index,
                  model: cellItem as WxContactsModel,
                  searchController: this.searchController,
                  onClickCell: (model: WxContactsModel) => {
                    console.log('点击cell', JSON.stringify(cellItem))
                    this.searchController.stopEditing()
                    router.pushUrl({ url: 'pages/two/pages/WxUserInfoPage', params: { data: cellItem } })
                  },
                  onClickTopCell: (model: ESObject) => {
                    this.searchController.stopEditing()
                    this.clickCell(model['title'])
                  },
                })
              }
              .swipeAction({
                end: {
                  builder: () => {
                    if (index != 0) {
                      this.itemSwipeEnd()
                    }
                  },
                  actionAreaDistance: 0, // 设置组件长距离滑动删除距离阈值。 默认56
                  onAction: () => {
                    animateTo({ duration: 1000 }, () => {
                    })
                  },
                }
              })
            }, (item: string) => item)
          }
          // 每行之间的分界线
          .divider({
            strokeWidth: 0.6,
            startMargin: 65,
            endMargin: 0,
            color: KColors.kFormLineColor,
          })
        })
        ListItem() {
          this.footer()
        }
      }
      .height('100%')
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring, {
        alwaysEnabled: true
      })
      .backgroundColor(Color.White)
      .sticky(StickyStyle.Header | StickyStyle.Footer)
      .scrollBar(BarState.Off)
      .onScrollIndex((firstIndex: number, lastIndex: number) => {
        // console.log('firstIndex', JSON.stringify(firstIndex))
        this.selectedIndex = firstIndex
      })

      AlphabetIndexer({ arrayValue: this.tagIndexList, selected: 0 })
        .color(Color.Black)// 文字颜色
        .selectedColor(Color.White)// 选中项文字颜色
        .popupColor(Color.White)// 提示弹窗文字颜色
        .selectedBackgroundColor(KColors.kThemeColor)// 选中项背景颜色
        .popupBackground('#C9C9C9')// 提示弹窗背景色
        .usingPopup(this.isShowTagPopup)// 是否使用提示弹窗
        .selectedFont({ size: 16, weight: FontWeight.Bolder })// 选中项字体样式
        .popupFont({ size: 30, weight: FontWeight.Bolder })// 弹出框内容的字体样式
        .font({ size: 14 })// 字母索引条默认字体样式
        .itemSize(22)// 字母索引条字母区域大小
        .alignStyle(IndexerAlign.END)// 字母索引条弹框的对齐样式，支持弹窗显示在索引条右侧和左侧.默认值: IndexerAlign.END
        .popupPosition({ x: 60, y: 48 })
        .itemBorderRadius(11)//索引项背板圆角半径
        .popupBackgroundBlurStyle(BlurStyle.NONE)// 设置提示弹窗的背景模糊材质
        .selected(this.selectedIndex)
        .onSelect((index: number) => {
          // console.log('index', index)
          console.log(this.tagIndexList[index] + ' Selected!')
          // const findIndex = this.dataArr.findIndex((item: ESObject) => item['groupName'] == this.tagIndexList[index]);
          // console.log('findIndex', JSON.stringify(findIndex))
          this.scroller.scrollToIndex(index)
          this.isShowTagPopup = true;
          setTimeout(() => {
            this.isShowTagPopup = false;
          }, 3000)
        })
        .onPopupSelect((index: number) => {
          console.info('onPopupSelected:' + index)
        })
    }
    .layoutWeight(1)
  }

  @Builder
  itemHeader(text: string) {
    if (text == '🔍') {
      Row()
    } else {
      Row() {
        Text(text == '★' ? '★ 星标朋友' : text)
          .padding({ left: 15 })
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isFloat(text) ? KColors.wxPayColor : '#777777')
      }
      .width("100%")
      .height(30)
      .backgroundColor(KColors.wxBgColor)
    }
  }

  isFloat(text: string) {
    return this.tagIndexList[this.selectedIndex] == text
  }

  @Builder
  itemSwipeEnd() {
    Row() {
      Text('备注')
        .fontSize(14)
        .fontColor(Color.White)
    }
    .width('25%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#74736D')
    .onClick(() => {
      JhProgressHUD.showToast('点击备注')
      this.scroller.closeAllSwipeActions()
    })
  }

  @Builder
  footer() {
    Row() {
      Text(`${this.getData().length} 位朋友及联系人`)
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(KColors.wxBgColor)
  }

  clickCell(text: string) {
    console.log('点击', JSON.stringify(text))
    if (text == '新的朋友') {
      router.pushUrl({ url: 'pages/two/pages/WxNewFriendPage' })
    }
    if (text == '群聊') {
      router.pushUrl({ url: 'pages/two/pages/WxGroupChatPage' })
    }
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

    // 改成分组数据
    const newArr: ESObject[] = groupListByKey(tempList, 'tagIndex');
    return newArr
  }

  getData() {
    let dataArr: ESObject[] = data['data']
    return dataArr;
  }
}

// 数组按指定key分组
function groupListByKey<T>(array: T[], key: string): ESObject[] {
  const result: ESObject[] = [];
  const groupMap: Map<string, T[]> = new Map();

  // 遍历数组，将每个元素按照key分组
  array.forEach((item: ESObject) => {
    const groupValue = String(item[key]);
    if (!groupMap[groupValue]) {
      groupMap[groupValue] = [];
    }
    groupMap[groupValue].push(item);
  });

  Object.keys(groupMap).forEach((key) => {
    result.push({ groupName: key, data: groupMap[key] });
  });
  return result;
}
