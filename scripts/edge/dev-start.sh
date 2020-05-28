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
docker pull cingulara/openrmf-msg-system
docker pull cingulara/openrmf-templatedb
docker pull cingulara/openrmf-scoredb
docker pull cingulara/openrmf-checklistdb
docker pull cingulara/openrmf-api-template
docker pull cingulara/openrmf-msg-template
docker pull cingulara/openrmf-api-compliance
docker pull cingulara/openrmf-api-controls
docker pull cingulara/openrmf-api-audit
docker pull cingulara/openrmf-msg-audit
docker pull cingulara/openrmf-api-report
docker pull cingulara/openrmf-msg-report
docker pull nats:2.1.2-linux

# Now run the latest development openRMF stack
COMPOSE_PARALLEL_LIMIT=30 docker-compose up -d

# tell them the URL
echo ''
echo 'Run http://{ip-address}:8080/ to access openRMF'
echo ''
