import { BaseNavigation, JhAESPreferencesUtils, JhButton, JhEncryptUtils, JhFormInputCell, KColors } from 'JhCommon';

@Entry
@Component
struct AESTestPage {
  @State textStr: string = '123';
  @State base64encodeStr: string = '';
  @State base64decodeStr: string = '';
  @State aesEncryptStr: string = '';
  @State aesDecryptStr: string = '';
  @State md5Str: string = '';

  aboutToAppear() {
    this.test(this.textStr)
    this.storageTest()
  }

  build() {
    Column() {
      BaseNavigation({ title: 'base64、AES、MD5和本地加密存储' })
      Scroll() {
        Column() {
          this.body()
        }
        .height('100%')
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring, {
        alwaysEnabled: true
      })
    }
  }

  @Builder
  body() {
    JhFormInputCell({
      title: '明文',
      placeholder: '请输入要加密的文字',
      text: this.textStr,
      inputCallBack: (value) => {
        this.textStr = value as string
      },
    })
    Blank().height(10).backgroundColor(KColors.wxBgColor)
    JhFormInputCell({
      title: 'Base64编码',
      text: this.base64encodeStr,
    }).enabled(false)
    JhFormInputCell({
      title: 'Base64解码',
      text: this.base64decodeStr,
    }).enabled(false)
    JhFormInputCell({
      title: 'AES加密',
      text: this.aesEncryptStr,
    }).enabled(false)
    JhFormInputCell({
      title: 'AES解密',
      text: this.aesDecryptStr,
    }).enabled(false)
    JhFormInputCell({
      title: 'MD5加密',
      text: this.md5Str,
    }).enabled(false)
    JhFormInputCell({
      text: '本地加密存储请看控制台输出',
    }).enabled(false)
    Blank().height(30)
    JhButton({
      text: '更 新',
      onPressed: (): void => this.test(this.textStr)
    }).margin(15)
  }

  test(str: string) {
    console.error('-------------------数据加解密-------------------')
    const text = str
    console.error(`明文：${text}`)

    const base64encodeStr = JhEncryptUtils.encodeBase64(text)
    console.error(`base64编码: ${base64encodeStr}`)
    const base64decodeStr = JhEncryptUtils.decodeBase64(base64encodeStr)
    console.error(`base64解码: ${base64decodeStr}`)

    const enStr = JhEncryptUtils.aesEncrypt(text)
    console.error(`AES 加密：${enStr}`)
    const deStr = JhEncryptUtils.aesDecrypt(enStr)
    console.error(`AES 解密：${deStr}`)

    const md5 = JhEncryptUtils.encodeMd5(text)
    console.error(`md5 ：${md5}`)


    this.textStr = str
    this.base64encodeStr = base64encodeStr
    this.base64decodeStr = base64decodeStr
    this.aesEncryptStr = enStr
    this.aesDecryptStr = deStr
    this.md5Str = md5
  }

  storageTest() {
    console.error('-------------------本地加密存储-------------------')
    JhAESPreferencesUtils.saveString('testStr', '这是测试本地加密存储的字符串')
    const testStr = JhAESPreferencesUtils.getString('testStr')
    console.error(`testStr : ${testStr}`)

    JhAESPreferencesUtils.saveBool('testBool', true)
    const testBool = JhAESPreferencesUtils.getBool('testBool')
    console.error(`testBool : ${testBool}`)

    JhAESPreferencesUtils.saveNumber('testInt', 1111)
    const testInt = JhAESPreferencesUtils.getNumber('testInt')
    console.error(`testInt : ${testInt}`)

    JhAESPreferencesUtils.saveNumber('testDouble', 222.333354)
    const testDouble = JhAESPreferencesUtils.getNumber('testDouble')
    console.error(`testDouble : ${testDouble}`)

    const dic = { 'a': 'aaa', 'b': 'bbb', 'c': 'ccc' } as Record<string, string>
    console.error('原始dic', JSON.stringify(dic))
    JhAESPreferencesUtils.saveModel('testDic', dic)
    const testDic = JhAESPreferencesUtils.getModel('testDic')
    console.error('testDic', JSON.stringify(testDic))

    // 取不存在的key
    console.error('-------------------取不存在的key----------------------')

    const testStr2 = JhAESPreferencesUtils.getString('testStr222')
    console.error(`testStr2原始 : ${testStr2}`)
    const test = testStr2 == '' ? '1' : '2222'
    console.error(test)
    console.error(`testStr2 : ${testStr2}`)

    const testBool2 = JhAESPreferencesUtils.getBool('testBool222')
    console.error(`testBool2 : ${testBool2}`)

    const testInt2 = JhAESPreferencesUtils.getNumber('testInt222')
    console.error(`testInt2: ${testInt2}`)

    const testDouble2 = JhAESPreferencesUtils.getNumber('testDouble222')
    console.error(`testDouble2 : ${testDouble2}`)

    const testDic2 = JhAESPreferencesUtils.getModel('testDic222')
    console.error(`testDic2 : ${testDic2}`)
  }
}