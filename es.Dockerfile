FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.4
FROM docker.elastic.co/kibana/kibana:6.5.4
# RUN elasticsearch-plugin install analysis-kuromoji