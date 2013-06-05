require('../libs/utils')


describe "Array Spec", ->

  it "any", ->
    isEven = (x) -> x % 2 == 0
    expect([1, 3, 5].any(isEven)).toBe false
    expect([1, 2, 5].any(isEven)).toBe true


describe "String Spec", ->

  it "endsWith return false", ->
    expect("aaa.aaa".endsWith(".aab")).toBe false

  it "endsWith return false", ->
    expect("aaa.aaa".endsWith(".aab")).toBe false

  it "isImage", ->
    expect("aaa.jpg".isImage()).toBe true
    expect("aaa.xxx".isImage()).toBe false
