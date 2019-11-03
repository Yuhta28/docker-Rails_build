#Use Ruby-image from Public DockerSite
FROM ruby:2.6.1-stretch

#Directory to place Application
WORKDIR /app

#Installed Node.js and Yarn version
#Refer "https://nodejs.org/dist/${NODE_VERSION}/SHASUMS256.txt" to check parameter of NODE_SHA256SUM
#ENV \
#  NODE_VERSION=v10.15.3 \
#  NODE_DISTRO=linux-x64 \
#  NODE_SHA256SUM=faddbe418064baf2226c2fcbd038c3ef4ae6f936eb952a1138c7ff8cfe862438 \
#  YARN_VERSION=1.15.2

#Makw a path
#ENV PATH=/opt/node-${NODE_VERSION}-${NODE_DISTRO}/bin:/opt/yarn-v${YARN_VERSION}/bin:${PATH}

#Install Node.js and Yarn
#RUN curl -sSfLO https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz \
#    && echo "${NODE_SHA256SUM} node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz" | sha256sum -c - \
#    && tar -xJ -f node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz -C /opt \
#    && rm -v node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz \
#    && curl -o - -sSfL https://yarnpkg.com/install.sh | bash -s -- --version ${YARN_VERSION}   \
#    && mv /root/.yarn /opt/yarn-${YARN_VERSION}
#list \
#    && apt-get update \
#    && apt-get install -y \
#        nodejs \
#        yarn   \
#    && rm -rf /var/lib/apt/lists/*

#Copy Node.js and Yarn from node's image
COPY --from=node:10.15.3-stretch /usr/local/ /usr/local/
COPY --from=node:10.15.3-stretch /opt/ /opt/

#Install gem by Bundler
ARG BUNDLE_INSTALL_ARGS="-j 4"
COPY Gemfile Gemfile.lock ./
RUN bundle install ${BUNDLE_INSTALL_ARGS}

#Configure ENTRYPOINT
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

#Copy Application file
COPY . ./

#Configure command and ports to exec server
CMD ["rails", "server", "-b", "0.0.0.0"]
EXPOSE 3000

