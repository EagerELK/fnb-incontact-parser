# Use Logstash to parse FNB InContact messages

This setup will pull First National Bank InContact emails from an IMAP email account, parse them, and post them to a simple Ruby app.

# Usage

~~~
vagrant up
~~~

You will be prompted for the following:

* Email hostname
* Email username
* Email password
* Email folder

# Further work

The idea is to extend this further to

* Track transactions day by day by categorizing transactions. Might event look at some kind of machine learning to do it.
* Analyze transactions using Elasticsearch
* Visualize transactions using Kibana
