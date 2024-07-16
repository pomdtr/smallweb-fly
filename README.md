# Smallweb on fly.io (with SSH)

## Edit the `fly.toml` file

Set a custom name for your app, and make sure to choose an appropriate region.

## Usage

```sh
# install fly CLI
curl -L https://fly.io/install.sh | sh

# login to fly
fly auth login

# create a new app
fly launch --no-deploy

# Add your public ssh key as a secret
fly secrets set "AUTHORIZED_KEYS=$(cat ~/.ssh/id_rsa.pub)"

# deploy the app
fly deploy
```

If everything went well, you should see an hello world message when visiting your app URL.

Your home directory is saved as a volume, so it will persist between deploys.

You can ssh to your vm using `ssh fly@<app-name>.fly.dev`.

## Adding a custom domain

```sh
fly certs create '*.pomdtr.me'
```

You can check the status of your certificates with `fly certs show <hostname>`.

You can then update your DNS records to point to the IP address of your app, and update the `smallweb config` to use your custom domain.

```jsonc
// ~/.config/smallweb/config.json
{
    "domains": {
        "smallweb.fly.dev": "~/smallweb.fly.dev",
        "*.pomdtr.me": "~/pomdtr.me"
    }
}
```

The best editing experience can be achieved by using [mutagen](https://mutagen.io/) tool.

```sh
# sync the local directory ~/pomdtr.me with the remote directory /home/fly/pomdtr.me
mutagen create --name=fly --ignore-vcs ~/pomdtr.me fly@<app-name>.fly.dev:/home/fly/pomdtr.me
```
