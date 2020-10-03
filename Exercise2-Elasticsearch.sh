#! /bin/bash
sudo apt-get update
sleep 3
echo "************installing Docker****************************************"
sudo apt-get install docker.io -y ##If not installed, pls enable it. 
echo "************Pulling Image for ElasticSearch**************************"
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.6.2
docker images
echo "************Launching ElasticSearch**********************************"
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.6.2
sleep 5
echo**************Exceuting Health check for elastic search*****************"
curl -X GET "http://localhost:9200/_cluster/health?wait_for_status=yellow&pretty"
