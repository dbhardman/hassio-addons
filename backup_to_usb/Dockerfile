ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache rsync jq

COPY USB_backup..sh /
RUN chmod a+x /USB_backup.sh
CMD [ "/USB_backup.sh" ]