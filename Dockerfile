FROM ruby:2.7.1
EXPOSE 3000
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY ./vendor/cache ./vendor/cache
RUN bundle install --local
RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs postgresql-client yarn
COPY . /myapp
RUN yarn install --check-files && rails assets:precompile


# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
