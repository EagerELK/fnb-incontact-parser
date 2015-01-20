# Ansible Role: Logstash

An Ansible Role that installs Logstash on RedHat/CentOS Debian/Ubuntu.

No configurations are added when using this role. There are, however, three example config files that can be activated
by uncommenting them in the `defaults/mail.yml` file:

* 01-local-syslog-input.conf - An example input.
* 50-syslog-filter.conf - An example filter.
* 70-elasticsearch-output.conf - An example output.

## Requirements

None

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

## Dependencies

None

## Example Playbook

    - hosts: search
      roles:
        - ansible-role-logstash

## License

MIT / BSD

## Author Information

This role was created in 2014 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/) and ammended by [Jrgns](http://jrgns.net), maintainer of [EagerELK](http://eagerelk.com).
