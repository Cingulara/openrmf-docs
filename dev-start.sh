# pull down the most recent :latest tags
docker pull cingulara/openrmf-web
docker pull cingulara/openstig-api-read
docker pull cingulara/openstig-api-save
docker pull cingulara/openstig-api-upload
docker pull cingulara/openstig-api-scoring
docker pull cingulara/openstig-msg-score
docker pull cingulara/openstig-templatedb
docker pull cingulara/openstig-scoredb
docker pull cingulara/openstig-checklistdb
docker pull cingulara/openstig-api-template
docker pull cingulara/openstig-api-compliance
docker pull cingulara/openstig-api-controls
docker pull nats

# Now run the latest development openRMF stack
docker-compose -f dev-stack.yml up -d