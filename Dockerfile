FROM node:10-alpine
LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"
ENV TERRAFORM_VERSION 0.12.24
ENV CLOUD_SDK_VERSION 285.0.1
ENV CLOUDSDK_PYTHON python3
ENV PATH /google-cloud-sdk/bin:$PATH
RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow curl python3 py3-crcmod libc6-compat openssh-client git gnupg \
  && apk del .pipeline-deps \
  && cd /usr/local/bin \
  && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz
  && gcloud config set core/disable_usage_reporting true \
  && gcloud config set component_manager/disable_update_check true \
  && gcloud config set metrics/environment github_docker_image
