import { ItemType, JhDialog, JhPickerTool, JhProgressHUD, JhTextList } from 'JhCommon';


const stringArr = ['11', '22', '33', '44']
const dictArr: ItemType[] = [
  { 'label': '类型一', 'value': '1' },
  { 'label': '类型二', 'value': '2' },
  { 'label': '类型三', 'value': '3' },
]

const stringArr2 = [
  ['11', '22'],
  ['33', '44'],
]
const dictArr2: ItemType[][] = [
  [
    { 'label': '大类一', 'value': '1' },
    { 'label': '大类二', 'value': '2' },
    { 'label': '大类三', 'value': '3' },
  ],
  [
    { 'label': '小类一', 'value': '11' },
    { 'label': '小类二', 'value': '22' },
  ],
]

const stringArr3 = [
  ['11', '22'],
  ['33', '44'],
  ['55', '66']
]

const dictArr3: ItemType[][] = [
  [
    { 'label': '大类一', 'value': '1' },
    { 'label': '大类二', 'value': '2' },
    { 'label': '大类三', 'value': '3' },
  ],
  [
    { 'label': '中类一', 'value': '1' },
    { 'label': '中型二', 'value': '2' },
    { 'label': '中型三', 'value': '3' },
    { 'label': '中型四', 'value': '4' },
  ],
  [
    { 'label': '小类一', 'value': '1' },
    { 'label': '小类二', 'value': '2' },
  ],
]

@Entry
@Component
struct PickerTestPage {
  dataArr: ESObject[] = [
    { label: 'BottomSheet-不带标题' },
    { label: 'BottomSheet-带标题' },
    { label: 'BottomSheet-红色按钮' },
    { label: 'JhPickerTool-单列（字符串数组）' },
    { label: 'JhPickerTool-单列（对象数组）' },
    { label: 'JhPickerTool-两列（字符串数组）' },
    { label: 'JhPickerTool-两列（对象数组）' },
    { label: 'JhPickerTool-三列（字符串数组）' },
    { label: 'JhPickerTool-三列（对象数组）' },
  ]

  aboutToAppear() {
    // 初始化
    let uiContext: UIContext = this.getUIContext()
    JhDialog.initConfig(uiContext)
  }

  build() {
    Scroll() {
      Column() {
        JhTextList({
          title: '底部弹框示例', dataArr: this.dataArr, callBack: (index, str) => {
            if (str === 'BottomSheet-不带标题') {
              JhPickerTool.showBottomSheet({
                data: ['hello', 'world', '123'],
                clickCallback: (index, text) => {
                  console.error('index', index)
                  console.error('text', text)
                  JhProgressHUD.showToast(text)
                }
              })
            }
            if (str === 'BottomSheet-带标题') {
              JhPickerTool.showBottomSheet({
                title: '请选择',
                data: ['hello', 'world', '123'],
                clickCallback: (index, text) => {
                  console.error('index', index)
                  console.error('text', text)
                  JhProgressHUD.showToast(text)
                }
              })
            }
            if (str === 'BottomSheet-红色按钮') {
              JhPickerTool.showBottomSheet({
                title: '请选择操作',
                data: [{
                  value: "保存本地",
                  fontSize: 18
                }, {
                  value: "删除",
                  fontColor: Color.Red,
                  fontSize: 18
                }],
                clickCallback: (index, text) => {
                  console.error('index', index)
                  console.error('text', text)
                  JhProgressHUD.showToast(text)
                }
              })
            }

            if (str == 'JhPickerTool-单列（字符串数组）') {
              JhPickerTool.showStringPicker({
                data: stringArr,
                title: '请选择类型',
                selectIndex: 1,
                onCancel: () => {
                  console.error(`点击了取消按钮`)
                },
                onConfirm: (selectValue, selectIndex: Number) => {
                  console.error(`点击了确认按钮`)
                  console.error('selectValue:', selectValue)
                  console.error('selectIndex:', selectIndex)
                  JhProgressHUD.showToast(selectValue.toString())
                },
              })
            }
            if (str == 'JhPickerTool-单列（对象数组）') {
              JhPickerTool.showStringPicker({
                data: dictArr,
                title: '请选择',
                labelKey: 'label',
                selectIndex: 2,
                onCancel: () => {
                  console.error(`点击了取消按钮`)
                },
                onConfirm: (selectValue, selectIndex: Number) => {
                  console.error(`点击了确认按钮`)
                  console.error('selectValue:', JSON.stringify(selectValue))
                  console.error('selectValue-label:', selectValue['label'])
                  console.error('selectIndex:', selectIndex)
                  JhProgressHUD.showToast(JSON.stringify(selectValue))
                },
              })
            }
            if (str == 'JhPickerTool-两列（字符串数组）') {
              JhPickerTool.showArrayPicker({
                data: stringArr2,
                title: '请选择',
                selectIndex: [0, 1],
                onCancel: () => {
                  console.error(`点击了取消按钮`)
                },
                onConfirm: (selectItemArr, selectIndexArr: Number[]) => {
                  console.error(`点击了确认按钮`)
                  console.error('selectItemArr:', JSON.stringify(selectItemArr))
                  console.error('selectIndexArr:', JSON.stringify(selectIndexArr))
                  JhProgressHUD.showToast(JSON.stringify(selectItemArr))
                },
              })
            }
            if (str == 'JhPickerTool-两列（对象数组）') {
              JhPickerTool.showArrayPicker({
                data: dictArr2,
                title: '请选择',
                selectIndex: [1, 1],
                labelKey: 'label',
                onCancel: () => {
                  console.error(`点击了取消按钮`)
                },
                onConfirm: (selectItemArr, selectIndexArr: Number[]) => {
                  console.error(`点击了确认按钮`)
                  console.error('selectItemArr:', JSON.stringify(selectItemArr))
                  console.error('selectIndexArr:', JSON.stringify(selectIndexArr))
                  JhProgressHUD.showToast(JSON.stringify(selectItemArr))
                },
              })
            }
            if (str == 'JhPickerTool-三列（字符串数组）') {
              JhPickerTool.showArrayPicker({
                data: stringArr3,
                title: '请选择',
                selectIndex: [0, 1, 0],
                onCancel: () => {
                  console.error(`点击了取消按钮`)
                },
                onConfirm: (selectItemArr, selectIndexArr: Number[]) => {
                  console.error(`点击了确认按钮`)
                  console.error('selectItemArr:', JSON.stringify(selectItemArr))
                  console.error('selectIndexArr:', JSON.stringify(selectIndexArr))
                  JhProgressHUD.showToast(JSON.stringify(selectItemArr))
                },
              })
            }
            if (str == 'JhPickerTool-三列（对象数组）') {
              JhPickerTool.showArrayPicker({
                data: dictArr3,
                title: '请选择',
                selectIndex: [1, 2, 1],
                labelKey: 'label',
                onCancel: () => {
                  console.error(`点击了取消按钮`)
                },
                onConfirm: (selectItemArr, selectIndexArr: Number[]) => {
                  console.error(`点击了确认按钮`)
                  console.error('selectItemArr:', JSON.stringify(selectItemArr))
                  console.error('selectIndexArr:', JSON.stringify(selectIndexArr))
                  JhProgressHUD.showToast(JSON.stringify(selectItemArr))
                },
              })
            }

          }
        })

      }
    }
  }
}
