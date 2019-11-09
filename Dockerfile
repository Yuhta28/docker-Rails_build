#Use Ruby-image from Public DockerSite
FROM ruby:2.6.1-stretch

#Directory to place Application
WORKDIR /app

#Copy Node.js and Yarn from node's image
COPY --from=node:10.15.3-stretch /usr/local/ /usr/local/
COPY --from=node:10.15.3-stretch /opt/ /opt/

#Install gem by Bundler
ARG BUNDLE_INSTALL_ARGS="-j 4"
COPY Gemfile Gemfile.lock ./
RUN bundle config --local disable_platform_warnings true \
    && bundle install ${BUNDLE_INSTALL_ARGS}

#Install Node package by Yarn
COPY package.json yarn.lock ./
RUN yarn install

#Configure ENTRYPOINT
COPY docker-entrypoint*.sh /
RUN chmod +x /docker-entrypoint*.sh
ENTRYPOINT ["/docker-entrypoint*.sh"]

#Copy Application file
COPY . ./

#Configure command and ports to exec server
CMD ["rails", "server", "-b", "0.0.0.0"]
EXPOSE 3000

