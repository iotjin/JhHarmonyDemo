import { router } from '@kit.ArkUI';
import { JhTextList, ItemType } from 'JhCommon';

@Entry
@Component
struct FormDemoListPage {
  dataArr: ItemType[] = [
    { label: 'JhLoginTextInput', value: 'pages/demos/form/FormLoginTextInputTestPage' },
    { label: 'JhFormInputCell', value: 'pages/demos/form/FormInputCellTestPage' },
    { label: 'JhFormSelectCell', value: 'pages/demos/form/FormSelectCellTestPage' },
    { label: 'JhSetCell', value: 'pages/demos/form/SetCellTestPage' },
  ]

  build() {
    Scroll() {
      JhTextList({
        title: 'JhForm', dataArr: this.dataArr, callBack: (index, str) => {
          console.log(index.toString() + str)
          router.pushUrl({ url: this.dataArr[index].value })
        }
      })
    }
  }
}
