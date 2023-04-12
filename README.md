# esm.sh – fork

Go to the [original repo](https://github.com/esm-dev/esm.sh) for its docs – this README just explains the fork.

## Where is it used?

We use esm.sh to load dependencies for blocks in the demo sandbox, e.g. the [Code block](https://blockprotocol.org/@hash/blocks/code).

The code that does this is [here](https://github.com/blockprotocol/blockprotocol/blob/main/apps/site/src/pages/api/rewrites/sandboxed-block-demo.api.ts).

## Why the fork?

esm.sh is a great project, but it has some stability issues. Updates occasionally break the packages we are using it to import,
which means that the fail to load, breaking both user-facing pages and our CI (which test the block pages).

## Deployment

The code in the repo is built to a Dockerfile and deployed to AWS's ECS.

This process is not automated, instead:
1. Build the image
1. Test the image locally (see below)
1. Tag the image as latest for the relevant repository
1. Push it to the repository
1. Force a new deployment of the ECS service

To test the built Docker image before deploying:
1. `docker run -p 80:80 bp-esm` (you can expose a different port but amend the command below)
1. Visit `localhost` and check you see the homepage
1. In the `blockprotocol` repo, set `ESM_CDN_URL="http://localhost"` in `.env.local`
1. Run `yarn dev` in the `blockprotocol` repo to start the site
1. Visit a block page and check it works, e.g. http://localhost:3000/@hash/blocks/code

## TODO

If we want to stick with this approach and need to update this, we should probably:
1. Move this config into the `blockprotocol` repo, e.g. 
    - add the Dockerfile and the config.json there
    - have the Dockerfile checkout the `esm.sh` repo at a specific, known-working tag
1. Automate deployment
