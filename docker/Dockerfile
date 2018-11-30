# Dockerfile for Traditional WAS 8.5.5 to add db2 driver and brown compute apps
FROM ibmcom/websphere-traditional:8.5.5.14-profile
COPY ./db2jcc4.jar /tmp
COPY ./refarch-integration-inventory-dal.war /tmp
RUN wsadmin.sh -lang jython -conntype NONE -c "AdminApp.install('/tmp/refarch-integration-inventory-dal.war', '[ -appname InventoryDAL -contextroot /inventory -MapWebModToVH [[refarch-integration-inventory-dal.war refarch-integration-inventory-dal.war,WEB-INF/web.xml default_host]]]')"