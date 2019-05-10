# Comply - Netlify CMS Starter Kit

[![Netlify Status](https://api.netlify.com/api/v1/badges/5a78d4de-72e1-48b2-9aa9-66964f06f67e/deploy-status)](https://app.netlify.com/sites/comply-netlify-cms/deploys)

Demo website: https://comply-netlify-cms.netlify.com

This repo contains an example comply site that is built with [Comply](https://comply.strongdm.com), and [Netlify CMS](https://www.netlifycms.org): **[Demo Link](https://comply-netlify-cms.netlify.com)**.

It follows the [JAMstack architecture](https://jamstack.org) by using Git as a single source of truth, and [Netlify](https://www.netlify.com) for continuous deployment, and CDN distribution.

## Features

- All features from [Comply](https://comply.strongdm.com)
- An easy process to have an always up-to-date compliance dashboard with the PDF files, served through a CDN
- Netlify builds (see [run-comply.sh](run-comply.sh)) are triggered automatically on pushes to master. They can also be triggered on-demand through a simple webhook HTTP call, making it suitable for a daily call and tickets synchronization (Zapier or else)
- Project is set up to not leak secrets (e.g. CVS tokens), comply.yml is generated out of comply.dist.yml from secrets stored on Netlify
- Builds of this repo take around 1mn between git push and the publishing of the new site (Very fast!)
- Leveraging on Netlify's numerous site protection options (Google, Github, Bitbucket, Gitlab OAuth providers are supported out of the box) to restrict access to the site.
- Optionally, Netlify CMS can be used to handle the editing of the policies in a user-friendly way. See next section.

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/ridem/comply-starter-netlify-cms&stack=cms)

## Netlify CMS
The project also includes a Netlify CMS config file (See [config.yml](static/admin/config.yml)), and makes an admin interface available at /admin.

The git repository is used as the backend to retrieve the files of master, and saving the changes is triggering a push of the changes on the publishing branch (`master` here). The user performing the action can be logged in commits.

On Github, there's the also possibility to add a kanban-style Draft/Review/Approved page (Workflow menu) that mirrors Pull Requests, so changes aren't published to master directly.
Github policies about protected branches (approval needed, etc.) are still enforced through Netlify CMS.

Ask for an invite then visit https://comply-netlify-cms.netlify.com/admin to see how this works.

Some screenshots:
![Admin Dashboard](.github/admin_dashboard.png?raw=true "Admin Dashboard")

![Admin Edit](.github/admin_edit.png?raw=true "Admin Edit")