#Use Ruby-image from Public DockerSite
FROM ruby:2.6.1-stretch

#Directory to place Application
WORKDIR /app

#Install Node.js ver 10.x and Yarn for stable version
#RUN curl -sSfL https://deb.nodesource.com/setup_10.x | bash - \
 #   && curl -sSfL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add  - \
 #   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#list \
  #  && apt-get update \
  #  && apt-get install -y \
  #      nodejs \
  #      yarn   \
  #  && rm -rf /var/lib/apt/lists/*

#Copy Node.js and Yarn from node's image
COPY --from=node:10.16.3-stretch /usr/local/ /usr/local/
COPY --from=node:10.16.3-stretch /opt/ /opt/

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

