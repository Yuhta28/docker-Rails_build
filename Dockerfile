#Use Ruby-image from Public DockerSite
FROM ruby:2.6.1-stretch

#Directory to place Application
WORKDIR /app

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
