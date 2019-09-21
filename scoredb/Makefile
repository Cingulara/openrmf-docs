VERSION ?= 0.8
NAME ?= "openrmf-scoredb"
AUTHOR ?= "Dale Bingham"
PORT_EXT ?= 27017
PORT_INT ?= 27017
NO_CACHE ?= true
DOCKERHUB_ACCOUNT ?= cingulara
  
.PHONY: docker latest version dockerhub

docker: 
	docker build -f Dockerfile -t $(NAME)\:$(VERSION) --no-cache=$(NO_CACHE) .

latest: 
	docker build -f Dockerfile -t $(NAME)\:latest --no-cache=$(NO_CACHE) .
	docker tag $(NAME)\:latest ${DOCKERHUB_ACCOUNT}\/$(NAME)\:latest
	docker push ${DOCKERHUB_ACCOUNT}\/$(NAME)\:latest
  
version:
	@echo ${VERSION}

dockerhub:
	docker tag $(NAME)\:$(VERSION) ${DOCKERHUB_ACCOUNT}\/$(NAME)\:$(VERSION)
	docker push ${DOCKERHUB_ACCOUNT}\/$(NAME)\:$(VERSION)

DEFAULT: docker
