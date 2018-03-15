FROM sonarqube:alpine
RUN apk add --update curl coreutils supervisor \
# Clean plugins
#  && rm -rf $SONARQUBE_HOME/lib/bundled-plugins/*.jar \
  # install latest (9/19/2017) stock plugins
   && cd $SONARQUBE_HOME/extensions/plugins/ \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-php-plugin/sonar-php-plugin-2.10.0.2087.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-python-plugin/sonar-python-plugin-1.8.0.1496.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.2.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-scm-svn-plugin/sonar-scm-svn-plugin-1.5.0.715.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-3.1.1.5128.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-csharp-plugin/sonar-csharp-plugin-6.4.0.3347.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-flex-plugin/sonar-flex-plugin-2.3.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-4.9.0.9858.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-3.1.1.5128.jar \
#  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-xml-plugin/sonar-xml-plugin-1.4.3.1027.jar \
  # Stock plugins end here
  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-2.2.0.608.jar \
  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-generic-coverage/sonar-generic-coverage-plugin-1.2.jar \
  && curl -sSOL https://github.com/gabrie-allaigre/sonar-gitlab-plugin/releases/download/2.1.0/sonar-gitlab-plugin-2.1.0.jar \
  #&& curl -sSOL https://github.com/SonarQubeCommunity/sonar-sonargraph/releases/download/sonar-sonargraph-plugin-3.5/sonar-sonargraph-plugin-3.5.jar \
  #&& curl -sSOL https://github.com/sonargraph/sonar-sonargraph-integration/releases/download/Release-1.1.4/sonar-sonargraph-integration-1.1.4.jar \
  #&& curl -sSOL https://github.com/stefanrinderle/softvis3d/releases/download/softvis3d-0.6.0/sonar-softvis3d-plugin-0.6.0.jar \
  #&& curl -sSOL https://github.com/racodond/sonar-json-plugin/releases/download/2.1/sonar-json-plugin-2.1.jar \
  #&& curl -sSOL https://github.com/groupe-sii/sonar-web-frontend-plugin/releases/download/v2.1.0/sonar-web-frontend-plugin-2.1.0.jar \
  && rm -rf /var/cache/apk/*
RUN mkdir -p /etc/supervisor/conf.d /var/log/supervisor
COPY supervisor/supervisord.conf /etc/supervisord.conf
COPY supervisor/cron.conf /etc/supervisor/conf.d/cron.conf
COPY supervisor/sonarqube.conf /etc/supervisor/conf.d/sonarqube.conf
COPY backup.sh /opt/sonarqube/bin
COPY crontab /etc/crontabs/root
CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisord.conf"]
