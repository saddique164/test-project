sed "s/tagVersion/${env.BUILD_ID}/g" deployments.yaml > deployment-new.yaml