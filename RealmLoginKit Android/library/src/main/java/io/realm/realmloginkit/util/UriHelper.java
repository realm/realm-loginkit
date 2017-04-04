/*
 * Copyright 2017 Realm Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.realm.realmloginkit.util;

public class UriHelper {
    public static String getValidAuthUri(String uri) {
        String scheme = "http";
        String host = uri;
        String path = "/auth";
        int port = 9080;

        final String delimiter = "://";
        final int schemeEnd = uri.indexOf("://");
        if (schemeEnd != -1) {
            final String lowerCase = uri.toLowerCase();
            if (lowerCase.startsWith("https") || lowerCase.startsWith("realms")) {
                port = 9443;
                scheme = "https";
            }
            host = host.substring(schemeEnd + delimiter.length());
        }

        final int pathStart = host.indexOf('/');
        if (pathStart != -1) {
            path = host.substring(pathStart);
            host = host.substring(0, pathStart);
        }

        final int portStart = host.indexOf(":");
        if (portStart != -1) {
            port = Integer.parseInt(host.substring(portStart + 1));
            host = host.substring(0, portStart);
        }

        final String authUri = String.format("%1$s://%2$s:%3$d%4$s", scheme, host, port, path);
        return authUri;
    }
}
