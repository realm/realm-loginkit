////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Realm

extension RLMRealm {
    @nonobjc public class func schemaVersion(at url: URL, usingEncryptionKey key: Data? = nil) throws -> UInt64 {
        var error: NSError?
        let version = __schemaVersion(at: url, encryptionKey: key, error: &error)
        guard version != RLMNotVersioned else {
            throw error!
        }
        return version
    }

    public func objects<T: RLMObject>(ofType: T.Type, where predicateFormat: String, _ args: CVarArg...) -> RLMResults<T> {
        return T.objects(in: self, with: NSPredicate(format: predicateFormat, arguments: getVaList(args))) as! RLMResults<T>
    }
}

public final class RLMIterator: IteratorProtocol {
    private var iteratorBase: NSFastEnumerationIterator

    internal init(collection: RLMCollection) {
        iteratorBase = NSFastEnumerationIterator(collection)
    }

    public func next() -> RLMObject? {
        return iteratorBase.next() as! RLMObject?
    }
}

// Sequence conformance for RLMArray and RLMResults is provided by RLMCollection's
// `makeIterator()` implementation.
extension RLMArray: Sequence {}
extension RLMResults: Sequence {}

extension RLMCollection {
    // Support Sequence-style enumeration
    public func makeIterator() -> RLMIterator {
        return RLMIterator(collection: self)
    }
}

extension RLMCollection {
    // Swift query convenience functions
    public func indexOfObject(where predicateFormat: String, _ args: CVarArg...) -> UInt {
        return indexOfObject(with: NSPredicate(format: predicateFormat, arguments: getVaList(args)))
    }

}
