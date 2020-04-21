FROM gmod/apollo:stable

#RUN cd /usr/local/tomcat/webapps/root/jbrowse/plugins
# extract war before tomcat, so we can add plugins to it - probably this should
# be done in the apollo build, not sure how to extend it though

RUN cd /usr/local/tomcat/webapps && \
    mkdir /usr/local/tomcat/webapps/ROOT && \
    unzip /usr/local/tomcat/apollo.war -d /usr/local/tomcat/webapps/ROOT && \
    rm /usr/local/tomcat/apollo.war 


COPY JBrowse/plugins/ /usr/local/tomcat/webapps/ROOT/jbrowse/plugins/

RUN cd /usr/local/tomcat/webapps/ROOT/jbrowse/plugins && \
     unzip \*.zip && \
     rm *.zip && \
     mkdir GCContent MultiBigWig TrackScorePlugin SmallRNAPlugin && \
     mv gccontent-master/* GCContent/ && \
     mv jbplugin-smallrna-master/* SmallRNAPlugin && \
     mv jbplugin-trackscores-master/* TrackScorePlugin && \
     mv multibigwig-master/* MultiBigWig && \
     cd /usr/local/tomcat/webapps/ROOT/jbrowse && \
     bash setup.sh


COPY jbrowse.conf /usr/local/tomcat/webapps/ROOT/jbrowse/
