The configuration described below is designed for a performance testing use case; however, it may be a generally useful starting point for other use cases.

This setup establishes the following four services:
- Fedora
- PostgreSQL
- Prometheus
- Grafana

In this setup Fedora uses PostgreSQL as its rebuildable backend database.
Prometheus and Granfana are strictly used for collecting and displaying Fedora performance status, and can safely be removed if unwanted.

After starting these services, Fedora will be available at: http://host:8080/fcrepo/rest
- default username / password: fedoraAdmin / fedoraAdmin
Grafana will be available at: http://host:3000
- default username / password: admin / admin

# System Setup

1. [Install Docker](https://docs.docker.com/get-docker/)
1. Create a Fedora home directory for all repository persistence. This configuration expects:
   ```
   sudo mkdir -p /opt/fcrepo-home
   ```

# Start-up

1. Place following files in the same directory
   - [docker-compose.yml](docker-compose.yml)
   - [prometheus.yml](prometheus.yml)
   - [fcrepo.properties](fcrepo.properties)
1. **Note**: Mac users should use the following [docker-compose.yml](docker-compose-mac.yml) and [prometheus.yml](prometheus-mac.yml) files
1. Run, from directory containing the above files:
   ```
   docker-compose up
   ```

# Performance Tests

The performance tests use the [Apache JMeter](https://jmeter.apache.org/) tool.
Details on installation of JMeter and execution of various Fedora-related performance tests can be found in [this documentation](https://wiki.lyrasis.org/display/FF/Test+Guide+-+JMeter+Scripts).

Once JMeter is installed, an example test command is (where "fedora.jmx" comes from cloning the [fcrepo4-jmeter](https://github.com/fcrepo4-labs/fcrepo4-jmeter.git) project):
  ```
  nohup jmeter -Dfedora_4_context=/fcrepo/rest -Dcontainer_threads=4 -n -t fedora.jmx > test-out.txt
  ```

The above command assumes the following defaults, which can be changed as appropriate:
- `-Dfedora_4_username=<default=fedoraAdmin>`
- `-Dfedora_4_password=<default=fedoraAdmin>`
- `-Dfedora_4_server=<default=localhost>`

## Grafana

It is necessary to use Grafana's web-based interface to configure a dashboard for collecting and displaying Fedora metrics.
1. Log into http://host:3000, as "admin"/"admin"
1. Connect Grafana with Prometheus by clicking on "Add data source", inputing:
   ```
   http://localhost:9090
   ```
   - Submit with "Save & Test"
   - **Note**: Mac users should input `http://host.docker.internal:9090`
1. Import the example Fedora dashboard by hovering over the "plus" symbol on the left, and selecting "Import"
   - Upload [grafana-fcrepo.json](grafana-fcrepo.json)
1. You should now be able to navigate to "Example Fedora Dashboard"

