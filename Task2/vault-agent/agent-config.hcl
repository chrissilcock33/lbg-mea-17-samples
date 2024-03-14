pid_file = "./pidfile"

    auto_auth {
        method "kubernetes" {
            mount_path = "auth/kubernetes"
            config = {
                role = "example"
            }
        }

    }

    template {
    destination = "/etc/secrets/index.html"
    contents = <<EOT
    <html>
    <body>
    <p>Some secrets:</p>
    {{- with secret "kv2/data/test" }}
    <ul>
    <li><pre>username: {{ .Data.data.username }}</pre></li>
    <li><pre>password: {{ .Data.data.password }}</pre></li>
    </ul>
    {{ end }}
    </body>
    </html>
    EOT
    }