jss_chef Cookbook
===================
This cookbook installs and configures Jamf Pro.

Prerequisites
-------------

You will need to host your own HTTP(S) repo to serve the Jamf Pro ROOT.war files. These will need to be re-named to reflect the version number with a syntax of ${version}.war, i.e. 9.93.war.

Attributes
----------

e.g.
#### jss_chef::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jss_chef']['MaxMemory']</tt></td>
    <td>Integer</td>
    <td>Maximum amount of memory to allocate to Tomcat</td>
    <td><tt>1024</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['maxThreads']</tt></td>
    <td>Integer</td>
    <td>Maximum number of Tomcat threads</td>
    <td><tt>225</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['MaxPoolSize']</tt></td>
    <td>Integer</td>
    <td>Maximum number of simultanious database connections</td>
    <td><tt>1024</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['sessionTimeout']</tt></td>
    <td>Integer</td>
    <td>Session timeout in minutes</td>
    <td><tt>30</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['LogPath']</tt></td>
    <td>String</td>
    <td>Path to store JSS log files</td>
    <td><tt>/var/log/jss</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['ServerName']</tt></td>
    <td>String</td>
    <td>FQDN of database server</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['DataBaseName']</tt></td>
    <td>String</td>
    <td>Name of JSS database</td>
    <td><tt>jamfsoftware</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['DataBaseUer']</tt></td>
    <td>String</td>
    <td>Username with access to JSS Database</td>
    <td><tt>jamfsoftware</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['DataBasePassword']</tt></td>
    <td>String</td>
    <td>Username with access to JSS Database</td>
    <td><tt>jamfsw03</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['jssversion']</tt></td>
    <td>String</td>
    <td>Name of JSS database</td>
    <td><tt>9.93</tt></td>
  </tr>
  <tr>
    <td><tt>['jss_chef']['DownloadURL']</tt></td>
    <td>String</td>
    <td>URL where JSS ROOT.war can be downloaded</td>
    <td><tt>http://localhost</tt></td>
  </tr>
</table>

Usage
-----
#### jss_chef::default

Just include `jss_chef` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jss_chef]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Authors
-------------------
Authors: kitzy
