# safe-local-exec
safe-local-exec provisoner introduces an environment to provide controlled execution of commands on the hosts. This is achieved by introducing a new parameter `timeout` in the schema. The configured timeout will be in the seconds. The command execution on the host  will be killed by sending `SIGKILL` if the command excution time exceeds the timout limit configured

## Example

```tf
resource "null_resource" "safe-local-exec-test" {

  provisioner "safe-local-exec" {
    command = "ping localhost -c 100"
    timeout = 10
  }
}
```

## Build

```bash
make clean; make build
```