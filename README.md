# Smallweb on fly.io

## Usage

First, you'll need to update some field in the fly.toml:

- `app`: the name of your app (`smallweb` is already taken by me :P)
- `primary_region`: choose the datacenter closest to you
- `env.SMALLWEB_DOMAIN`: an apex domain you own

Then, run the following commands:

```sh
# install fly CLI
curl -L https://fly.io/install.sh | sh

# login to fly
fly auth login

# deploy the app
fly launch
```

If everything went well, you should see an hello world message when visiting your app URL.

Your home directory is saved as a volume, so it will persist between deploys.

## Set an admin username and password

In order to protect the built in webdav server and cli, you'll need to set an admin username and password.

```sh
fly secrets set SMALLWEB_AUTH_USERNAME=admin
fly secrets set SMALLWEB_AUTH_PASSWORD=password
```

## Adding a custom domain

Replace `example.com` with your domain name.

```sh
# create a certificate for your APEX domain
fly certs create 'example.com'
# create a wildcard certificate for your domain
fly certs create '*.example.com'
```

You can check the status of your certificates with `fly certs show <hostname>` (the wildcard certificates can take a few dozen minutes to be issued).

You can then update your DNS records to point to the IP address of your app (see <https://fly.io/docs/networking/custom-domain/>)

You'll be able to edit your files by using the webdav server running at `webdav.<your-domain>`.
