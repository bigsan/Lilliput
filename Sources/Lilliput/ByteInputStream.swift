/*
 The MIT License (MIT)
 
 Copyright (c) 2018 Justin Kolb
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

public protocol ByteInputStream {
    func readUInt8()  throws -> UInt8
    func readUInt16() throws -> UInt16
    func readUInt32() throws -> UInt32
    func readUInt64() throws -> UInt64
    func read(bytes: UnsafeMutableRawPointer, count: Int) throws
}

extension ByteInputStream {
    public func readInt8()  throws -> Int8  { return Int8 (bitPattern: try readUInt8() ) }
    public func readInt16() throws -> Int16 { return Int16(bitPattern: try readUInt16()) }
    public func readInt32() throws -> Int32 { return Int32(bitPattern: try readUInt32()) }
    public func readInt64() throws -> Int64 { return Int64(bitPattern: try readUInt64()) }
    
    public func readFloat32() throws -> Float32 { return Float32(bitPattern: try readUInt32()) }
    public func readFloat64() throws -> Float64 { return Float64(bitPattern: try readUInt64()) }
}
