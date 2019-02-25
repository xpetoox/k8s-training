docker build -t playdude/multi-client:latest -t playdude/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t playdude/multi-server:latest -t playdude/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t playdude/multi-worker:latest -t playdude/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push playdude/multi-client:latest
docker push playdude/multi-server:latest
docker push playdude/multi-worker:latest

docker push playdude/multi-client:$GIT_SHA
docker push playdude/multi-server:$GIT_SHA
docker push playdude/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=playdude/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=playdude/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=playdude/multi-worker:$GIT_SHA