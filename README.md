# Hybrid Integration Reference Architecture

IT environments are becoming hybrid in nature; most businesses use cloud computing as part of their overall IT environment. While businesses continue to operate enterprise applications, processes, and systems of record on premises, they are rapidly developing cloud-native applications on cloud. The [hybrid integration reference architecture](https://www.ibm.com/cloud/garage/content/architecture/integrationServicesDomain/) describes an approach to connect components which are split across cloud and on-premises environments, or across public and private clouds -- even across different cloud providers.


This repository is also linked to the [Event Driven Architecture](https://github.com/ibm-cloud-architecture/refarch-eda) repository where integration between microservices is supported by using event backbone and pub/sub integration pattern.

We recommend reading the full content using [the book format here](https://ibm-cloud-architecture.github.io/refarch-integration).  

### Building this booklet locally

The content of this repository is written with markdown files, packaged with [MkDocs](https://www.mkdocs.org/) and can be built into a book-readable format by MkDocs build processes.

1. Install MkDocs locally following the [official documentation instructions](https://www.mkdocs.org/#installation).
1. Install Material plugin for mkdocs:  `pip install mkdocs-material` 
2. `git clone https://github.com/ibm-cloud-architecture/refarch-integration.git` _(or your forked repository if you plan to edit)_
3. `cd refarch-integration`
4. `mkdocs serve`
5. Go to `http://127.0.0.1:8000/` in your browser.

### Pushing the book to GitHub Pages

1. Ensure that all your local changes to the `master` branch have been committed and pushed to the remote repository.
   1. `git push origin master`
2. Ensure that you have the latest commits to the `gh-pages` branch, so you can get others' updates.
	```bash
	git checkout gh-pages
	git pull origin gh-pages
	
	git checkout master
	```
3. Run `mkdocs gh-deploy` from the root refarch-da directory.

--- 

## Contribute

We welcome your contributions. There are multiple ways to contribute: report bugs and improvement suggestion, improve documentation and contribute code.
We really value contributions and to maximize the impact of code contributions we request that any contributions follow these guidelines:

The [contributing guidelines are in this note.](./CONTRIBUTING.md)


## Contributors
* Lead development [Jerome Boyer](https://www.linkedin.com/in/jeromeboyer/) -
* [Prasad Imandi](https://www.linkedin.com/in/prasadimandi)
* [Zach Silverstein](https://www.linkedin.com/in/zsilverstein/)

Please [contact me](mailto:boyerje@us.ibm.com) for any questions.
