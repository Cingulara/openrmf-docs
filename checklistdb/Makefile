VERSION ?= 0.7
NAME ?= "openrmf-checklistdb"
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
	docker login -u ${DOCKERHUB_ACCOUNT}
	docker tag $(NAME)\:latest ${DOCKERHUB_ACCOUNT}\/$(NAME)\:latest
	docker push ${DOCKERHUB_ACCOUNT}\/$(NAME)\:latest
	docker logout
 
version:
	@echo ${VERSION}

dockerhub:
	docker login -u ${DOCKERHUB_ACCOUNT}
	docker tag $(NAME)\:$(VERSION) ${DOCKERHUB_ACCOUNT}\/$(NAME)\:$(VERSION)
	docker push ${DOCKERHUB_ACCOUNT}\/$(NAME)\:$(VERSION)
	docker logout

DEFAULT: docker
