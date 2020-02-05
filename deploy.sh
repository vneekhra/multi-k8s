docker build -t vneekhra/multi-client:latest -t vneekhra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vneekhra/multi-server:latest -t vneekhra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vneekhra/multi-worker:latest -t vneekhra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vneekhra/multi-client:latest
docker push vneekhra/multi-server:latest
docker push vneekhra/multi-worker:latest

docker push vneekhra/multi-client:$SHA
docker push vneekhra/multi-server:$SHA
docker push vneekhra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=vneekhra/multi-server:$SHA
kubectl set image deployment/client-deployment client=vneekhra/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=vneekhra/multi-worker:$SHA