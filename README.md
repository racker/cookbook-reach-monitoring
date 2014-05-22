Description
===========

Cookbook for creating Cloud Monitoring entities, base checks and alarms.

Recipes
=======

default
-------
This recipe includes the base_checks recipe and ensures that the monitoring agent runs in debug mode.


base_checks
-----------
This recipe installs the monitoring agent and creates the checks/alarms for the following:

* filesystem
* cpu_stolen
* cpu_io_wait
* memory_usage
* load_average
* ping
* ssh
