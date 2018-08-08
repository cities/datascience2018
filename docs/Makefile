
.PHONY: build
build:
	R -e 'rmarkdown::render_site(encoding = "UTF-8")'

push: build
	git status && \
	git commit -a -m"Updated website" && \
	git push

unbind:
	lsof -wni tcp:4000

serve:
	hugo server --watch
