# Kafka
These notes come mainly from [Kafka courses from Confluent](https://developer.confluent.io/learn-kafka). 

## Durability, Availability, and Ordering Guarantees
See [Confluent course](https://developer.confluent.io/learn-kafka/architecture/guarantees/) and ["Kafka Acks Explained"](https://accu.org/journals/overload/28/159/kozlovski/) on this topic.

There are two producer settings that are involved in durability
* acks=0 – the write is considered successful the moment the request is sent out. No need to wait for a response.
* acks=1 – the leader must receive the record and respond before the write is considered successful.
* acks=all – all online in sync replicas must receive the write. If there are less than min.insync.replicas online, then the write won’t be processed.
