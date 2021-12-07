FROM ruby:2.6.7
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /Zeroken
WORKDIR /Zeroken
COPY Gemfile /Zeroken/Gemfile
COPY Gemfile.lock /Zeroken/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /Zeroken

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD rails server -u puma