FROM sburn/apache-atlas as stage-atlas

WORKDIR /apache-atlas/conf

ARG ATLAS_PASSWORD

RUN /bin/bash -c "sed -ri \"s/(admin=ADMIN::)(.+)/\1`/bin/echo -n $ADMIN_PASSWORD | /bin/sha256sum | cut -d \" \" -f1`/g\" /apache-atlas/conf/users-credentials.properties"

COPY resources/atlas-application.properties /apache-atlas/conf/atlas-application.properties

FROM sburn/apache-atlas as final

COPY --from=stage-atlas /apache-atlas/conf /apache-atlas/conf

EXPOSE 21000

WORKDIR /apache-atlas/bin

CMD ["/bin/bash", "-c", "/apache-atlas/bin/atlas_start.py; tail -fF /apache-atlas/logs/application.log"]