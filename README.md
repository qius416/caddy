# caddy

A [Docker](http://docker.com) image for [Caddy](http://caddyserver.com).

## config

** mount the folder contain your caddy file: -v /somefolder:/config
** mount log folder -v /logfolder:/log
** mount root folder -v /root:/srv

## Tls

** a self signed certificate is contained in /cert folder. For local test purpose just add tls direct into caddyfile

##### Run the image

```sh
$ docker run -d --name caddy -v $(pwd)/conf:/conf -v $(pwd)/log:/log -v $(pwd)/srv:/srv -p 80:80 -p 443:443 caddy
```
### Let's Encrypt Auto SSL
**Note** that this does not work on local environments.

Use a valid domain and add email to your Caddyfile to avoid prompt at runtime.
Replace `mydomain.com` with your domain and `user@host.com` with your email.
```
mydomain.com
tls user@host.com
```

##### Run the image

You can change the the ports if ports 80 and 443 are not available on host. e.g. 81:80, 444:443

```sh
$ docker run -d \
    -v $(pwd)/Caddyfile:/etc/Caddyfile \
    -p 80:80 -p 443:443 \
    abiosoft/caddy
```

**Optional** but advised. Save certificates on host machine to prevent regeneration every time container starts.
Let's Encrypt has [rate limit](https://community.letsencrypt.org/t/rate-limits-for-lets-encrypt/6769).
```sh
$ docker run -d \
    -v $(pwd)/Caddyfile:/etc/Caddyfile \
    -v $HOME/.caddy:/root/.caddy \
    -p 80:80 -p 443:443 \
    caddy
```
