# pull down the most recent :latest tags
docker pull cingulara/openrmf-web
docker pull cingulara/openrmf-api-read
docker pull cingulara/openrmf-api-save
docker pull cingulara/openrmf-api-upload
docker pull cingulara/openrmf-api-scoring
docker pull cingulara/openrmf-msg-score
docker pull cingulara/openrmf-msg-compliance
docker pull cingulara/openrmf-msg-controls
docker pull cingulara/openrmf-msg-checklist
docker pull cingulara/openrmf-templatedb
docker pull cingulara/openrmf-scoredb
docker pull cingulara/openrmf-checklistdb
docker pull cingulara/openrmf-api-template
docker pull cingulara/openrmf-msg-template
docker pull cingulara/openrmf-api-compliance
docker pull cingulara/openrmf-api-controls
docker pull nats:1.4.1-linux

# Now run the latest development openRMF stack
docker-compose up -d

# tell them the URL
echo ''
echo 'Run http://{ip-address}:8080/ to access openRMF'
echo ''
