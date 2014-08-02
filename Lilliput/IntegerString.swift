//
// IntegerString.swift
// Lilliput
//
// Copyright (c) 2014 Justin Kolb - https://github.com/jkolb/Lilliput
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

protocol ConvertableInteger : IntegerArithmetic {
    func toInt() -> Int
    init(_ v: Int)
}

extension Int8 : ConvertableInteger {
    func toInt() -> Int { return Int(self) }
}

extension UInt8 : ConvertableInteger {
    func toInt() -> Int { return Int(self.asSigned()) }
}

extension Int16 : ConvertableInteger {
    func toInt() -> Int { return Int(self) }
}

extension UInt16 : ConvertableInteger {
    func toInt() -> Int { return Int(self.asSigned()) }
}

extension Int32 : ConvertableInteger {
    func toInt() -> Int { return Int(self) }
}

extension UInt32 : ConvertableInteger {
    func toInt() -> Int { return Int(self.asSigned()) }
}

extension Int64 : ConvertableInteger {
    func toInt() -> Int { return Int(self) }
}

extension UInt64 : ConvertableInteger {
    func toInt() -> Int { return Int(self.asSigned()) }
}

extension Int : ConvertableInteger {
    func toInt() -> Int { return self }
}

extension UInt : ConvertableInteger {
    func toInt() -> Int { return self.asSigned() }
}

func hex<T: ConvertableInteger>(value: T) -> String {
    return pad(format(value, 16), "0", sizeof(T) * 2)
}

func binary<T: ConvertableInteger>(value: T) -> String {
    return pad(format(value, 2), "0", sizeof(T) * 8)
}

func octal<T: ConvertableInteger>(value: T, length: Int = 0) -> String {
    return pad(format(value, 8), "0", length)
}

func base36<T: ConvertableInteger>(value: T, length: Int = 0) -> String {
    return pad(format(value, 36), "0", length)
}

func format<T: ConvertableInteger>(value: T, base: Int) -> String {
    assert(base >= 02, "Base must be from 2 to 36")
    assert(base <= 36, "Base must be from 2 to 36")
    let digit = [
        "0", "1", "2", "3", "4", "5",
        "6", "7", "8", "9", "A", "B",
        "C", "D", "E", "F", "G", "H",
        "I", "J", "K", "L", "M", "N",
        "O", "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y", "Z",
    ]
    var string = ""
    var nextValue = value
    let typedBase = T(base)
    let typedZero = T(0)
    do {
        let index = (nextValue % typedBase).toInt()
        string = digit[index] + string
        nextValue /= typedBase
    } while (nextValue > typedZero)
    return string
}

func pad(string: String, padChar: Character, length: Int) -> String {
    let count = countElements(string)
    if (count >= length) { return string }
    let padding = String(count: length - count, repeatedValue: padChar)
    return padding + string
}