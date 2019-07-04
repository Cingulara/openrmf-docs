REM remove older Docker images for openSTIG
docker rmi -f cingulara/openstig-api-controls:0.6
docker rmi -f cingulara/openstig-api-read:0.6
docker rmi -f cingulara/openstig-api-compliance:0.6
docker rmi -f cingulara/openstig-web:0.6
docker rmi -f cingulara/openstig-api-upload:0.6
docker rmi -f cingulara/openstig-api-template:0.6
docker rmi -f cingulara/openstig-api-save:0.6
docker rmi -f cingulara/openstig-msg-score:0.6
docker rmi -f cingulara/openstig-api-scoring:0.6
docker rmi -f cingulara/openstig-checklistdb:0.3
docker rmi -f cingulara/openstig-templatedb:0.3
docker rmi -f cingulara/openstig-scoredb:0.3

REM remove older Docker images for openRMF
docker rmi -f cingulara/openrmf-api-controls:0.7
docker rmi -f cingulara/openrmf-api-read:0.7
docker rmi -f cingulara/openrmf-api-compliance:0.7
docker rmi -f cingulara/openrmf-web:0.7
docker rmi -f cingulara/openrmf-api-upload:0.7
docker rmi -f cingulara/openrmf-api-template:0.7
docker rmi -f cingulara/openrmf-api-save:0.7
docker rmi -f cingulara/openrmf-msg-score:0.7
docker rmi -f cingulara/openrmf-api-scoring:0.7
docker rmi -f cingulara/openrmf-checklistdb:0.7
docker rmi -f cingulara/openrmf-templatedb:0.7
docker rmi -f cingulara/openrmf-scoredb:0.7