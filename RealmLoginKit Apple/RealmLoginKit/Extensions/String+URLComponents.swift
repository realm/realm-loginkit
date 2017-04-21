////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
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

import Foundation

public extension String {

    public var URLScheme: String? {
        guard let schemeRange = self.range(of: "://") else { return nil }
        return self.substring(to: schemeRange.lowerBound)
    }

    public var URLPortNumber: Int {
        guard let portRange = self.range(of: ":", options: .backwards) else { return -1 }

        let startIndex = self.index(portRange.upperBound, offsetBy: 0)
        let endIndex = self.index(portRange.upperBound, offsetBy: 2)
        guard self[startIndex...endIndex] != "//" else { return -1 }

        return Int(self.substring(from: portRange.upperBound))!
    }

    public var URLHost: String {
        var host = self

        if let scheme = self.URLScheme {
            host = host.substring(from: self.index(self.startIndex, offsetBy: (scheme + "://").characters.count))
        }

        if let portRange = host.range(of: ":") {
            host = host.substring(to: portRange.lowerBound)
        }

        return host
    }
}
