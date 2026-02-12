# SSH Tips

## Configure SSH Passwordless Login

### At source PC

#### 1. Edit SSH config file

Edit `~/.ssh/config` file and add the following configuration:

```ssh-config
Host Tako
  HostName 192.168.1.1
  User heng
```

#### 2. Copy SSH public key to target host

```bash
ssh-copy-id Tako
```

After execution, you can log in to Tako without password.

#### 3. Sync files using rsync

```bash
rsync -ah --info=progress2 \
  /source/dir/ \
  TargetHost:/target/dir/
```
