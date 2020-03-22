FROM node:10-alpine
LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"
ENV TERRAFORM_VERSION 0.12.24
RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow \
  && apk del .pipeline-deps \
  && cd /usr/local/bin \
  && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip


ENTRYPOINT [ "terraform" ]
