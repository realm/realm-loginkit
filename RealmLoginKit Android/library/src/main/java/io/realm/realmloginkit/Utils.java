package io.realm.realmloginkit;

class Utils {
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
