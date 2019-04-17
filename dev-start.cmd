REM pull down the most recent :latest tags
docker pull cingulara/openrmf-web
docker pull cingulara/openrmf-api-read
docker pull cingulara/openrmf-api-save
docker pull cingulara/openrmf-api-upload
docker pull cingulara/openrmf-api-scoring
docker pull cingulara/openrmf-msg-score
docker pull cingulara/openrmf-templatedb
docker pull cingulara/openrmf-scoredb
docker pull cingulara/openrmf-checklistdb
docker pull cingulara/openrmf-api-template
docker pull cingulara/openrmf-api-compliance
docker pull cingulara/openrmf-api-controls
docker pull nats

REM Now run the latest development openRMF stack
docker-compose -f dev-stack.yml up -d

REM tell them the URL
ECHO "Run http://localhost:9080/ to access openRMF"