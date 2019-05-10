# Comply - Netlify CMS Starter Kit

[![Netlify Status](https://api.netlify.com/api/v1/badges/5a78d4de-72e1-48b2-9aa9-66964f06f67e/deploy-status)](https://app.netlify.com/sites/comply-netlify-cms/deploys)

Demo website: https://comply-netlify-cms.netlify.com

This repo contains an example comply site that is built with [Comply](https://comply.strongdm.com), and [Netlify CMS](https://www.netlifycms.org): **[Demo Link](https://comply-netlify-cms.netlify.com)**.

It follows the [JAMstack architecture](https://jamstack.org) by using Git as a single source of truth, and [Netlify](https://www.netlify.com) for continuous deployment, and CDN distribution.

## Features

- All features from [Comply](https://comply.strongdm.com)
- An easy process to have an always up-to-date compliance dashboard with the PDF files, served through a CDN
- Netlify can run the build command (see `run-comply.sh`) on demand through a webhook call, making it suitable for a daily call and tickets synchronization (Zapier or else)
- Project is set up to not leak secrets (CVS tokens), comply.yml is generated out of comply.dist.yml
- Builds of this repo take around 1mn between git push and the publishing of the new site (Very fast!)
- Optionally, Netlify CMS can be used to handle the editing of the policies (Visit https://comply-netlify-cms.netlify.com/admin and ask for an invite to see how this works)

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/ridem/comply-starter-netlify-cms)

Here's the readme template from comply:

# Sample Organization Compliance Program

This repository consolidates all documents related to the Sample Organization Compliance Program.

# Structure

Compliance documents are organized as follows:

```
narratives/     Narratives provide an overview of the organization and the compliance environment.
policies/       Policies govern the behavior of employees and contractors.
procedures/     Procedures prescribe specific steps that are taken in response to key events.
standards/      Standards specify the controls satisfied by the compliance program.
templates/      Templates control the output format of the HTML Dashboard and PDF assets.
```

# Building

Assets are built using [`comply`](https://comply.strongdm.com), which can be installed via `brew install comply` (macOS) or `go get github.com/strongdm/comply`

# Publishing

The `output/` directory contains all generated assets. Links in the HTML dashboard a relative, and all dependencies are included via direct CDN references. The entire `output/` directory therefore may be uploaded to an S3 bucket or other static asset host without further modification.

# Dashboard Status

Procedure tracking is updated whenever `comply sync` is invoked. Invoke a sync prior to `comply build` to include the most current ticket status.

# Procedure Scheduler

Any `procedures/` that include a `cron` schedule will automatically created in your configured ticketing system whenever `comply scheduler` is executed. The scheduler will backfill any overdue tickets.