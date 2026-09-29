# Ubuntu Desktop for Maxlayer

Ubuntu 22.04 + XFCE + TigerVNC + noVNC.

## Maxlayer

Use:

- Application port: `80`
- HTTP
- No extra domain is required by this repository.
- Open the application's Maxlayer URL and append `/vnc.html`

Example:

`http://YOUR-MAXLAYER-URL/vnc.html`

## Default desktop

- Resolution: `1280x720`
- Desktop: XFCE
- User: `ubuntu`
- sudo: enabled without password inside the container
- VNC security: disabled because the service is intended to sit behind Maxlayer's application URL.

## Optional environment variables

- `WIDTH=1280`
- `HEIGHT=720`
- `DEPTH=24`
- `DISPLAY_NUM=1`

Example:

`WIDTH=1600`

`HEIGHT=900`

## Repository files

- `Dockerfile` - builds the Ubuntu desktop image
- `start.sh` - starts TigerVNC and noVNC on port 80
- `xstartup` - starts XFCE
