FROM alpine:latest

# Github Actions
LABEL "com.github.actions.name"="Hugo Notes"
LABEL "com.github.actions.description"="Convert my notes into Hugo content"
LABEL "com.github.actions.icon"="file-text"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

