import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct TestNav {
  dataArr: ItemType[] = [
    { label: 'Navigation', value: 'pages/demos/ui/TestNavigation' },
    { label: 'nav-只有title', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-左侧返回，右侧文字', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-左侧返回(拦截点击事件)，右侧图片', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-左侧自定义右侧文字', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-设置背景色', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-设置透明背景色', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-渐变导航条', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-右侧自定义1', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-右侧自定义2', value: 'pages/demos/ui/TestBaseNavigation' },
    { label: 'nav-child', value: 'pages/demos/ui/TestBaseNavigation' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: '导航条', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          let passParams: Object = Object({
            label: str,
          })
          router.pushUrl({ url: this.dataArr[index].value, params: passParams })
        }
      })
    }
  }
}