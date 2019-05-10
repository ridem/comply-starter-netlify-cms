# Comply - Netlify CMS Starter Kit

[![Netlify Status](https://api.netlify.com/api/v1/badges/5a78d4de-72e1-48b2-9aa9-66964f06f67e/deploy-status)](https://app.netlify.com/sites/comply-netlify-cms/deploys)

Demo website: https://comply-netlify-cms.netlify.com

This repo contains an example comply site that is built with [Comply](https://comply.strongdm.com), and [Netlify CMS](https://www.netlifycms.org): **[Demo Link](https://comply-netlify-cms.netlify.com)**.

It follows the [JAMstack architecture](https://jamstack.org) by using Git as a single source of truth, and [Netlify](https://www.netlify.com) for continuous deployment, and CDN distribution.

## Features

- All features from [Comply](https://comply.strongdm.com)
- An easy process to have an always up-to-date compliance dashboard with the PDF files, served through a CDN
- Netlify can run the build command (see `run-comply.sh`) on demand through a webhook call, making it suitable for a daily call and tickets synchronization (Zapier or else)
- Ability to password-protect the whole deployed site (see Netlify options)
- Project is set up to not leak secrets (CVS tokens), comply.yml is generated out of comply.dist.yml
- Builds of this repo take around 1mn between git push and the publishing of the new site (Very fast!)
- Optionally, Netlify CMS can be used to handle the editing of the policies in a user-friendly way. See next section.

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/ridem/comply-starter-netlify-cms)

## Netlify CMS
The project also includes a Netlify CMS config file (See[config.yml](static/admin/config.yml)), and makes an admin interface available at /admin.

The git repository is used as the backend to retrieve the files, and saving a change is triggering a push of the changes on the publishing branch (`master` here)

Ask for an invite then visit https://comply-netlify-cms.netlify.com/admin to see how this works.

Some screenshots:
![Admin Dashboard](.github/admin_dashboard.png?raw=true "Admin Dashboard")
![Admin Edit](.github/admin_edit.png?raw=true "Admin Edit")