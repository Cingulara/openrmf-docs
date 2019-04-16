# pull down the most recent :latest tags
docker pull cingulara/openrmf-web:0.7
docker pull cingulara/openrmf-api-read:0.7
docker pull cingulara/openrmf-api-save:0.7
docker pull cingulara/openrmf-api-upload:0.7
docker pull cingulara/openrmf-api-scoring:0.7
docker pull cingulara/openrmf-msg-score:0.7
docker pull cingulara/openrmf-templatedb:0.7
docker pull cingulara/openrmf-scoredb:0.7
docker pull cingulara/openrmf-checklistdb:0.7
docker pull cingulara/openrmf-api-template:0.7
docker pull cingulara/openrmf-api-compliance:0.7
docker pull cingulara/openrmf-api-controls:0.7

# Now run the latest development openRMF stack
docker-compose -f stack.yml up -d