docker build -t mritunjayonemail/multi-client:latest -f ./client/Dockerfile ./client
docker build -t mritunjayonemail/multi-server:latest -f ./client/Dockerfile ./server
docker build -t mritunjayonemail/multi-worker:latest -f ./client/Dockerfile ./worker
docker push mritunjayonemail/multi-client:latest
docker push mritunjayonemail/multi-server:latest
docker push mritunjayonemail/multi-worker:latest

docker push mritunjayonemail/multi-client:$SHA
docker push mritunjayonemail/multi-server:$SHA
docker push mritunjayonemail/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mritunjayonemail/multi-server:$SHA
kubectl set image deployments/client-deployment client=mritunjayonemail/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mritunjayonemail/multi-worker:$SHA