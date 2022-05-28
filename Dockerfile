FROM ruby:3.1.2
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list > /dev/null \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir -p /Zeroken

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

CMD bundle exec foreman start