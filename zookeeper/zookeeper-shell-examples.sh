#!/bin/bash
# include zookeeper-shell examples
bin/zookeeper-shell.sh localhost:2181
# display help
help
# display root
ls / # displays what is at root.
create /my-node "foo" # create a node and put data "foo" in it.
ls / # will dispplay [zookeeper,my-node]
get /my-node # will fetch the data from the node and shows information about the data.
set /my-node "new data" # puts new data "new data" in the data node
get /zookeeper
create /my-node/deeper-node "bar" # creating a node inside node (sub nodes)
ls /
ls /my-node
ls /my-node/deeper-node
get /my-node/deeper-node

# update data version to see increased version counter
set /my-node/deeper-node "newdata"
get /my-node/deeper-node

# removes are recursive
rmr /my-node
ls /

# create a watcher
create /node-to-watch ""
get /node-to-watch true # if data is changed then some message comes up on terminal saying 
set /node-to-watch "has-changed" # that data has changed in this node. Happends only once.
rmr /node-to-watch
