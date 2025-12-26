FROM fluentd:latest
USER root

RUN ["gem", "install", "elasticsearch", "--no-document"]
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-document"]

# Create logs directory and set permissions
RUN mkdir -p /logs && chown -R fluent:fluent /logs

USER fluent
