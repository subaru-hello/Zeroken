git checkout main && git pull origin main && RAILS_ENV=development bundle exec rails assets:precompile && git push heroku main:main
#./deploy.sh