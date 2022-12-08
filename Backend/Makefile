.PHONY: run-docker
run-docker:
	docker-compose up

.PHONY: check-container
check-docker-container:
	docker ps -a

.PHONY: delete-all-container
delete-all-container:
	docker stop $(docker ps -q)
	docker rm $(docker ps -q -a)

.PHONY: reRun-docker
reRun-docker:
	docker-compose up --build