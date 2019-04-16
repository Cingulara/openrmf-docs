REM pull down the most recent :latest tags
docker pull cingulara/openstig-web:0.6
docker pull cingulara/openstig-api-read:0.6
docker pull cingulara/openstig-api-save:0.6
docker pull cingulara/openstig-api-upload:0.6
docker pull cingulara/openstig-api-scoring:0.6
docker pull cingulara/openstig-msg-score:0.6
docker pull cingulara/openstig-templatedb:0.3
docker pull cingulara/openstig-scoredb:0.3
docker pull cingulara/openstig-checklistdb:0.3
docker pull cingulara/openstig-api-template:0.6
docker pull cingulara/openstig-api-compliance:0.6
docker pull cingulara/openstig-api-controls:0.6

REM Now run the latest development openRMF stack
docker-compose -f stack.yml up -d